import Cocoa

func load(file: String) -> String {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath) else {
		fatalError("Cannot decode file")
	}
	
	return content
}

// MARK: - Part one

func partOne(_ input: String) -> Int {
	var output = 0
	
	for line in input.components(separatedBy: "\n") {
		var first: Int?
		var last: Int?
		
		for char in line {
			if let letterInt = Int(String(char)) {
				if first == nil {
					first = letterInt
				}
				
				last = letterInt
			}
		}
		
		let result = "\(first!)\(last!)"
		output += Int(result)!
	}
	
	return output
}

//let file = load(file: "Input")
//print(partOne(file))

// MARK: - Part two

let digits = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
let digitsDict = ["one": 1,
				  "two": 2,
				  "three": 3,
				  "four": 4,
				  "five": 5,
				  "six": 6,
				  "seven": 7,
				  "eight": 8,
				  "nine": 9]

func getFirstDigit(_ input: String) -> Int? {
	var first: Int?
	var mutatingLine = input
	
	for char in input {
		if first == nil {
			for digit in digits {
				if mutatingLine.hasPrefix(digit) {
					first = digitsDict[digit]!
				}
			}
		}
		
		if let letterInt = Int(String(char)) {
			if first == nil {
				first = letterInt
			}
		}
		
		mutatingLine.removeFirst()
	}
	
	return first
}

func getLastDigit(_ input: String) -> Int? {
	var last: Int?
	var mutatingLine = input
	
	for _ in 0..<input.count {
		if last == nil {
			for digit in digits {
				if mutatingLine.hasSuffix(digit) {
					last = digitsDict[digit]!
				}
			}
		}
		
		if let letterInt = Int(String(mutatingLine.last!)) {
			if last == nil {
				last = letterInt
			}
		}
		
		mutatingLine.removeLast()
	}
	
	return last
}
	
func partTwo(_ input: String) -> Int {
	var output = 0

	for line in input.components(separatedBy: "\n") {
		let first = getFirstDigit(line)!
		let last = getLastDigit(line)!
		
		let result = Int("\(first)\(last)")!
		output += result
	}
	
	return output
}

//let file = load(file: "Input")
//print(partTwo(file))
