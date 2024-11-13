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
    let freeSpaceStr = get_free_disk_space(&"/".to_string()).unwrap_or_else(|e| e);
    let trashPath = env::var("HOME").unwrap() + "/.Trash";
    let trashSizeStr = get_trash_size(&trashPath.to_string()).unwrap_or_else(|e| e);

    let freeSpaceInBlocks: i64 = freeSpaceStr.trim_end_matches(|c: char| !c.is_numeric()).parse().unwrap();
    let freeSpace = freeSpaceInBlocks * 512;
    let trashSizeInBlocks: i64 = trashSizeStr.trim_end_matches(|c: char| !c.is_numeric()).parse().unwrap();
    let trashSize = trashSizeInBlocks * 512;
    let availableSpace = freeSpace + trashSize;

    let freeSpaceHuman = toHumanReadable(freeSpace);
    let trashSizeHuman = toHumanReadable(trashSize);
    let availableSpaceHuman = toHumanReadable(availableSpace);

    let skipVolumes = Vec::from([String::from("Backup"), String::from(".timemachine"), String::from("macintosh hd")]);
    let mut volumes: Vec<(String, String, String, String)> = Vec::new();
    for volume in fs::read_dir("/Volumes").unwrap() {
        let volume = volume.unwrap();
        let volume_name = volume.file_name().into_string().unwrap();
        if skipVolumes.iter().any(|s| volume_name.to_lowercase().contains(&s.to_lowercase())) {
            continue;
        }
        let path = volume.path().to_str().unwrap().to_string();
        let freeSpaceStr = get_free_disk_space(&path).unwrap_or_else(|e| e);
        let uid = env::var("UID").unwrap_or_else(|_| "501".to_string());
        let trashPath = path + "/.Trashes/" + uid.as_str();
        let trashSizeStr = get_trash_size(&trashPath).unwrap_or_else(|_| 0.to_string());

        let freeSpaceInBlocks: i64 = freeSpaceStr.trim_end_matches(|c: char| !c.is_numeric()).parse().unwrap();
        let freeSpace = freeSpaceInBlocks * 512;
        let trashSizeInBlocks: i64 = trashSizeStr.trim_end_matches(|c: char| !c.is_numeric()).parse().unwrap();
        let trashSize = trashSizeInBlocks * 512;
        let availableSpace = freeSpace + trashSize;

        let freeSpaceHuman = toHumanReadable(freeSpace);
        let trashSizeHuman = toHumanReadable(trashSize);
        let availableSpaceHuman = toHumanReadable(availableSpace);

        volumes.push((volume_name, availableSpaceHuman, freeSpaceHuman, trashSizeHuman));
    }

    let mut volumes_table = String::new();
    volumes_table.push_str("<table>");
    volumes_table.push_str("<tr><th>Volume Name</th><th>Total Available</th><th>Free Space</th><th>Trash Size</th></tr>");
    for volume in volumes {
        volumes_table.push_str("<tr>");
        volumes_table.push_str(&format!("<td>{}</td>", volume.0));
        volumes_table.push_str(&format!("<td>{}</td>", volume.1));
        volumes_table.push_str(&format!("<td>{}</td>", volume.2));
        volumes_table.push_str(&format!("<td>{}</td>", volume.3));
        volumes_table.push_str("</tr>");
    }

    let batteries_output = call_batteries_script().unwrap_or_else(|e| e);

    let response = format!(
        "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=UTF-8\r\n\r\n<!DOCTYPE html>\n\
        <html lang=\"en\">
        <head>
            <meta charset=\"UTF-8\">
            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
            <title>System Info</title>
            <style>
                body {{
                    font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, sans-serif;
                    line-height: 1.6;
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 20px;
                    background: #f5f5f7;
                    color: #1d1d1f;
                }}
                h1 {{
                    color: #1d1d1f;
                    border-bottom: 2px solid #0066cc;
                    padding-bottom: 8px;
                    margin-top: 30px;
                }}
                table {{
                    width: 100%;
                    border-collapse: collapse;
                    margin: 20px 0;
                    background: white;
                    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                    border-radius: 8px;
                }}
                th, td {{
                    padding: 12px 15px;
                    text-align: left;
                    border-bottom: 1px solid #eee;
                }}
                th {{
                    background: #f8f8f8;
                    font-weight: 600;
                }}
                tr:last-child td {{
                    border-bottom: none;
                }}
                pre {{
                    background: white;
                    padding: 15px;
                    border-radius: 8px;
                    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                    overflow-x: auto;
                }}
                p {{
                    background: white;
                    padding: 15px;
                    border-radius: 8px;
                    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                    margin: 10px 0;
                }}
                tr:hover {{
                    background: #f5f5f7;
                }}
            </style>
        </head>
        <body>
            <h1>System Storage Overview</h1>
            <div class=\"stats\">
                <h1>Main Drive Status</h1>
                <p><strong>Available Space:</strong> {}</p>
                <p><strong>Free Disk Space:</strong> {}</p>
                <p><strong>Trash Size:</strong> {}</p>
                
                <h1>Battery Status</h1>
                <pre>{}</pre>
                
                <h1>Connected Volumes</h1>
                {}
            </div>
        </body>
        </html>",
        availableSpaceHuman, freeSpaceHuman, trashSizeHuman, batteries_output, volumes_table
        );
    if let Err(e) = stream.write(response.as_bytes()) {
        eprintln!("Error writing to stream: {}", e);
        return;
    }

    if let Err(e) = stream.flush() {
        eprintln!("Error flushing stream: {}", e);
        return;
    }

    if let Err(e) = stream.shutdown(std::net::Shutdown::Both) {
        eprintln!("Error shutting down stream: {}", e);
    }
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

fn get_free_disk_space(path: &String) -> Result<String, String> {
    let output = Command::new("df")
        .arg(path)
        .output()
        .map_err(|e| e.to_string())?;
    if !output.status.success() {
        let error_message = String::from_utf8_lossy(&output.stderr);
        return Err(format!("df command failed: {}", error_message));
    }
    Ok(parse_free_space(&String::from_utf8_lossy(&output.stdout)))
}

fn get_trash_size(path: &String) -> Result<String, String> {
    let output = Command::new("du")
        .arg("-s")
        .arg(path)
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

