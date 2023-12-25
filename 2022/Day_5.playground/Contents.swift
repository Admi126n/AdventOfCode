import Cocoa

func load(file: String) -> [String] {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath) else {
		fatalError("Cannot decode file")
	}
	
	return content.components(separatedBy: "\n\n")
}

func getShip(from lines: [String]) -> [[String]] {
	var ship: [[String]] = Array(repeating: [], count: 9)
	
	for line in lines {
		let l = line.replacingOccurrences(of: "\t", with: "    ")
		for i in stride(from: 0, to: l.count, by: 4) {
			if Array(l)[i] == "[" {
				ship[i / 4].append(String(Array(l)[i + 1]))
			}
		}
	}

	return ship.map { Array($0.reversed()) }
}

func getProcedures(from lines: [String]) -> [(count: Int, from: Int, to: Int)] {
	var output: [(count: Int, from: Int, to: Int)] = []
	
	for line in lines {
		let nums = line.components(separatedBy: " ").compactMap { Int($0) }
		
		output.append(((count: nums[0], from: nums[1] - 1, to: nums[2] - 1)))
	}
	
	return output
}

func getResult(from ship: [[String]]) -> String {
	var output = ""
	
	for line in ship {
		output.append(line.last!)
	}
	
	return output
}

// MARK: - part one

func perform(procedures: [(count: Int, from: Int, to: Int)], on ship: inout [[String]]) {
	for procedure in procedures {
		for _ in 0..<procedure.count {
			ship[procedure.to].append(ship[procedure.from].popLast()!)
		}
	}
}

func partOne(_ input: [String]) -> String {
	var ship = getShip(from: input[0].components(separatedBy: "\n"))
	let procedures = getProcedures(from: input[1].components(separatedBy: "\n"))
	
	perform(procedures: procedures, on: &ship)

	return getResult(from: ship)
}

//partOne(load(file: "Input"))

// MARK: - Part two

func perform(newProcedures: [(count: Int, from: Int, to: Int)], on ship: inout [[String]]) {
	for procedure in newProcedures {
		let toMove = ship[procedure.from].suffix(procedure.count)
		let remaining = ship[procedure.from].count - procedure.count
		
		ship[procedure.from] = Array(ship[procedure.from].prefix(remaining))
		
		for el in toMove {
			ship[procedure.to].append(el)
		}
	}
}

func partTwo(_ input: [String]) -> String {
	
	let input = load(file: "Input")
	
	var ship = getShip(from: input[0].components(separatedBy: "\n"))
	let procedures = getProcedures(from: input[1].components(separatedBy: "\n"))
	
	perform(newProcedures: procedures, on: &ship)
	
	return getResult(from: ship)
	
}

//partTwo(load(file: "Input"))
