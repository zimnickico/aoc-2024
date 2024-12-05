@MainActor
func day5() {

    let input = InputReader.readInput(day: 5, fileName: "input.txt")
    let sections = input.components(separatedBy: "\n\n")

    let rulesString = sections[0].components(separatedBy: "\n").map { $0 }
    let updates = sections[1].components(separatedBy: "\n").map { line in
        line.split(separator: ",").map { Int($0)! }
    }

    let rules = rulesString.map { rule -> (Int, Int) in
        let parts = rule.split(separator: "|").map { Int($0)! }
        return (parts[0], parts[1])
    }

    func validate(_ update: [Int]) -> Bool {
        let page = Dictionary(uniqueKeysWithValues: update.enumerated().map { ($1, $0) })
        for (before, after) in rules {
            if let beforePage = page[before], let afterPage = page[after], beforePage > afterPage {
                return false
            }
        }
        return true
    }

    var incorrectUpdates: [[Int]] = []

    for update in updates {
        if !validate(update) {
            incorrectUpdates.append(update)
        }
    }

    func reorder(_ update: [Int]) -> [Int] {
        update.sorted { page1, page2 in
            rules.contains { $0 == (page1, page2) }
        }
    }

    var middle = 0

    func midde() -> Int {

        for update in incorrectUpdates {
            let corrected = reorder(update)
            let middleIndex = corrected.count / 2
            middle += corrected[middleIndex]

        }
        return middle
    }

    print(midde())

}
