//
//  Settings.swift
//  Terminal
//
//  Created by Paul Hudson on 20/02/2020.
//  Copyright © 2020 Hacking with Swift. All rights reserved.
//

import Foundation

#if canImport(Cocoa)
import Cocoa
#endif

enum Brisk {
    #if DEBUG
    static var haltOnError = true
    #else
    static var haltOnError = false
    #endif
    
    static let verbose = isarg("v")
}

func printOrDie(_ message: String) {
    if Brisk.haltOnError {
        fatalError(message)
    } else {
        errorPrint(message)
    }
}


func exit(_ message: String = "", code: Int = 0) -> Never {
    if !message.isEmpty {
        errorPrint(message)
    }
    exit(Int32(code))
}

#if canImport(Cocoa)
func open(_ thing: String) {
    NSWorkspace.shared.openFile(thing)
}
#endif

/// Executes a bash command as is and returns the output
/// This is using `/usr/bin/env bash` (bash-5.0) since `/bin/bash` refers to older bash-3.2 on OSX
/// - Parameters:
///   - command: bash command as it would be typed in terminal. e.g. `ls -lah`
/// - Returns: `String` console output
func bash(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.arguments = ["bash", "-c", command]
    task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    do {
        try task.run()
    } catch {
        printOrDie("Failed to run \(command): \(error.localizedDescription)")
    }
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!

    return output
}
