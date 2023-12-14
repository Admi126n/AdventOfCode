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

// MARK: - Part pne

func getHorizontalLine(from lines: [String]) -> Int? {
	for i in 1..<lines.count {
		var flag = true
		
		for j in 0..<i {
			let i_upper_row = i - j - 1
			let i_bottom_row = i + j
			
			if i_bottom_row >= lines.count {
				break
			}
			
			if lines[i_upper_row] != lines[i_bottom_row] {
				flag = false
			}
		}
		
		if flag {
			return i * 100
		}
	}
	
	return nil
}

func getVerticalLine(from lines: [String]) -> Int? {
	var transposedLines: [String] = []
	
	for i in 0..<lines[0].count {
		var newLine = ""
		
		for line in lines {
			newLine.append(Array(line)[i])
		}
		
		transposedLines.append(newLine)
	}
	
	if let result = getHorizontalLine(from: transposedLines) {
		return result / 100
	}
	
	return nil
}

func partOne(_ input: [String]) -> Int {
	var result = 0
	for pattern in input {
		let lines = pattern.components(separatedBy: "\n")
		
		if let horizontal = getHorizontalLine(from: lines) {
			result += horizontal
		} else if let vertical = getVerticalLine(from: lines) {
			result += vertical
		}
	}
	
	return result
}

//partOne(load(file: "Input"))  // 33 975

// MARK: - Part two

func getDiffs(arg1: [String.Element], arg2: [String.Element]) -> [Int] {
	var diffs: [Int] = []
	for i in 0..<arg1.count {
		if arg1[i] != arg2[i] {
			diffs.append(i)
		}
	}
	return diffs
}

func flipElement(at index: Int, _ line: [String.Element]) -> String {
	var temp = line
	
	if line[index] == "." {
		temp[index] = "#"
	} else {
		temp[index] = "."
	}
	
	var output = ""
	for el in temp {
		output += String(el)
	}
	
	return output
}

func getHorizontal(from lines: [String]) -> Int? {
	for i in 1..<lines.count {
		var flag = true
		
		for j in 0..<i {
			let i_upper_row = i - j - 1
			let i_bottom_row = i + j
			
			if i_bottom_row >= lines.count {
				break
			}
			
			var upperLine = lines[i_upper_row]
			var lowerLine = lines[i_bottom_row]
			
			let linesDiff = getDiffs(arg1: Array(upperLine), arg2: Array(lowerLine))
			
			if linesDiff.count == 1 {
				upperLine = flipElement(at: linesDiff[0], Array(upperLine))
			}
			
			if upperLine != lowerLine {
				flag = false
			}
		}
		
		if flag {
			return i * 100
		}
	}
	
	return nil
}

func getVertical(from lines: [String]) -> Int? {
	var transposedLines: [String] = []
	
	for i in 0..<lines[0].count {
		var newLine = ""
		
		for line in lines {
			newLine.append(Array(line)[i])
		}
		
		transposedLines.append(newLine)
	}
	
	if let result = getHorizontal(from: transposedLines) {
		return result / 100
	}
	
	return nil
}

let example = """
#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#

.#.##.#.#
.##..##..
.#.##.#..
#......##
#......##
.#.##.#..
.##..##.#

#..#....#
###..##..
.##.#####
.##.#####
###..##..
#..#....#
#..##...#
""".components(separatedBy: "\n\n")

//let input = example[1].components(separatedBy: "\n")

//getHorizontal(from: input)
//getDiffs(arg1: Array(input[0]), arg2: Array(input[2]))

func partTwo(_ input: [String]) -> Int {
	var result = 0
	for pattern in input {
		let lines = pattern.components(separatedBy: "\n")
		
		if let vertical = getVertical(from: lines) {
			result += vertical
		} else if let horizontal = getHorizontal(from: lines) {
			result += horizontal
		}
	}
	
	return result
}

print(partTwo(load(file: "Input")))

//print(partTwo(example))

// 8445  // too low
// 36822  // too high
