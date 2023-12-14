import Cocoa

func load(file: String) -> [String] {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath) else {
		fatalError("Cannot decode file")
	}
	
	return content.components(separatedBy: "\n")
}

func moveNorth(_ input: [String]) -> [String] {
	var lines: [[String]] = []
	for line in input {
		lines.append(line.map { String($0) })
	}
	
	for i in 0..<input[0].count {  // columns
		for j in 1..<input.count {  // rows
			if lines[j][i] == "O" {
				for k in stride(from: j, to: 0, by: -1) {
					if lines[k - 1][i] == "." {
						let temp = lines[k - 1][i]
						lines[k - 1][i] = lines[k][i]
						lines[k][i] = temp
					} else {
						break
					}
				}
			}
		}
	}
	
	var output: [String] = []
	for line in lines {
		output.append(line.joined())
	}
	
	return output
}

func moveSouth(_ input: [String]) -> [String] {
	var lines: [[String]] = []
	for line in input {
		lines.append(line.map { String($0) })
	}
	
	for i in 0..<input[0].count {  // columns
		for j in stride(from: input[i].count - 2, through: 0, by: -1) {  // rows
			if lines[j][i] == "O" {
				for k in j..<lines[i].count - 1 {
					if lines[k + 1][i] == "." {
						let temp = lines[k + 1][i]
						lines[k + 1][i] = lines[k][i]
						lines[k][i] = temp
					} else {
						break
					}
				}
			}
		}
	}
	
	var output: [String] = []
	for line in lines {
		output.append(line.joined())
	}
	
	return output
}

func moveWest(_ input: [String]) -> [String] {
	var lines = input
	
	for (i, line) in lines.enumerated() {
		guard line.contains("O") else { continue }
		
		var lineComponents = line.map { String($0) }
		
		for j in 1..<lineComponents.count {
			if lineComponents[j] == "O" {
				for k in stride(from: j, to: 0, by: -1) {
					if lineComponents[k - 1] == "." {
						let temp = lineComponents[k]
						lineComponents[k] = lineComponents[k - 1]
						lineComponents[k - 1] = temp
					} else {
						break
					}
				}
			}
		}
		
		lines[i] = lineComponents.joined()
	}
	
	return lines
}

func moveEast(_ input: [String]) -> [String] {
	var lines = input
	
	for (i, line) in lines.enumerated() {
		guard line.contains("O") else { continue }
		
		var lineComponents = line.map { String($0) }
		for j in stride(from: lineComponents.count - 2, through: 0, by: -1) {
			if lineComponents[j] == "O" {
				for k in j..<lineComponents.count - 1 {
					if lineComponents[k + 1] == "." {
						let temp = lineComponents[k]
						lineComponents[k] = lineComponents[k + 1]
						lineComponents[k + 1] = temp
					} else {
						break
					}
				}
			}
		}
		
		lines[i] = lineComponents.joined()
	}
	
	return lines
}

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	let lines = moveNorth(input)
	var output = 0
	for (i, line) in lines.enumerated() {
		guard line.contains("O") else { continue }

		for char in line {
			if char == "O" {
				output += lines.count - i
			}
		}
	}
	
	return output
}

//partOne(load(file: "Input"))

let example = """
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
""".components(separatedBy: "\n")

let input = example
//let input = load(file: "Input")

func makeCycle(_ arg: [String]) -> [String] {
	var l = moveNorth(arg)
	l = moveWest(l)
	l = moveSouth(l)
	l = moveEast(l)
	
	return l
}

var lines: [String] = input

var result: [String] = []
var hashes: [Int] = []
for i in 0... {
	var hasher = Hasher()
	lines = makeCycle(lines)
	hasher.combine(lines)
	let hash = hasher.finalize()
	
	if hashes.contains(where: { $0 == hash }) {
		print(i + 1)
		result = lines
		break
	}
	
	hashes.append(hash)
}

//result = makeCycle(result)

var output = 0
for (i, line) in result.enumerated() {
	guard line.contains("O") else { continue }

	for char in line {
		if char == "O" {
			output += result.count - i
		}
	}
}

print(output)
