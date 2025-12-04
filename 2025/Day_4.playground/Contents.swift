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
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
""".split(separator: "\n").map { Array($0) }

// MARK: - Part one

func partOne(_ input: [[Character]]) -> Int {
	var output = 0
	
	for i in 0..<input.count {
		for j in 0..<input.count {
			guard input[i][j] == "@" else { continue }
			var tmp = 0
			
			if i > 0 {
				if input[i - 1][j] == "@" { tmp += 1 }
				if j > 0 { if input[i - 1][j - 1] == "@" { tmp += 1 } }
				if j + 1 < input.count { if input[i - 1][j + 1] == "@" { tmp += 1} }
			}
			
			if i + 1 < input.count {
				if input[i + 1][j] == "@" { tmp += 1 }
				if j > 0 { if input[i + 1][j - 1] == "@" { tmp += 1} }
				if j + 1 < input.count { if input[i + 1][j + 1] == "@" { tmp += 1 } }
			}
			
			if j > 0 { if input[i][j - 1] == "@" { tmp += 1 } }
			if j + 1 < input.count { if input[i][j + 1] == "@" { tmp += 1} }
			
			
			if tmp < 4 {
				output += 1
			}
		}
	}
	
	return output
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partOne(input)

// MARK: - Part two

func partTwo(_ input: [[Character]]) -> Int {
	var copy = input
	var rollsRemoved = false
	var output = 0
	
	repeat {
		rollsRemoved = false
		for i in 0..<input.count {
			for j in 0..<input.count {
				guard copy[i][j] == "@" else { continue }
				var tmp = 0
				
				if i > 0 {
					if copy[i - 1][j] == "@" { tmp += 1 }
					if j > 0 { if copy[i - 1][j - 1] == "@" { tmp += 1 } }
					if j + 1 < copy.count { if copy[i - 1][j + 1] == "@" { tmp += 1} }
				}
				
				if i + 1 < copy.count {
					if copy[i + 1][j] == "@" { tmp += 1 }
					if j > 0 { if copy[i + 1][j - 1] == "@" { tmp += 1} }
					if j + 1 < copy.count { if copy[i + 1][j + 1] == "@" { tmp += 1 } }
				}
				
				if j > 0 { if copy[i][j - 1] == "@" { tmp += 1 } }
				if j + 1 < copy.count { if copy[i][j + 1] == "@" { tmp += 1} }
				
				if tmp < 4 {
					output += 1
					copy[i][j] = "."
					rollsRemoved = true
				}
			}
		}
	} while rollsRemoved
	
	return output
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partTwo(input)
