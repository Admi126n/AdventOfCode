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

struct Instruction {
	let dir: String
	let meters: Int
	
	init(from line: String) {
		let components = line.components(separatedBy: " ")
		
		guard components.count == 3 else { fatalError("Wrong input") }
		
		self.dir = components[0]
		self.meters = Int(components[1])!
	}
}

let example = """
R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)
""".components(separatedBy: "\n")

let input = example
//let input = load(file: "Input")

// get mine size start
var width = 0
var maxWidth = 0
var minWidth = 0

var height = 0
var maxHeight = 0
var minHeight = 0

for line in input {
	let instruction = Instruction(from: line)
	
	if instruction.dir == "R" {
		width += instruction.meters
	} else if instruction.dir == "L" {
		width -= instruction.meters
	} else if instruction.dir == "D" {
		height += instruction.meters
	} else {
		height -= instruction.meters
	}

	maxWidth = max(maxWidth, width)
	minWidth = min(minWidth, width)
	maxHeight = max(maxHeight, height)
	minHeight = min(minHeight, height)
}
// get mine size end


// create mine start
var mine: [[String]] = []

for line in 0...maxHeight + abs(minHeight) {
	mine.append([])
	for row in 0...maxWidth + abs(minWidth) {
		mine[line].append(".")
	}
}
// create mine end


// create path start
var i = abs(minHeight)
var j = abs(minWidth)

for (x, line) in input.enumerated() {
	let instruction = Instruction(from: line)
	
	if instruction.dir == "R" {
		for k in 0..<instruction.meters {
			j += 1
			mine[i][j] = "#"
		}
	} else if instruction.dir == "L" {
		for k in 0..<instruction.meters {
			j -= 1
			mine[i][j] = "#"
		}
	} else if instruction.dir == "D" {
		for k in 0..<instruction.meters {
			i += 1
			mine[i][j] = "#"
		}
	} else {
		for k in 0..<instruction.meters {
			i -= 1
			mine[i][j] = "#"
		}
	}
}
// create path end

var counter = 0
for line in mine {
	for char in line {
		if char == "#" {
			counter += 1
		}
	}
}

print(counter)

// 70216 too heigh
