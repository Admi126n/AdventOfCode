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

func getMap(from input: [String]) -> [String: (String, String)] {
	var inputDict: [String: (left: String, right: String)] = [:]
	for i in 2..<input.count {
		var line = input[i].replacingOccurrences(of: "[=(,)]", with: "", options: .regularExpression)
		line.replacingOccurrences(of: "  ", with: " ")
		let lineComponents = line.components(separatedBy: " ")
		
		inputDict[lineComponents[0]] = (lineComponents[2], lineComponents[3])
	}
	
	return inputDict
}

func partOne(_ input: [String]) -> Int {
	let navigation = Array(input[0])
	let map = getMap(from: input)
	
	var currMapKey = "AAA"
	var counter = 0
	while currMapKey != "ZZZ" {
		let direction = navigation[counter % navigation.count]
		
		switch direction {
		case "L":
			currMapKey = map[currMapKey]!.0
		case "R":
			currMapKey = map[currMapKey]!.1
		default:
			fatalError()
		}
		
		counter += 1
	}
	
	return counter
}

partOne(load(file: "Input"))

// MARK: - Part two

func gcd(_ x: Int, _ y: Int) -> Int {
	var a = 0
	var b = max(x, y)
	var r = min(x, y)
	
	while r != 0 {
		a = b
		b = r
		r = a % b
	}
	return b
}

func lcm(_ x: Int, _ y: Int) -> Int {
	return x / gcd(x, y) * y
}

func partTwo(_ input: [String]) -> Int {
	let navigation = Array(input[0])
	let map = getMap(from: input)

	var currMapKeys: [(key: String, steps: Int)] = map.keys.filter { $0.hasSuffix("A") }.map { ($0, 0) }

	var counter = 0
	while true {
		let direction = navigation[counter % navigation.count]
		counter += 1
		
		switch direction {
		case "L":
			for (i, keyStep) in currMapKeys.enumerated() where !keyStep.key.hasSuffix("Z") {
				currMapKeys[i] = (map[keyStep.key]!.0, counter)
			}
		case "R":
			for (i, keyStep) in currMapKeys.enumerated() where !keyStep.key.hasSuffix("Z") {
				currMapKeys[i] = (map[keyStep.key]!.1, counter)
			}
		default:
			fatalError()
		}
		
		if currMapKeys.allSatisfy({ $0.0.hasSuffix("Z") }) {
			break
		}
	}

	var lcmValue = 1
	for i in 0..<currMapKeys.count {
		lcmValue = lcm(lcmValue, currMapKeys[i].steps)
	}

	return lcmValue
}

partTwo(load(file: "Input"))

