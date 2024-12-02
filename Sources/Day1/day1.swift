import Foundation

let fileName = "input.txt"
let currentDirectoryURL = URL(
    fileURLWithPath: FileManager.default.currentDirectoryPath + "/../../data/01")
let fileURL = currentDirectoryURL.appendingPathComponent(fileName)

func readFile() -> String {
    do {
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        return fileContents
    } catch {
        print(error.localizedDescription)
        return ""
    }
}

func writeFile(result: Int) {
    let fileName = "output.txt"
    let currentDirectoryURL = URL(
        fileURLWithPath: FileManager.default.currentDirectoryPath + "/output")
    let fileURL = currentDirectoryURL.appendingPathComponent(fileName)

    do {
        try String(result).write(to: fileURL, atomically: true, encoding: .utf8)
    } catch {
        print(error.localizedDescription)
    }
}
@MainActor
func day1() {
    let lines = readFile().components(separatedBy: "\n")

    var column1: [Int] = []
    var column2: [Int] = []

    for line in lines {
        let columns = line.components(separatedBy: "   ")
        if let first = Int(columns[0]), let second = Int(columns[1]) {
            column1.append(first)
            column2.append(second)
        }
    }

    let sortedColumn1 = column1.sorted()
    let sortedColumn2 = column2.sorted()

    let differences = zip(sortedColumn1, sortedColumn2).map { abs($0 - $1) }
    let _ = differences.reduce(0, +)

    var occurences: [Int] = []

    for number in column1 {
        let count = column2.filter { $0 == number }.count * number
        occurences.append(count)
    }

    print(occurences.reduce(0, +))
}
