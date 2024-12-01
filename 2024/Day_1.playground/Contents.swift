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

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	var distance = 0
	
	let firstList = input.map { Int($0.split(separator: " ").first!)! }.sorted()
	let secondList = input.map { Int($0.split(separator: " ").last!)! }.sorted()
	
	for (first, second) in zip(firstList, secondList) {
		distance += abs(first - second)
	}
	
	return distance
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partOne(input)


// MARK: - Part two

func partTwo(_ input: [String]) -> Int {
	var distance = 0
	
	let firstList = input.map { Int($0.split(separator: " ").first!)! }.sorted()
	let secondList = input.map { Int($0.split(separator: " ").last!)! }.sorted()
	
	for first in firstList {
		distance += first * secondList.count(where: { $0 == first })
	}
	
	return distance
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partTwo(input)
