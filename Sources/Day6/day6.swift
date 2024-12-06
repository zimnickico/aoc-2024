struct Position: Hashable {
    let x: Int
    let y: Int
}

@MainActor
func day6() {
    let input = InputReader.readInput(day: 6, fileName: "input.txt")
    var grid = input.split(separator: "\n").map { Array($0) }

    let rows = grid.count
    let cols = grid[0].count
    let directions = [(-1, 0), (0, 1), (1, 0), (0, -1)]

    var directionIndex = 0
    var sx = 0
    var sy = 0

    for (i, row) in grid.enumerated() {
        if let j = row.firstIndex(where: { "^>v<".contains($0) }) {
            sx = i
            sy = j
            directionIndex = "^>v<".firstIndex(of: grid[i][j])!.utf16Offset(in: "^>v<")
            grid[i][j] = "."
            break
        }
    }

    func simulated(ox: Int, oy: Int) -> Bool {

        var test = grid
        test[ox][oy] = "#"

        var x = sx
        var y = sy
        var dir = directionIndex
        var visitedState: [String: Bool] = [:]
        visitedState["\(x),\(y),\(dir)"] = true

        while true {
            let dx = directions[dir].0
            let dy = directions[dir].1
            let nx = x + dx
            let ny = y + dy

            if nx < 0 || nx >= rows || ny < 0 || ny >= cols {
                return false
            }

            if test[nx][ny] == "#" {
                dir = (dir + 1) % 4
            } else {
                x = nx
                y = ny
            }

            let currentState = "\(x),\(y),\(dir)"
            if visitedState[currentState] != nil {
                print(validObstructionCount)
                return true
            }
            visitedState[currentState] = true
        }
    }

    var validObstructionCount = 0
    for x in 0..<rows {
        for y in 0..<cols {
            if grid[x][y] == "#" || (x == sx && y == sy) {
                continue
            }

            if simulated(ox: x, oy: y) {
                print(validObstructionCount)
                validObstructionCount += 1
            }
        }
        print(validObstructionCount)
    }

    var visited = Set<Position>()
    visited.insert(Position(x: sx, y: sy))

    var x = sx
    var y = sy

    while true {
        let dx = directions[directionIndex].0
        let dy = directions[directionIndex].1
        let nextX = x + dx
        let nextY = y + dy

        if nextX < 0 || nextX >= rows || nextY < 0 || nextY >= cols {
            break
        }

        if grid[nextX][nextY] == "#" {
            directionIndex = (directionIndex + 1) % 4
        } else {
            x = nextX
            y = nextY
            visited.insert(Position(x: x, y: y))
        }
    }
    print(visited.count)
}
