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
3-5
10-14
16-20
12-18

1
5
8
11
17
32
""".components(separatedBy: "\n\n")

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	var output = 0
	
	let ranges = input[0].split(separator: "\n").compactMap { line in
		let components = line.split(separator: "-")
		
		return Int(components[0])!...Int(components[1])!
	}
	
	let ingredients = input[1].split(separator: "\n").compactMap { Int($0) }
	
	for ingredient in ingredients {
		for range in ranges {
			if range.contains(ingredient) {
				output += 1
				break
			}
		}
	}
	
	return output
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partOne(input)

// MARK: - Part two

func partTwo(_ input: [[Character]]) -> Int {
	0
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partTwo(input)
