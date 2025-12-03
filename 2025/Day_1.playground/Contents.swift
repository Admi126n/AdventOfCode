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
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
""".components(separatedBy: "\n")

func mod(_ a: Int, _ n: Int) -> Int {
	let r = a % n
	return r >= 0 ? r : r + n
}

func getDirectionAndValue(from line: String) -> (direction: String, value: Int) {
	(String(line.prefix(1)), Int(line.dropFirst()) ?? 0)
}

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	var result = 0
	var dial = 50
	for line in input {
		let (direction, value) = getDirectionAndValue(from: line)
		if direction == "R" {
			dial += value
			dial = mod(dial, 100)
		} else if direction == "L" {
			dial -= value
			dial = mod(dial, 100)
		}
		
		if dial == 0 {
			result += 1
		}
		print(line, dial)
	}
	
	return result
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partOne(input)

// MARK: - Part two

func partTwo(_ input: [String]) -> Int {
	0
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partTwo(input)
