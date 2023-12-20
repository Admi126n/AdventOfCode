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

func getDict(from input: [String]) -> [String: Int] {
	input.reduce(into: [String: Int]()) {
		let components = $1.components(separatedBy: " ")
		$0[components[0]] = Int(components[1])!
	}
}

func sortByLetters(_ lhs: String, _ rhs: String, _ order: [String]) -> Bool {
	for i in 0..<lhs.count {
		let lhsLetter = Array(lhs)[i]
		let rhsLetter = Array(rhs)[i]
		
		if order.firstIndex(of: String(lhsLetter)) ?? Int.max < order.firstIndex(of: String(rhsLetter)) ?? Int.max {
			return true
		} else if order.firstIndex(of: String(lhsLetter)) ?? Int.max > order.firstIndex(of: String(rhsLetter)) ?? Int.max {
			return false
		}
	}
	
	return false
}

// MARK: - Parrt one

func getCountForHandsOne(_ input: [String]) -> [[Any]] {
	input.map {
		var frequencies : [Character: Int] = [:]
		let baseCounts = zip($0, repeatElement(1,count: Int.max))
		frequencies = Dictionary(baseCounts, uniquingKeysWith: +)
		let count = Array(frequencies.map { $0.value }.sorted().reversed())
		
		return [$0, count]
	}
}

let partOneLettersOrder = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]

func partOne(_ input: [String]) -> Int {
	let handBidDict = getDict(from: input)
	let handsArray = input.map { $0.components(separatedBy: " ").first! }
	let handsSortedByLettes = handsArray.sorted { sortByLetters($0, $1, partOneLettersOrder) }
	let handLettersCount = getCountForHandsOne(handsSortedByLettes)
	
	var fiveOf: [String] = []
	var fourOf: [String] = []
	var fullHouse: [String] = []
	var threeOf: [String] = []
	var twoPair: [String] = []
	var onePair: [String] = []
	var highCard: [String] = []
	
	for hand in handLettersCount {
		let handString = hand[0] as! String
		
		switch hand[1] as! [Int] {
		case [5]:
			fiveOf.append(handString)
		case [4, 1]:
			fourOf.append(handString)
		case [3, 2]:
			fullHouse.append(handString)
		case [3, 1, 1]:
			threeOf.append(handString)
		case [2, 2, 1]:
			twoPair.append(handString)
		case [2, 1, 1, 1]:
			onePair.append(handString)
		default:
			highCard.append(handString)
		}
	}
	
	let types = [fiveOf, fourOf, fullHouse, threeOf, twoPair, onePair, highCard]
	
	var weight = handsArray.count
	var result = 0
	
	for type in types {
		for hand in type {
			result += handBidDict[hand]! * weight
			weight -= 1
		}
	}
	
	return result
}

//partOne(load(file: "Input"))

// MARK: - Part two

func getCountForHandsTwo(_ input: [String]) -> [[Any]] {
	input.map {
		var frequencies : [Character: Int] = [:]
		let baseCounts = zip($0, repeatElement(1,count: Int.max))
		frequencies = Dictionary(baseCounts, uniquingKeysWith: +)
		
		if frequencies.count > 1 {
			if let jValue = frequencies["J"] {
				frequencies.removeValue(forKey: "J")
				let maxKeyValue = frequencies.max { a, b in a.value < b.value}!
				frequencies[maxKeyValue.key]! += jValue
			}
		}
		let count = Array(frequencies.map { $0.value }.sorted().reversed())
		
		return [$0, count]
	}
}

let partTwoLettersOrder = ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"]

func partTwo(_ input: [String]) -> Int {
	let handBidDict = getDict(from: input)
	let handsArray = input.map { $0.components(separatedBy: " ").first! }
	let handsSortedByLettes = handsArray.sorted { sortByLetters($0, $1, partTwoLettersOrder) }
	var handLettersCount = getCountForHandsTwo(handsSortedByLettes)
	
	var fiveOf: [String] = []
	var fourOf: [String] = []
	var fullHouse: [String] = []
	var threeOf: [String] = []
	var twoPair: [String] = []
	var onePair: [String] = []
	var highCard: [String] = []
	
	for hand in handLettersCount {
		let handString = hand[0] as! String
		
		switch hand[1] as! [Int] {
		case [5]:
			fiveOf.append(handString)
		case [4, 1]:
			fourOf.append(handString)
		case [3, 2]:
			fullHouse.append(handString)
		case [3, 1, 1]:
			threeOf.append(handString)
		case [2, 2, 1]:
			twoPair.append(handString)
		case [2, 1, 1, 1]:
			onePair.append(handString)
		default:
			highCard.append(handString)
		}
	}
	
	let types = [fiveOf, fourOf, fullHouse, threeOf, twoPair, onePair, highCard]
	
	var weight = handsArray.count
	var result = 0
	
	for type in types {
		for hand in type {
			result += handBidDict[hand]! * weight
			weight -= 1
		}
	}
	
	return result
}

//partTwo(load(file: "Input"))
