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

func transpose(lines: [String]) -> [String] {
	var transposedLines: [String] = []
	
	for i in 0..<lines[0].count {
		var newLine = ""
		
		for line in lines {
			newLine.append(Array(line)[i])
		}
		
		transposedLines.append(newLine)
	}
	
	return transposedLines
}

let example = """
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
""".components(separatedBy: "\n")

var transposedInput = transpose(lines: load(file: "Input"))
var input = transposedInput

for (i, line) in input.enumerated() {
	guard line.contains("O") else { continue }
	
	var lineComponents = line.map { String($0) }
	
	for x in 1..<lineComponents.count {
		if lineComponents[x] == "O" {
			for i in stride(from: x, to: 0, by: -1) {
				if lineComponents[i - 1] == "." {
					let temp = lineComponents[i]
					lineComponents[i] = lineComponents[i - 1]
					lineComponents[i - 1] = temp
				} else {
					break
				}
			}
		}
	}
	
	input[i] = lineComponents.joined()
}

var output = 0
for line in input {
	guard line.contains("O") else { continue }
	
	for (i, char) in line.enumerated() {
		if char == "O" {
			output += transposedInput.count - i
		}
	}
}
print(output)

// 108935

//let x = 10
//let y = [[9], [1, 0], [2, 2, 1]]
//let z = [[9], [1, 0], [2, 2, 1]]
//
//var hasher1 = Hasher()
//hasher1.combine(x)
//let hash1 = hasher1.finalize()
//
//var hasher2 = Hasher()
//hasher2.combine(y)
//let hash2 = hasher2.finalize()
//
//var hasher3 = Hasher()
//hasher3.combine(z)
//let hash3 = hasher3.finalize()
//
//
//print(hash1)
//print(hash2)
//print(hash3)


// start brute forcing
// save hash after every cycle
// if hash occured before cycle detected
// add i * loop to cycle counter
// calculate remaining cycles
