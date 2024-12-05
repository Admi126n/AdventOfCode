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

// MARK: - parsing input
func parse(_ input: String) -> (rules: [[Int]], updates: [[Int]]) {
	let parts = input.split(separator: "\n\n")

	let rules = parts[0].split(separator: "\n").reduce(into: [[Int]]()) {
		let temp = [Int($1.split(separator: "|")[0])!, Int($1.split(separator: "|")[1])!]
		$0.append(temp)
	}

	let updates = parts[1].split(separator: "\n").map { $0.split(separator: ",").map { Int($0)! } }
	
	return (rules, updates)
}

// MARK: - Part one

func partOne(rules: [[Int]], updates: [[Int]]) -> Int {
	var output = 0
	
	for update in updates {
		var isCorrect = true
		
		for i in 0..<update.count {
			
			for j in i + 1..<update.count {
				
				if !rules.contains([update[i], update[j]]) {
					isCorrect = false
				}
			}
		}
		
		if isCorrect {
			output += update[update.count / 2]
		}
	}
	
	return output
}

//let input = load(file: "Input")
//let (rules, updates) = parse(input)
//let result = partOne(rules: rules, updates: updates)

// MARK: - part two

func partTwo(rules: [[Int]], updates: [[Int]]) -> Int {
	var output = 0

	var incorrect: [[Int]] = []

	// get incorrect lines
	for update in updates {
		var isCorrect = true

		for i in 0..<update.count {
			for j in i + 1..<update.count {
				if !rules.contains([update[i], update[j]]) {
					isCorrect = false
				}
			}
		}
		if !isCorrect {
			incorrect.append(update)
		}
	}

	for update in incorrect {
		var mutableUpdate = update

		var isCorrect = true
		repeat {
			isCorrect = true
			outer: for i in 0..<mutableUpdate.count {
				for j in i + 1..<mutableUpdate.count {
					if !rules.contains([mutableUpdate[i], mutableUpdate[j]]) {
						(mutableUpdate[i], mutableUpdate[j]) = (mutableUpdate[j], mutableUpdate[i])
						isCorrect = false
						break outer
					}
				}
			}
		} while !isCorrect

		output += mutableUpdate[mutableUpdate.count / 2]
	}

	return output
}

//let input = load(file: "Input")
//let (rules, updates) = parse(input)
//let result = partTwo(rules: rules, updates: updates)

