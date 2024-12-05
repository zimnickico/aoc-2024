@MainActor

func day4() {
    let input = InputReader.readInput(day: 4, fileName: "input.txt")
    let grid: [[Character]] = input.split(separator: "\n").map { Array($0) }
    var total = 0

    for row in 0..<grid.count {
        for col in 0..<grid[0].count {
            total += searchGrid(x: row, y: col)
        }
    }

    print(total)

    func searchGrid(x: Int, y: Int) -> Int {

        let moves = [
            (x: 0, y: 1),
            (x: 0, y: -1),
            (x: 1, y: 0),
            (x: -1, y: 0),
            (x: 1, y: 1),
            (x: 1, y: -1),
            (x: -1, y: 1),
            (x: -1, y: -1),
        ]

        let xmas = 4
        let rows = grid.count
        let cols = grid[0].count

        let word = Array("XMAS")

        var count = 0

        for move in moves {
            var x: Int = x
            var y: Int = y
            var match = true

            for i in 0..<word.count {
                let newX = x + i * move.x
                let newY = y + i * move.y

                if newX < 0 || newY < 0 || newX >= rows || newY >= cols
                    || grid[newX][newY] != word[i]
                {
                    match = false
                    break
                }
            }
            if match {
                count += 1
            }
        }
        return count
    }

}
