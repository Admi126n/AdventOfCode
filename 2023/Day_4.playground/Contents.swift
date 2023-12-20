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

// MARK: - Part one

func partOne(_ lines: [String]) -> Int {
	var output = 0
	
	for line in lines {
		var score = 0
		let components = line.components(separatedBy: "|")
		
		let winningNums = components[0].components(separatedBy: " ").compactMap { Int($0) }
		let elfNums = components[1].components(separatedBy: " ").compactMap { Int($0) }
		
		for num in elfNums where winningNums.contains(num) {
			if score == 0 {
				score = 1
			} else {
				score *= 2
			}
		}
		
		output += score
	}
	
	return output
}

//partOne(load(file: "Input"))

// MARK: - Part two

func getCardId(from line: String) -> Int {
	let components = line.components(separatedBy: "|")[0].components(separatedBy: ":")[0]
	var cardId = 0
	
	if let num = Int(components.suffix(3)) {
		cardId = num
	} else if let num = Int(components.suffix(2)) {
		cardId = num
	} else if let num = Int(components.suffix(1)) {
		cardId = num
	}
	
	return cardId
}

func partTwo(_ input: [String]) -> Int {
	var output = 0
	var winsPerCard: [Int: Int] = [:]
	var numOfAppear: [Int: Int] = [:]

	for line in input {
		var score = 0
		let components = line.components(separatedBy: "|")
		
		let cardId = getCardId(from: line)
		let winningNums = components[0].components(separatedBy: " ").compactMap { Int($0) }
		let elfNums = components[1].components(separatedBy: " ").compactMap { Int($0) }
		
		for num in elfNums where winningNums.contains(num) {
			score += 1
		}
		
		winsPerCard[cardId] = score
		output += score
	}

	for key in winsPerCard.keys {
		numOfAppear[key] = 1
	}

	for key in winsPerCard.keys.sorted() {
		if winsPerCard[key]! >= 1 {
			for _ in 0..<numOfAppear[key]! {
				for j in 1...winsPerCard[key]! {
					numOfAppear[key + j]! += 1
				}
			}
		}
	}

	var sum = 0
	for value in numOfAppear.values {
		sum += value
	}

	return sum
}

//partTwo(load(file: "Input"))
