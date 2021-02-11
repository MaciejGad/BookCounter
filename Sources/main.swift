import Foundation

#if DEBUG
Brisk.haltOnError = true
#endif

let usage = "Usage: /script -userId 1234 -name 2k21"

let userId = getarg("userId", orDie: usage)
let name = getarg("name", orDie: usage)
let baseUrlString = getenv("baseUrl", orDie: "Please setup base URL environment variable")
verbosePrint("User id: \(userId)")
verbosePrint("Shelf name: \(name)")

let shelfes = [Shelf].init(url: "\(baseUrlString)/user/\(userId)/shelves")

verbosePrint("Load:")
shelfes.forEach { verbosePrint($0) }
guard let found = (shelfes.first { $0.name == name }) else {
    fatalError("Can't find \(name) among: \(shelfes.map { $0.name })")
}

verbosePrint("Found:")
verbosePrint(found)

var outputList: [Output] = []
let outputFile = "reading.json"
if fileExists(outputFile) {
    verbosePrint("Reading from \(outputFile)")
    outputList = decode(file: outputFile, as: [Output].self, dates: .iso8601)
    outputList.forEach { verbosePrint($0) }
}
let newOutput: Output = .init(date: .init(), books: found.books)
verbosePrint("Adding new output:")
verbosePrint(newOutput)
outputList.append(newOutput)
outputList.jsonData(dates: .iso8601).write(to: outputFile)
