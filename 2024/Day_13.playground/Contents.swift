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

struct Machine {
	struct Coordinates {
		var x: Int
		var y: Int
	}
	
	var a: Coordinates
	var b: Coordinates
	var prize: Coordinates
	
	init(lines: [String]) {
		let rangesA = lines[0].ranges(of: /\d+/)
		self.a = Coordinates(x: Int(lines[0][rangesA[0]])!, y: Int(lines[0][rangesA[1]])!)

		let rangesB = lines[1].ranges(of: /\d+/)
		self.b = Coordinates(x: Int(lines[1][rangesB[0]])!, y: Int(lines[1][rangesB[1]])!)

		let rangesPrize = lines[2].ranges(of: /\d+/)
		self.prize = Coordinates(x: Int(lines[2][rangesPrize[0]])!, y: Int(lines[2][rangesPrize[1]])!)
	}
}

// MARK: - Part one

func partOne(_ input: String) -> Int {
	
	// get machines
	let machines = input.components(separatedBy: "\n\n")
	
	var allTokens = 0
	
	for m in machines {
		let machine = Machine(lines: m.components(separatedBy: "\n"))
		
		var gotResult = false
		var (aCount, bCount) = (0, 0)
		
		outer: for i in stride(from: 100, through: 0, by: -1) {
			for j in stride(from: 0, through: 100, by: 1) {
				
				let x = machine.b.x * i + machine.a.x * j
				let y = machine.b.y * i + machine.a.y * j
				
				if x == machine.prize.x && y == machine.prize.y {
					(bCount, aCount) = (i, j)
					gotResult = true
					
					break outer
				}
			}
		}
		
		if gotResult {
			allTokens += aCount * 3 + bCount
		}
	}
	
	return allTokens
}

let input = load(file: "Input")
let result = partOne(input)
