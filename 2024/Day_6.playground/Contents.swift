import Cocoa

func load(file: String) -> [String] {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath, encoding: .ascii) else {
		fatalError("Cannot decode file")
	}
	
	return content.split(separator: "\n").map { String($0) }
}

enum Direction {
	case north
	case east
	case south
	case west
}

func switchDirection(_ direction: Direction) -> Direction {
	switch direction {
	case .north: return .east
	case .east: return .south
	case .south: return .west
	case .west: return .north
	}
}

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	let map = input.map { Array($0) }
	
	var visited: Set<[Int]> = []
	var direction = Direction.north
	
	var currentPos: (x: Int, y: Int) = (0, 0)
	
	// get start position
	for y in 0..<map.count {
		for x in 0..<map[y].count {
			if map[y][x] == "^" {
				currentPos = (x, y)
			}
		}
	}
	
	loop: while true {
		visited.insert([currentPos.x, currentPos.y])
		
		switch direction {
		case .north:
			if currentPos.y - 1 < 0 {
				break loop
			} else if map[currentPos.y - 1][currentPos.x] == "#" {
				direction = switchDirection(direction)
			} else {
				currentPos.y = currentPos.y - 1
			}
		case .east:
			if currentPos.x + 1 >= map[currentPos.y].count {
				break loop
			} else if map[currentPos.y][currentPos.x + 1] == "#" {
				direction = switchDirection(direction)
			} else {
				currentPos.x = currentPos.x + 1
			}
		case .south:
			if currentPos.y + 1 >= map.count {
				break loop
			} else if map[currentPos.y + 1][currentPos.x] == "#" {
				direction = switchDirection(direction)
			} else {
				currentPos.y = currentPos.y + 1
			}
		case .west:
			if currentPos.x - 1 < 0 {
				break loop
			} else if map[currentPos.y][currentPos.x - 1] == "#" {
				direction = switchDirection(direction)
			} else {
				currentPos.x = currentPos.x - 1
			}
		}
	}
	
	return visited.count
}

let input = load(file: "Input")
let result = partOne(input)
