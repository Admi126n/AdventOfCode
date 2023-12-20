import Cocoa

func load(file: String) -> [String] {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath) else {
		fatalError("Cannot decode file")
	}
	
	return content.components(separatedBy: "\n\n")
}

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	var maxCalories = 0
	var currCalories = 0
	
	for elf in input {
		let calories = elf.components(separatedBy: "\n")
		
		currCalories = calories.reduce(0) { $0 + Int($1)! }
		
		maxCalories = max(maxCalories, currCalories)
	}
	
	return maxCalories
}

//partOne(load(file: "Input"))

// MARK: - Part two

func partTwo(_ input: [String]) -> Int {
	var caloriesArray: [Int] = []
	
	for elf in input {
		let calories = elf.components(separatedBy: "\n")
		
		let currCalories = calories.reduce(0) { $0 + Int($1)! }
		
		caloriesArray.append(currCalories)
	}
	
	return caloriesArray.sorted().suffix(3).reduce(0) { $0 + $1 }
}

//partTwo(load(file: "Input"))
