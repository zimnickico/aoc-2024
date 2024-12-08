struct Antinode: Hashable {
    let x: Int
    let y: Int
}

func day8() {
    let input = InputReader.readInput(day: 8, fileName: "input.txt")
    var grid = input.split(separator: "\n").map { Array($0) }

    let rows = grid.count
    let cols = grid[0].count

    var antennas: [Character: [(Int, Int)]] = [:]
    var antinodes = Set<Antinode>()

    for row in 0..<rows {
        for col in 0..<cols {
            let cell = grid[row][col]
            if cell != "." {
                antennas[cell, default: []].append((row, col))
            }
        }
    }

    for (_, coords) in antennas {
        for i in 0..<coords.count {
            for j in (i + 1)..<coords.count {
                let diff = (coords[j].0 - coords[i].0, coords[j].1 - coords[i].1)

                for (_idx, _dir) in [(i, -1), (j, 1)] {
                    var pos = coords[_idx]
                    while pos.0 >= 0 && pos.0 < rows && pos.1 >= 0 && pos.1 < cols {
                        antinodes.insert(Antinode(x: pos.0, y: pos.1))
                        pos = (pos.0 + diff.0 * _dir, pos.1 + diff.1 * _dir)
                    }
                }
            }
        }
    }
    print(antinodes.count)

}
