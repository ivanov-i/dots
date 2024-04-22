#!/usr/bin/env rust-script

#![allow(non_snake_case)]

use std::env;
use std::fs;
use std::io::prelude::*;
use std::net::{TcpListener, TcpStream};
use std::os::unix::fs::PermissionsExt;
use std::path::PathBuf;
use std::process::Command;

fn main() {
    let listener = TcpListener::bind("0.0.0.0:9498").unwrap();
    for stream in listener.incoming() {
        let stream = stream.unwrap();
        handle_connection(stream);
    }
}

fn handle_connection(mut stream: TcpStream) {
    let freeSpaceStr = get_free_disk_space().unwrap_or_else(|e| e);
    let trashSizeStr = get_trash_size().unwrap_or_else(|e| e);

    let freeSpaceInBlocks: i64 = freeSpaceStr.trim_end_matches(|c: char| !c.is_numeric()).parse().unwrap();
    let freeSpace = freeSpaceInBlocks * 512;
    let trashSize: i64 = trashSizeStr.trim_end_matches(|c: char| !c.is_numeric()).parse().unwrap();
    let availableSpace = freeSpace + trashSize;

    let freeSpaceHuman = toHumanReadable(freeSpace);
    let trashSizeHuman = toHumanReadable(trashSize);
    let availableSpaceHuman = toHumanReadable(availableSpace);

    let batteries_output = call_batteries_script().unwrap_or_else(|e| e);

    let response = format!(
        "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=UTF-8\r\n\r\n\
        <!DOCTYPE html>\
        <html lang=\"en\">\
        <head>\
        <meta charset=\"UTF-8\">\
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\
        <title>System Info</title>\
        </head>\
        <body>\
        <h1>Available Space</h1>\
        <p>{}</p>\
        <h1>Free Disk Space</h1>\
        <p>{}</p>\
        <h1>Trash Size</h1>\
        <p>{}</p>\
        <h1>Batteries</h1>\
        <pre>{}</pre>\
        </body>\
        </html>\r\n",
        availableSpaceHuman, freeSpaceHuman, trashSizeHuman, batteries_output
    );
    stream.write(response.as_bytes()).unwrap();
    stream.flush().unwrap();
}

fn toHumanReadable(bytes: i64) -> String {
    let units = ["B", "KB", "MB", "GB", "TB", "PB", "EB"];
    let mut unitIndex = 0;
    let mut size = bytes as f64;
    while size >= 1024.0 && unitIndex < units.len() - 1 {
        size /= 1024.0;
        unitIndex += 1;
    }
    format!("{:.1} {}", size, units[unitIndex])
}

fn get_free_disk_space() -> Result<String, String> {
    let output = Command::new("df")
        .arg("/")
        .output()
        .map_err(|e| e.to_string())?;
    if !output.status.success() {
        let error_message = String::from_utf8_lossy(&output.stderr);
        return Err(format!("df command failed: {}", error_message));
    }
    Ok(parse_free_space(&String::from_utf8_lossy(&output.stdout)))
}

fn get_trash_size() -> Result<String, String> {
    let output = Command::new("du")
        .arg("-s")
        .arg(env::var("HOME").unwrap() + "/.Trash")
        .output()
        .map_err(|e| e.to_string())?;
    if !output.status.success() {
        let error_message = String::from_utf8_lossy(&output.stderr);
        return Err(format!("du command failed: {}", error_message));
    }
    let outputString = String::from_utf8_lossy(&output.stdout);
    let firstWord = outputString.split_whitespace().next().unwrap();
    Ok(firstWord.to_string())
}

fn parse_free_space(output: &str) -> String {
    let lines: Vec<&str> = output.split('\n').collect();
    if lines.len() > 1 {
        let columns: Vec<&str> = lines[1].split_whitespace().collect();
        if columns.len() >= 4 {
            return columns[3].to_string();
        }
    }
    "Unavailable".to_string()
}

fn call_batteries_script() -> Result<String, String> {
    let home_dir = env::var("HOME").map_err(|e| e.to_string())?;
    let script_path = PathBuf::from(home_dir).join("bin/batteries.sh");
    if !script_path.exists() {
        return Err(format!("Script not found at path: {:?}", script_path));
    }
    if !is_executable(&script_path) {
        return Err(format!("Script is not executable: {:?}", script_path));
    }
    let output = Command::new(&script_path)
        .output()
        .map_err(|e| e.to_string())?;
    if !output.status.success() {
        let error_message = String::from_utf8_lossy(&output.stderr);
        return Err(format!("Script execution failed: {}", error_message));
    }
    Ok(String::from_utf8_lossy(&output.stdout).to_string())
}

fn is_executable(path: &PathBuf) -> bool {
    fs::metadata(path)
        .map(|metadata| metadata.permissions().mode() & 0o111 != 0)
        .unwrap_or(false)
}

