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
			
			if i_bottom_row < lines.count {
			} else {
				break
			}
			
			if lines[i_upper_row] == lines[i_bottom_row] {
			} else {
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

//partOne(load(file: "Input"))

// MARK: - Part two

let example1 = """
########.
...#.#.##
#..#####.
#..#.....
..##.#...
..##...#.
..##...#.
..##.#...
#.##.....
#..#####.
...#.#.##
########.
##.##.###
....#####
..#.....#
..#.....#
....#####
""".components(separatedBy: "\n\n")  // i + 1 == 15

