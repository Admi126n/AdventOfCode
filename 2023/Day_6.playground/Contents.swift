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

func partOne(_ input: [String]) -> Int {
	var output = 1
	
	let times = input[0].components(separatedBy: " ").compactMap { Int($0) }
	let distances = input[1].components(separatedBy: " ").compactMap { Int($0) }
	
	guard times.count == distances.count else { fatalError("Wrong input") }
	
	for index in 0..<times.count {
		var combinations = 0
		
		for time in 1..<times[index] {
			if time * (times[index] - time) > distances[index] {
				combinations += 1
			}
		}
		
		output *= combinations
	}
	
	return output
}

//partOne(load(file: "Input"))

// MARK: - Part two

func getLowestTime(time: Int, distance: Int) -> Int? {
	for t in 1..<time where t * (time - t) > distance {
		return t
	}
	
	return nil
}

func getHighestTime(time: Int, distance: Int) -> Int? {
	for t in stride(from: time - 1, to: 0, by: -1) where t * (time - t) > distance {
		return t
	}
	
	return nil
}

func partTwo(_ input: [String]) -> Int {
	let times = input[0].components(separatedBy: " ").compactMap { Int($0) }
	let distances = input[1].components(separatedBy: " ").compactMap { Int($0) }
	
	guard times.count == distances.count else { fatalError("wrong input") }
	
	let distance = Int(distances.reduce("") { String($0) + String($1) })!
	let time = Int(times.reduce("") { String($0) + String($1) })!
	
	guard let lowestTime = getLowestTime(time: time, distance: distance) else { fatalError("cannot get lowest time") }
	guard let highestTime = getHighestTime(time: time, distance: distance) else { fatalError("cannot get highest time") }
	
	return highestTime - lowestTime + 1
}

//print(partTwo(load(file: "Input")))
