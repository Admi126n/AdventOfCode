import Cocoa

func load(file: String) -> String {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath) else {
		fatalError("Cannot decode file")
	}
	
	return content
}

func addPoints(for shape: String) -> Int {
	if shape == "A" {
		return 1
	} else if shape == "B" {
		return 2
	} else {
		return 3
	}
}

// MARK: - Part one

func getResult(for move: [String]) -> Int {
	let a = move[0]
	let b = move[1]
	
	if a == b { return 3 }
	
	if a == "A" && b == "C" {
		return 0
	}
	
	if a == "B" && b == "A" {
		return 0
	}
	
	if a == "C" && b == "B" {
		return 0
	}
	
	return 6
}

func partOne(_ input: String) -> Int {
	var i = input.replacingOccurrences(of: "X", with: "A")
	i = i.replacingOccurrences(of: "Y", with: "B")
	i = i.replacingOccurrences(of: "Z", with: "C")
	
	var score = 0

	for line in i.components(separatedBy: "\n") {
		let moves = line.components(separatedBy: " ")
		
		score += addPoints(for: moves[1])
		score += getResult(for: moves)
	}
	
	return score
}

//partOne(load(file: "Input"))

// MARK: - Part two

func getLetterForWin(_ move: String) -> String {
	if move == "A" {
		return "B"
	} else if move == "B" {
		return "C"
	} else {
		return "A"
	}
}

func getLetterForLoose(_ move: String) -> String {
	if move == "A" {
		return "C"
	} else if move == "B" {
		return "A"
	} else {
		return "B"
	}
}

func partTwo(_ input: String) -> Int {
	var score = 0
	
	for line in input.components(separatedBy: "\n") {
		let moves = line.components(separatedBy: " ")
		
		if moves[1] == "X" {
			score += addPoints(for: getLetterForLoose(moves[0]))
		} else if moves[1] == "Y" {
			score += 3
			score += addPoints(for: moves[0])
		} else if moves[1] == "Z" {
			score += 6
			score += addPoints(for: getLetterForWin(moves[0]))
		}
	}
	
	return score
}

//partTwo(load(file: "Input"))
