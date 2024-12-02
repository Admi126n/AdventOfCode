import Cocoa

func load(file: String) -> [String] {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath, encoding: .ascii) else {
		fatalError("Cannot decode file")
	}
	
	return content.split(separator: "\n").map { String($0) }
}

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	var safeReports = 0
	
	for report in input {
		let levels = report.split(separator: " ").map { Int($0)! }
		let increasing = levels.first! < levels.last!
		var safe = true
		
		for i in 1..<levels.count {
			if increasing {
				if levels[i] - levels[i - 1] > 3 || levels[i] - levels[i - 1] < 0 || levels[i] == levels[i - 1] {
					safe = false
					break
				}
			} else {
				if levels[i - 1] - levels[i] > 3 || levels[i - 1] - levels[i] < 0 || levels[i - 1] == levels[i]  {
					safe = false
					break
				}
			}
		}
		
		if safe {
			print(report)
			safeReports += 1
		}
	}
	
	return safeReports
}

//let input = load(file: "Input")
//let result = partOne(input)
