@MainActor
func day2() {
    let input = InputReader.readInput(day: 2, fileName: "input.txt")
    let lines = input.components(separatedBy: "\n")

    var levels: [Int] = []
    var safe: [Bool] = []

    for line in lines {
        levels = line.split(separator: " ").compactMap { Int($0) }
        safe.append(isSafe(levels: levels))
        print("\(line): \(isSafe(levels: levels))")
    }

    func isSafe(levels: [Int]) -> Bool {

        var direction: String? = nil

        guard levels.count > 1 else { return true }

        for level in 1..<levels.count {
            let difference = levels[level] - levels[level - 1]
            if !(difference >= -3 && difference <= 3 && difference != 0) {
                return false
            }

            let currentDirection = difference > 0 ? "increasing" : "decreasing"

            if direction == nil {
                direction = currentDirection
            } else if direction != currentDirection {
                return false
            }

        }
        return true
    }

    print(safe.filter { $0 == true }.count)
}
