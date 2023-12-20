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

let x = ["red": 12, "green": 13, "blue": 14]

func partOne(_ lines: [String]) -> Int {
	var output = 0
	
	for constLine in lines {
		var addLine = true
		var line = constLine.replacingOccurrences(of: ",", with: "")
		line = line.replacingOccurrences(of: ";", with: "")
		line = line.replacingOccurrences(of: ":", with: "")
		let lineComponents = line.components(separatedBy: " ")
		
		for (index, el) in lineComponents.enumerated() {
			if let num = x[el] {
				addLine = Int(lineComponents[index - 1])! <= num
			}
			
			if !addLine { break }
		}
		
		if addLine {
			output += Int(lineComponents[1])!
		}
	}
	
	return output
}

let example = """
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
""".components(separatedBy: "\n")

//print(partOne(load(file: "Input")))
partOne(example)

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
