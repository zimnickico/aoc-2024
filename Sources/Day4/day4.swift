@MainActor

func day4() {
    let input = InputReader.readInput(day: 4, fileName: "input.txt")
    let grid: [[Character]] = input.split(separator: "\n").map { Array($0) }
    var total = 0

    for row in 0..<grid.count {
        for col in 0..<grid[0].count {
            total += searchX(x: row, y: col)
        }
    }

    print(total)

    // This function is the 2nd part of day 4, but it's probably not the best approach.
    // I hate it, might rewrite later?
    func searchX(x: Int, y: Int) -> Int {
        let rows = grid.count
        let cols = grid[0].count

        if grid[x][y] != "A" {
            return 0
        }

        let topLeftBottomRight = [(-1, -1), (1, 1)]
        let topRightBottomLeft = [(-1, 1), (1, -1)]

        func countMAndS(positions: [(Int, Int)]) -> (mCount: Int, sCount: Int) {
            var mCount = 0
            var sCount = 0

            for (dx, dy) in positions {
                let newX = x + dx
                let newY = y + dy

                if newX >= 0 && newX < rows && newY >= 0 && newY < cols {
                    let char = grid[newX][newY]
                    if char == "M" {
                        mCount += 1
                    } else if char == "S" {
                        sCount += 1
                    }
                }
            }

            return (mCount, sCount)
        }

        let arm1 = countMAndS(positions: topLeftBottomRight)
        let arm2 = countMAndS(positions: topRightBottomLeft)

        if arm1.mCount == 1 && arm1.sCount == 1 && arm2.mCount == 1 && arm2.sCount == 1 {
            return 1
        }

        return 0
    }

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
