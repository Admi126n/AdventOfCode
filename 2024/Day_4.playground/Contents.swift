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

extension String {

	var length: Int {
		return count
	}

	subscript (i: Int) -> String {
		return self[i ..< i + 1]
	}

	func substring(fromIndex: Int) -> String {
		return self[min(fromIndex, length) ..< length]
	}

	func substring(toIndex: Int) -> String {
		return self[0 ..< max(0, toIndex)]
	}

	subscript (r: Range<Int>) -> String {
		let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
											upper: min(length, max(0, r.upperBound))))
		let start = index(startIndex, offsetBy: range.lowerBound)
		let end = index(start, offsetBy: range.upperBound - range.lowerBound)
		return String(self[start ..< end])
	}
}

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	var output = 0
	
	for i in 0..<input.count {
		for j in 0..<input[i].count {
			
			guard input[i][j] == "X" else { continue }
			
			// N
			if i - 3 >= 0, input[i - 1][j] == "M" && input[i - 2][j] == "A" && input[i - 3][j] == "S" {
				output += 1
			}
			
			// NE
			if i - 3 >= 0 && j + 3 < input[i].count, input[i - 1][j + 1] == "M" && input[i - 2][j + 2] == "A" && input[i - 3][j + 3] == "S" {
				output += 1
			}
			
			// E
			if j + 3 < input[i].count, input[i][j + 1] == "M" && input[i][j + 2] == "A" && input[i][j + 3] == "S" {
				output += 1
			}
			
			// SE
			if i + 3 < input.count && j + 3 < input[i].count, input[i + 1][j + 1] == "M" && input[i + 2][j + 2] == "A" && input[i + 3][j + 3] == "S" {
				output += 1
			}
			
			// S
			if i + 3 < input.count, input[i + 1][j] == "M" && input[i + 2][j] == "A" && input[i + 3][j] == "S" {
				output += 1
			}
			
			// SW
			if i + 3 < input.count && j - 3 >= 0, input[i + 1][j - 1] == "M" && input[i + 2][j - 2] == "A" && input[i + 3][j - 3] == "S" {
				output += 1
			}
			
			// W
			if j - 3 >= 0, input[i][j - 1] == "M" && input[i][j - 2] == "A" && input[i][j - 3] == "S" {
				output += 1
			}
			
			// NW
			if i - 3 >= 0 && j - 3 >= 0, input[i - 1][j - 1] == "M" && input[i - 2][j - 2] == "A" && input[i - 3][j - 3] == "S" {
				output += 1
			}
		}
		
		print("")
	}
	
	return output
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partOne(input)

// MARK: - Part two

func partTwo(_ input: [String]) -> Int {
	var output = 0
	
	for i in 1..<input.count - 1 {
		for j in 1..<input[i].count - 1 {
			guard input[i][j] == "A" else { continue }
			
			// M S
			//  A
			// M S
			if input[i - 1][j + 1] == "S" && input[i + 1][j + 1] == "S" && input[i + 1][j - 1] == "M" && input[i - 1][j - 1] == "M" {
				output += 1
			}
			
			if input[i - 1][j + 1] == "M" && input[i + 1][j + 1] == "M" && input[i + 1][j - 1] == "S" && input[i - 1][j - 1] == "S" {
				output += 1
			}
			
			if input[i - 1][j + 1] == "S" && input[i + 1][j + 1] == "M" && input[i + 1][j - 1] == "M" && input[i - 1][j - 1] == "S" {
				output += 1
			}
			
			if input[i - 1][j + 1] == "M" && input[i + 1][j + 1] == "S" && input[i + 1][j - 1] == "S" && input[i - 1][j - 1] == "M" {
				output += 1
			}
			
		}
	}
	
	return output
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partTwo(input)

