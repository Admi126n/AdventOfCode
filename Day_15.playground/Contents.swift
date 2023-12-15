import Cocoa

func load(file: String) -> [String] {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath) else {
		fatalError("Cannot decode file")
	}
	
	return content.components(separatedBy: ",")
}

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	var result: UInt32 = 0
	
	for el in input {
		var elAsciiValue: UInt32 = 0
		
		for char in el {
			elAsciiValue += UnicodeScalar(String(char))!.value
			elAsciiValue *= 17
			elAsciiValue = elAsciiValue % 256
		}
		
		result += elAsciiValue
	}
	
	return Int(result)
}

//partOne(load(file: "Input"))

// MARK: - Part two

enum ElType {
	case sign
	case dash
}

func getTypeKey(of el: String) -> (type: ElType, key: String) {
	if el.contains("-") {
		return (.dash, el.components(separatedBy: "-")[0])
	} else {
		return (.sign, el.components(separatedBy: "=")[0])
	}
}

func calculateResult(for boxes: [[String]]) -> Int {
	var result = 0
	for (i, box) in boxes.enumerated() {
		for (j, el) in box.enumerated() {
			result += (i + 1) * (j + 1) * Int(boxes[i][j].components(separatedBy: "=")[1])!
		}
	}
	
	return result
}

func partTwo(_ input: [String]) -> Int {
	var boxes: [[String]] = [[String]](repeating: [], count: 256)
	
	for el in input {
		let (type, key) = getTypeKey(of: el)
		
		var elAsciiValue = 0
		for char in key {
			elAsciiValue += Int(exactly: UnicodeScalar(String(char))!.value)!
			elAsciiValue *= 17
			elAsciiValue %= 256
			
		}
		
		switch type {
		case .sign:
			if !boxes[elAsciiValue].contains(where: { $0.contains(key)}) {
				boxes[elAsciiValue].append(el)
			} else if let index = boxes[elAsciiValue].firstIndex(where: { $0.contains(key) }) {
				boxes[elAsciiValue][index] = el
			}
		case .dash:
			if let index = boxes[elAsciiValue].firstIndex(where: { $0.contains(key) }) {
				boxes[elAsciiValue].remove(at: index)
			}
		}
	}
	
	return calculateResult(for: boxes)
}

//partTwo(load(file: "Input"))
