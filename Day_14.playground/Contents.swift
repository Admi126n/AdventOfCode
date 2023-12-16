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

// MARK: - Part two

func makeCycle(_ arg: [String]) -> [String] {
	var l = moveNorth(arg)
	l = moveWest(l)
	l = moveSouth(l)
	l = moveEast(l)
	
	return l
}

func calculateResult(_ lines: [String]) -> Int {
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

func partTwo(_ input: [String]) -> Int {
	var lines = input
	// get cycle len
	var hashes: [Int] = []
	var cycleLen = 0
	var cycleStart = 0
	for i in 0... {
		var hasher = Hasher()
		let temp = makeCycle(lines)
		
		hasher.combine(temp)
		let hash = hasher.finalize()
		
		if hashes.contains(where: { $0 == hash }) {
			cycleStart = hashes.firstIndex(of: hash)!
			cycleLen = i - hashes.firstIndex(of: hash)!
			break
		}
		
		lines = temp
		hashes.append(hash)
	}
	
	let x = (1000000000 - cycleStart) / cycleLen
	let missingCycles = 1000000000 - cycleStart - x * cycleLen
	
	for i in 0..<missingCycles {
		lines = makeCycle(lines)
	}
	
	return calculateResult(lines)
}

//partTwo(load(file: "Input"))
