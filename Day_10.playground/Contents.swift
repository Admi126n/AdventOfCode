import Cocoa

func load(file: String) -> [[String.Element]] {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath) else {
		fatalError("Cannot decode file")
	}
	
	return content.components(separatedBy: "\n").map { Array($0) }
}

// MARK: - Part one

func getStartCoords(_ input: [[String.Element]]) -> (row: Int, column: Int)? {
	for (row, line) in input.enumerated() {
		if let column = line.firstIndex(of: "S") {
			return (row, column)
		}
	}
	
	return nil
}

func getFirstPipe(_ input: [[String.Element]], _ row: Int, _ column: Int) -> (pipe: String, row: Int, column: Int)? {
	if row > 0, ["|", "7", "F"].contains(input[row - 1][column]) {  // down
		return (String(input[row - 1][column]), row - 1, column)
	} else if row < input.count - 1, ["|", "L", "J"].contains(input[row + 1][column]) {  // up
		return (String(input[row + 1][column]), row + 1, column)
	} else if column > 0, ["-", "L", "F"].contains(input[row][column - 1]) {  // left
		return (String(input[row][column - 1]), row, column - 1)
	} else if column < input.count - 1, ["-", "J", "7"].contains(input[row][column + 1]) {  // right
		return (String(input[row][column + 1]), row, column + 1)
	}
	
	return nil
}

func partOne(_ input: [[String.Element]]) -> Int {
	let (row, column) = getStartCoords(input)!
	
	var f = (pipe: "S", row: row, column: column)
	var s = getFirstPipe(input, row, column)!
	var counter = 0
	
	repeat {
		counter += 1
		switch s.pipe {
		case "|":
			let temp = s
			if f.row < s.row {
				s = (String(input[s.row + 1][s.column]), s.row + 1, s.column)  // go south
			} else {
				s = (String(input[s.row - 1][s.column]), s.row - 1, s.column)  // go north
			}
			f = temp
		case "L":
			let temp = s
			if f.row < s.row {
				s = (String(input[s.row][s.column + 1]), s.row, s.column + 1)  // go east
			} else {
				s = (String(input[s.row - 1][s.column]), s.row - 1, s.column)  // go north
			}
			f = temp
		case "-":
			let temp = s
			if f.column < s.column {
				s = (String(input[s.row][s.column + 1]), s.row, s.column + 1)  // go east
			} else {
				s = (String(input[s.row][s.column - 1]), s.row, s.column - 1)  // go west
			}
			f = temp
		case "J":
			let temp = s
			if f.column < s.column {
				s = (String(input[s.row - 1][s.column]), s.row - 1, s.column)  // go north
			} else {
				s = (String(input[s.row][s.column - 1]), s.row, s.column - 1)  // go west
			}
			f = temp
		case "7":
			let temp = s
			if f.column < s.column {
				s = (String(input[s.row + 1][s.column]), s.row + 1, s.column)  // go south
			} else {
				s = (String(input[s.row][s.column - 1]), s.row, s.column - 1)  // go west
			}
			f = temp
		case "F":
			let temp = s
			if f.row > s.row {
				s = (String(input[s.row][s.column + 1]), s.row, s.column + 1)  // go east
			} else {
				s = (String(input[s.row + 1][s.column]), s.row + 1, s.column)  // go south
			}
			f = temp
		default:
			fatalError("Wrong input")
		}
	} while s.pipe != "S"
	
	return counter / 2 + 1
}

//partOne(load(file: "Input"))

// MARK: - Part two


// 4
let example1 = """
...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
...........
""".components(separatedBy: "\n").map { Array($0) }

// 4
let example2 = """
..........
.S------7.
.|F----7|.
.||OOOO||.
.||OOOO||.
.|L-7F-J|.
.|II||II|.
.L--JL--J.
..........
""".components(separatedBy: "\n").map { Array($0) }

// 8
let example3 = """
.F----7F7F7F7F-7....
.|F--7||||||||FJ....
.||.FJ||||||||L7....
FJL7L7LJLJ||LJ.L-7..
L--J.L7...LJS7F-7L7.
....F-J..F7FJ|L7L7L7
....L7.F7||L7|.L7L7|
.....|FJLJ|FJ|F7|.LJ
....FJL-7.||.||||...
....L---J.LJ.LJLJ...
""".components(separatedBy: "\n").map { Array($0) }

// 10
let example4 = """
FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJIF7FJ-
L---JF-JLJIIIIFJLJJ7
|F|F-JF---7IIIL7L|7|
|FFJF7L7F-JF7IIL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L
""".components(separatedBy: "\n").map { Array($0) }

let input = example1
let (row, column) = getStartCoords(input)!

var f = (pipe: "S", row: row, column: column)
var s = getFirstPipe(input, row, column)!
var loop: [(pipe: String, row: Int, column: Int)] = []

repeat {
	loop.append(f)
	switch s.pipe {
	case "|":
		let temp = s
		if f.row < s.row {
			s = (String(input[s.row + 1][s.column]), s.row + 1, s.column)  // go south
		} else {
			s = (String(input[s.row - 1][s.column]), s.row - 1, s.column)  // go north
		}
		f = temp
	case "L":
		let temp = s
		if f.row < s.row {
			s = (String(input[s.row][s.column + 1]), s.row, s.column + 1)  // go east
		} else {
			s = (String(input[s.row - 1][s.column]), s.row - 1, s.column)  // go north
		}
		f = temp
	case "-":
		let temp = s
		if f.column < s.column {
			s = (String(input[s.row][s.column + 1]), s.row, s.column + 1)  // go east
		} else {
			s = (String(input[s.row][s.column - 1]), s.row, s.column - 1)  // go west
		}
		f = temp
	case "J":
		let temp = s
		if f.column < s.column {
			s = (String(input[s.row - 1][s.column]), s.row - 1, s.column)  // go north
		} else {
			s = (String(input[s.row][s.column - 1]), s.row, s.column - 1)  // go west
		}
		f = temp
	case "7":
		let temp = s
		if f.column < s.column {
			s = (String(input[s.row + 1][s.column]), s.row + 1, s.column)  // go south
		} else {
			s = (String(input[s.row][s.column - 1]), s.row, s.column - 1)  // go west
		}
		f = temp
	case "F":
		let temp = s
		if f.row > s.row {
			s = (String(input[s.row][s.column + 1]), s.row, s.column + 1)  // go east
		} else {
			s = (String(input[s.row + 1][s.column]), s.row + 1, s.column)  // go south
		}
		f = temp
	default:
		fatalError("Wrong input")
	}
} while s.pipe != "S"

for (i, row) in input.enumerated() {
	for (j, char) in row.enumerated() {
		//		let x =
		
		let down = loop.filter { $0.column == j && $0.row > i }.count
		let up = loop.filter { $0.column == j && $0.row < i }.count
		let left = loop.filter { $0.row == i && $0.column < j }.count
		let right = loop.filter { $0.row == i && $0.column > j }.count
		
//		print(char, i, j, down, up, left, right)
//		if !(down * up * left * right).isMultiple(of: 2) {
//			print(char, i, j)
//			print(down, up, left, right)
//			print()
//		}
		if down > 0 && up > 0 && left > 0 && right > 0 {
			if down % 2 != 0 || up % 2 != 0 || left % 2 != 0 || right % 2 != 0 {
				print(char, i, j)
				print(down, up, left, right)
				print()
			}
		}
	}
}
