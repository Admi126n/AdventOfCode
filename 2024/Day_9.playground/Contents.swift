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

func getDisk(from input: String) -> (dataStart: Int, disk: [String]) {
	let chars = Array(input).map { String($0) }
	let numbers = chars.compactMap { Int($0) }
	var disk: [String] = []
	
	for i in 0..<numbers.count {
		if i % 2 == 0 {
			disk += Array(repeating: String(i / 2), count: numbers[i])
		} else {
			disk += Array(repeating: ".", count: numbers[i])
		}
	}
	
	return (numbers.first!, disk)
}

func getChecksum(of disk: [String]) -> Int {
	var output = 0
	
	for i in 0..<disk.count {
		if let num = Int(disk[i]) {
			output += i * num
		}
	}
	
	return output
}

// MARK: - Part one

func partOne(_ input: String) -> Int {
	var (dataStart, disk) = getDisk(from: input)
	
	var startIndex = dataStart
	while startIndex < disk.count - 1 {
		while disk[startIndex] == "." {
			guard startIndex < disk.count - 1 else { break }
	
			disk[startIndex] = disk.removeLast()
		}
	
		startIndex += 1
	}
	
	return getChecksum(of: disk)
}

//let input = load(file: "Input")
//let result = partOne(input)
