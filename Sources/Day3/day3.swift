import Foundation

@MainActor
func day3() {

    let input = InputReader.readInput(day: 3, fileName: "input.txt")

    let pattern = #"(do\(\)|don't\(\)|mul\(\d+,\d+\))"#
    let regex = try! NSRegularExpression(pattern: pattern)

    var sum = 0
    var enable = true

    let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))

    for match in matches {

        let range = Range(match.range, in: input)!
        let instruction = String(input[range])

        if instruction == "do()" {
            enable = true
        } else if instruction == "don't()" {
            enable = false
        } else if instruction.starts(with: "mul") {

            if enable {
                let math = instruction.dropFirst(4).dropLast().split(separator: ",").map {
                    Int($0)!
                }
                sum += math[0] * math[1]
            }
        }

    }
    print(sum)
}
