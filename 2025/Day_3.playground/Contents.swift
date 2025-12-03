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
987654321111111
811111111111119
234234234234278
818181911112111
""".components(separatedBy: "\n")

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	var output = 0
	
	for line in input {
		let numbers = line.compactMap { String($0) }
		var first = 1
		var firstIndex = -1
		var second = 1
		
		for i in 0..<(numbers.count - 1) {
			if Int(numbers[i])! > first {
				first = Int(numbers[i])!
				firstIndex = i
			}
		}
		
		for i in (firstIndex + 1)..<numbers.count {
			if Int(numbers[i])! > second {
				second = Int(numbers[i])!
			}
		}
		
		output += first * 10 + second
	}
	
	return output
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partOne(input)

// MARK: - Part two

func partTwo(_ input: [String]) -> Int {
	var output = 0
	
	for line in input {
		let numbers = line.compactMap { String($0) }
		var indexes: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
		var batteries: [Int] = Array(repeating: 0, count: 12)
		
		for batteryNumber in 0..<12 {
			for index in indexes[batteryNumber]...(numbers.count - (12 - batteryNumber)) {
				if Int(numbers[index])! > batteries[batteryNumber] {
					batteries[batteryNumber] = Int(numbers[index])!
					indexes[batteryNumber + 1] = index + 1
				}
			}
		}
		
		let str: String = batteries.reduce("") { partialResult, battery in
			partialResult + String(battery)
		}
		
		output += Int(str)!
	}
	
	return output
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partTwo(input)
