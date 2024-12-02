import Foundation

struct InputReader {
    static func readInput(day: Int, fileName: String = "input.txt") -> String {
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let fileURL =
            currentDirectoryURL
            .appendingPathComponent("Data/\(String(format: "Day%d", day))")
            .appendingPathComponent(fileName)

        do {
            return try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            print("Error reading input for day \(day): \(error.localizedDescription)")
            return ""
        }
    }
}
