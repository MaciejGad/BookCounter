import Foundation

func getarg(_ key: String) -> String? {
    UserDefaults.standard.string(forKey: key)
}

func getarg(_ key: String, orDie message: String, file: StaticString = #file, line: UInt = #line) -> String {
    guard let value = getarg(key) else {
        if Brisk.haltOnError {
            fatalError(message, file: file, line: line)
        } else {
            exit(message, code: 1)
        }
    }
    return value
}

func isarg(_ key: String) -> Bool {
    ProcessInfo.processInfo.arguments.contains { $0 == "-\(key)" }
}

func getenv(_ key: String, orDie message: String, file: StaticString = #file, line: UInt = #line) -> String {
    guard let value = ProcessInfo.processInfo.environment[key] else {
        if Brisk.haltOnError {
            fatalError(message, file: file, line: line)
        } else {
            exit(message, code: 1)
        }
    }
    return value
}

func setarg(_ key: String, _ value: String?) {
    UserDefaults.standard.set(value, forKey: key)
}

