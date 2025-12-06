import Cocoa

func load(file: String) -> String {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath, encoding: .ascii) else {
		fatalError("Cannot decode file")
	}
	
	return content
}

let example = """
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
""".split(separator: "\n").map { $0.split(separator: " ") }

// MARK: - Part one

func partOne(_ input: [[String.SubSequence]]) -> Int {
	let columnsCount = input[0].count
	var output = 0
	
	for column in 0..<columnsCount {
		let operation = input.last![column]
		let closure: (Int, Int) -> Int = operation == "+" ? { $0 + $1 } : { $0 * $1 }
		var tmp = operation == "+" ? 0 : 1
		
		for row in 0..<(columnsCount - 1) {
			tmp = closure(tmp, Int(input[row][column])!)
		}
		
		output += tmp
	}
	
	return output
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partOne(input)

let example2 = """
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
""".components(separatedBy: "\n")

// MARK: - Part two

func getColumns(from line: String) -> [Int] {
	var lengths: [Int] = []
	var currentLength = 0

	for char in line {
		currentLength += 1
		if char == "*" || char == "+" {
			if currentLength > 1 {
				lengths.append(currentLength - 1)
			}
			currentLength = 1
		}
	}

	if currentLength > 0 {
		lengths.append(currentLength)
	}

	return lengths
}

func partTwo(_ input: [String]) -> Int {
	var output = 0
	let columnsSizes = getColumns(from: input.last!)
	var copy: [[String]] = []
	let operations = input.last!.split(separator: " ")
	
	for line in 0..<(input.count - 1) {
		copy.append([])
		var index = input[line].startIndex
		for column in columnsSizes {
			let end = input[line].index(index, offsetBy: column)
			let substring = String(input[line][index..<end])
			copy[line].append(substring)
			index = end
		}
	}

	// remove space from all values beside last one
	for index in 0..<copy.count {
		for row in 0..<(copy[index].count - 1) {
			_ = copy[index][row].removeLast()
		}
	}
	
	for column in 0..<copy[0].count {
		var numbersPopped = false
		var stringNum = ""
		let operation = operations[column]
		let closure: (Int, Int) -> Int = operation == "+" ? { $0 + $1 } : { $0 * $1 }
		var tmp = operation == "+" ? 0 : 1
		
		repeat {
			numbersPopped = false
			stringNum = ""
			
			for row in 0..<copy.count {
				if let value = copy[row][column].popLast() {
					stringNum += String(value)
				}
			}
			
			if !stringNum.isEmpty {
				numbersPopped = true
				tmp = closure(tmp, Int(stringNum.replacingOccurrences(of: " ", with: ""))!)
			}
		} while numbersPopped
		
		output += tmp
	}
	
	return output
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partTwo(input)
