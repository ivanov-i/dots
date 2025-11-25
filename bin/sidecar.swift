#!/usr/bin/env swift

import Foundation
import Darwin

enum SidecarMode {
  case list
  case connect(String)
  case disconnect(String)
}

func stderr(_ text: String) {
  FileHandle.standardError.write(Data((text + "\n").utf8))
}

func fail(_ text: String, code: Int32 = 1) -> Never {
  stderr(text)
  exit(code)
}

func parseMode() -> SidecarMode {
  let args = Array(CommandLine.arguments.dropFirst())
  guard let first = args.first else {
    fail("usage: sidecar.swift devices | connect <device-name> | disconnect <device-name>")
  }

  switch first.lowercased() {
  case "devices":
    return .list
  case "connect":
    guard args.count >= 2 else {
      fail("connect requires <device-name>")
    }
    return .connect(args[1])
  case "disconnect":
    guard args.count >= 2 else {
      fail("disconnect requires <device-name>")
    }
    return .disconnect(args[1])
  default:
    fail("unknown command: \(first)")
  }
}

func openSidecarCore() {
  let path = "/System/Library/PrivateFrameworks/SidecarCore.framework/SidecarCore"
  guard dlopen(path, RTLD_LAZY) != nil else {
    fail("failed to load SidecarCore framework")
  }
}

func sidecarManager() -> NSObject {
  guard let cls = NSClassFromString("SidecarDisplayManager") as? NSObject.Type else {
    fail("SidecarDisplayManager class not found")
  }
  let selector = NSSelectorFromString("sharedManager")
  guard let mgr = cls.perform(selector)?.takeUnretainedValue() as? NSObject else {
    fail("failed to obtain Sidecar manager instance")
  }
  return mgr
}

func sidecarDevices(_ manager: NSObject) -> [NSObject] {
  let selector = NSSelectorFromString("devices")
  guard let raw = manager.perform(selector)?.takeUnretainedValue() as? [NSObject] else {
    fail("failed to query Sidecar devices")
  }
  return raw
}

func deviceName(_ device: NSObject) -> String {
  let selector = NSSelectorFromString("name")
  guard let raw = device.perform(selector)?.takeUnretainedValue() as? String else {
    fail("failed to read Sidecar device name")
  }
  return raw
}

func pickDevice(_ devices: [NSObject], name: String) -> NSObject? {
  let target = name.lowercased()
  return devices.first {
    deviceName($0).lowercased() == target
  }
}

func invoke(
  _ manager: NSObject,
  selectorName: String,
  device: NSObject,
  action: String
) {
  let selector = NSSelectorFromString(selectorName)
  let group = DispatchGroup()
  group.enter()

  let completion: @convention(block) (NSError?) -> Void = { error in
    defer { group.leave() }

    if let error = error {
      stderr("sidecar \(action) failed: \(error)")
      exit(4)
    } else {
      print(action == "connect" ? "connected" : "disconnected")
    }
  }

  _ = manager.perform(selector, with: device, with: completion)
  group.wait()
}

func main() {
  let mode = parseMode()
  openSidecarCore()
  let manager = sidecarManager()
  let devices = sidecarDevices(manager)

  if devices.isEmpty {
    fail("no Sidecar devices reachable", code: 2)
  }

  switch mode {
  case .list:
    for d in devices {
      print(deviceName(d))
    }
  case let .connect(name):
    guard let device = pickDevice(devices, name: name) else {
      fail("no Sidecar device named '\(name)'", code: 3)
    }
    invoke(manager, selectorName: "connectToDevice:completion:", device: device, action: "connect")
  case let .disconnect(name):
    guard let device = pickDevice(devices, name: name) else {
      fail("no Sidecar device named '\(name)'", code: 3)
    }
    invoke(manager, selectorName: "disconnectFromDevice:completion:", device: device, action: "disconnect")
  }
}

main()
