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

@frozen
enum Operation {
	case and
	case or
}

func getResult(_ input: [String], operation: Operation) -> Int {
	var result = 0
	
	for line in input {
		let numbers = line.components(separatedBy: ",").flatMap { $0.components(separatedBy: "-").compactMap { Int($0) } }
		
		let range1 = numbers[0]...numbers[1]
		let range2 = numbers[2]...numbers[3]
		
		switch operation {
		case .and:
			if range1.contains(numbers[2]) && range1.contains(numbers[3]) {
				result += 1
			} else if range2.contains(numbers[0]) && range2.contains(numbers[1]) {
				result += 1
			}
		case .or:
			if range1.contains(numbers[2]) || range1.contains(numbers[3]) {
				result += 1
			} else if range2.contains(numbers[0]) || range2.contains(numbers[1]) {
				result += 1
			}
		}
	}
	
	return result
}

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	getResult(input, operation: .and)
}

partOne(load(file: "Input"))

// MARK: - Part two

func partTwo(_ input: [String]) -> Int {
	getResult(input, operation: .or)
}

partTwo(load(file: "Input"))
