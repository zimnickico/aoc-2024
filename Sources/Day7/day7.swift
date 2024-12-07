func day7() {
    let input = InputReader.readInput(day: 7, fileName: "input.txt")
    let lines = input.components(separatedBy: "\n")

    var total = 0

    func generateOperators(_ count: Int) -> [[String]] {
        let ops = ["+", "*"]
        if count == 0 {
            return [[]]
        } else {
            return generateOperators(count - 1).flatMap {
                partial in ops.map { partial + [$0] }
            }
        }
    }

    func evaluateEq(_ numbers: [Int], _ ops: [String]) -> Int? {
        guard numbers.count == ops.count + 1 else { return nil }
        var result = numbers[0]
        for op in 0..<ops.count {
            if ops[op] == "+" {
                result += numbers[op + 1]
            } else if ops[op] == "*" {
                result *= numbers[op + 1]
            }
        }
        return result
    }

    for line in lines {
        let eq = line.components(separatedBy: ": ")
        let value = Int(eq[0])!
        let numbers = eq[1].split(separator: " ").compactMap { Int($0) }

        let opsCombination = generateOperators(numbers.count - 1)
        for ops in opsCombination {
            if let result = evaluateEq(numbers, ops), result == value {
                total += value
                break
            }
        }

    }
    print(total)

}
