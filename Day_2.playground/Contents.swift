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

func partOne(_ lines: [String]) -> Int {
	var output = 0
	
	for constLine in lines {
		var addLine = true
		var line = constLine.replacingOccurrences(of: ",", with: "")
		line = line.replacingOccurrences(of: ";", with: "")
		line = line.replacingOccurrences(of: ":", with: "")
		let lineComponents = line.components(separatedBy: " ")
		
		for (index, el) in lineComponents.enumerated() {
			if el == "red" {
				addLine = Int(lineComponents[index - 1])! <= 12
			} else if el == "green" {
				addLine = Int(lineComponents[index - 1])! <= 13
			} else if el == "blue" {
				addLine = Int(lineComponents[index - 1])! <= 14
			}
			
			if !addLine { break }
		}
		
		if addLine {
			output += Int(lineComponents[1])!
		}
	}
	
	return output
}

//print(partOne(load(file: "Input")))

// MARK: - Part Two

func partTwo(_ lines: [String]) -> Int {
	var output = 0
	
	for constLine in lines {
		var line = constLine.replacingOccurrences(of: ",", with: "")
		line = line.replacingOccurrences(of: ";", with: "")
		line = line.replacingOccurrences(of: ":", with: "")
		let lineComponents = line.components(separatedBy: " ")
		
		var red = 0
		var green = 0
		var blue = 0
		
		for (index, el) in lineComponents.enumerated() {
			if el == "red" {
				red = max(red, Int(lineComponents[index - 1])!)
			} else if el == "green" {
				green = max(green, Int(lineComponents[index - 1])!)
			} else if el == "blue" {
				blue = max(blue, Int(lineComponents[index - 1])!)
			}
		}
		
		output += red * green * blue
	}
	
	return output
}

//partTwo(load(file: "Input"))
