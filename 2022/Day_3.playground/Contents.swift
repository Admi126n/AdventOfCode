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

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	var result = 0
	
	for line in input {
		for char in line.prefix(line.count / 2) {
			if line.suffix(line.count / 2).contains(char) {
				let letter = Character(extendedGraphemeClusterLiteral: char)
				
				if letter.asciiValue! >= 97 {
					result += Int(letter.asciiValue!) - 96
				} else {
					result += Int(letter.asciiValue!) - 38
				}
				
				break
			}
		}
	}
	
	return result
}

//partOne(load(file: "Input"))

// MARK: - Part two

func partTwo(_ input: [String]) -> Int {
	var result = 0
	
	for i in stride(from: 0, to: input.count - 2, by: 3) {
		for char in input[i] {
			if input[i + 1].contains(char) && input[i + 2].contains(char) {
				let letter = Character(extendedGraphemeClusterLiteral: char)
				
				if letter.asciiValue! >= 97 {
					result += Int(letter.asciiValue!) - 96
				} else {
					result += Int(letter.asciiValue!) - 38
				}
				
				break
			}
		}
	}
	
	return result
}

//partTwo(load(file: "Input"))
