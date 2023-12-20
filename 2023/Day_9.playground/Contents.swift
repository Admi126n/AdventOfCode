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

func getDiffs(from line: [Int]) -> [[Int]] {
	var diffTable: [[Int]] = [line]
	
	repeat {
		var x: [Int] = []
		
		for i in 0..<diffTable.last!.count - 1 {
			x.append(diffTable.last![i + 1] - diffTable.last![i])
		}
		diffTable.append(x)
		
	} while !diffTable.last!.allSatisfy({ $0 == 0 })
	
	return diffTable
}

// MARK: - Part one

func getResultOne(from diffTable: [[Int]]) -> Int {
	var result = 0
	for i in stride(from: diffTable.count - 1, through: 0, by: -1) {
		result += diffTable[i].last!
	}
	
	return result
}

func partOne(_ input: [String]) -> Int {
	var output = 0
	
	for line in input {
		let components = line.components(separatedBy: " ").compactMap { Int($0) }
		let diffTable = getDiffs(from: components)
		
		output += getResultOne(from: diffTable)
	}
	
	return output
}

//partOne(load(file: "Input"))

// MARK: - Part two

func getResultTwo(from diffTable: [[Int]]) -> Int {
	var result = 0
	for i in stride(from: diffTable.count - 1, through: 0, by: -1) {
		result = diffTable[i].first! - result
	}
	
	return result
}

func partTwo(_ input: [String]) -> Int {
	var output = 0
	for line in input {
		let components = line.components(separatedBy: " ").compactMap { Int($0) }
		let diffTable = getDiffs(from: components)
		
		output += getResultTwo(from: diffTable)
	}
	
	return output
}

//partTwo(load(file: "Input"))
