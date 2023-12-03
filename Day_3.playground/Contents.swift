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

func partOne(_ input: [[String.Element]]) -> Int {
	var output = 0
	
	for (i, line) in input.enumerated() {
		var stringNum = ""
		var addNum = false
		
		for (j, char) in line.enumerated() {
			if char.isNumber {
				stringNum += String(char)
				
				if j > 0, line[j - 1] != "." && !line[j - 1].isNumber {
					addNum = true
					continue
				}
				
				if j < line.count - 1, line[j + 1] != "." && !line[j + 1].isNumber {
					addNum = true
					continue
				}
				
				if i > 0, input[i - 1][j] != "." && !input[i - 1][j].isNumber {
					addNum = true
					continue
				}
				
				if i < input.count - 1, input[i + 1][j] != "." && !input[i + 1][j].isNumber {
					addNum = true
					continue
				}
				
				if i > 0 && j > 0, input[i - 1][j - 1] != "." && !input[i - 1][j - 1].isNumber {
					addNum = true
					continue
				}
				
				if i < input.count - 1 && j < line.count - 1, input[i + 1][j + 1] != "." && !input[i + 1][j + 1].isNumber {
					addNum = true
					continue
				}
				
				if i > 0 && j < line.count - 1, input[i - 1][j + 1] != "." && !input[i - 1][j + 1].isNumber {
					addNum = true
					continue
				}
				
				if i < input.count - 1 && j > 0, input[i + 1][j - 1] != "." &&  !input[i + 1][j - 1].isNumber {
					addNum = true
					continue
				}
			} else if addNum {
				output += Int(stringNum)!
				stringNum = ""
				addNum = false
			} else {
				stringNum = ""
				addNum = false
			}
			
			if char.isNumber && j == line.count - 1 && addNum {
				output += Int(stringNum)!
				stringNum = ""
				addNum = false
			}
		}
	}
	
	return output
}

//let mappedInput = load(file: "Input").map { Array($0) }
//print(partOne(mappedInput))

// MARK: - Part two

func partTwo(_ input: [[String.Element]]) -> Int {
	var numbersList: [(num: String, line: Int, char: Int)] = []
	var output = 0
	
	for (i, line) in input.enumerated() {
		var stringNum = ""
		var asterixPos: (line: Int?, char: Int?) = (nil, nil)
		var addNum = false
		
		for (j, char) in line.enumerated() {
			if char.isNumber {
				stringNum += String(char)
				
				if j > 0, line[j - 1] != "." && !line[j - 1].isNumber {
					addNum = true
					if line[j - 1] == "*" {
						asterixPos = (i, j - 1)
					}
					continue
				}
				
				if j < line.count - 1, line[j + 1] != "." && !line[j + 1].isNumber {
					addNum = true
					if line[j + 1] == "*" {
						asterixPos = (i, j + 1)
					}
					continue
				}
				
				if i > 0, input[i - 1][j] != "." && !input[i - 1][j].isNumber {
					addNum = true
					if input[i - 1][j] == "*" {
						asterixPos = (i - 1, j)
					}
					continue
				}
				
				if i < input.count - 1, input[i + 1][j] != "." && !input[i + 1][j].isNumber {
					addNum = true
					if input[i + 1][j] == "*" {
						asterixPos = (i + 1, j)
					}
					continue
				}
				
				if i > 0 && j > 0, input[i - 1][j - 1] != "." && !input[i - 1][j - 1].isNumber {
					addNum = true
					if input[i - 1][j - 1] == "*" {
						asterixPos = (i - 1, j - 1)
					}
					continue
				}
				
				if i < input.count - 1 && j < line.count - 1, input[i + 1][j + 1] != "." && !input[i + 1][j + 1].isNumber {
					addNum = true
					if input[i + 1][j + 1] == "*" {
						asterixPos = (i + 1, j + 1)
					}
					continue
				}
				
				if i > 0 && j < line.count - 1, input[i - 1][j + 1] != "." && !input[i - 1][j + 1].isNumber {
					addNum = true
					if input[i - 1][j + 1] == "*" {
						asterixPos = (i - 1, j + 1)
					}
					continue
				}
				
				if i < input.count - 1 && j > 0, input[i + 1][j - 1] != "." &&  !input[i + 1][j - 1].isNumber {
					addNum = true
					if input[i + 1][j - 1] == "*" {
						asterixPos = (i + 1, j - 1)
					}
					continue
				}
			} else if addNum {
				if let line = asterixPos.0, let char = asterixPos.1 {
					numbersList.append((stringNum, line, char))
				}
				
				asterixPos = (nil, nil)
				stringNum = ""
				addNum = false
			} else {
				stringNum = ""
				addNum = false
			}
			
			if char.isNumber && j == line.count - 1 && addNum {
				if let line = asterixPos.0, let char = asterixPos.1 {
					numbersList.append((stringNum, line, char))
				}
				
				asterixPos = (nil, nil)
				stringNum = ""
				addNum = false
			}
		}
	}
	
	for el in numbersList {
		for inEl in numbersList {
			if el.0 != inEl.0 {
				if el.1 == inEl.1 && el.2 == inEl.2 {
					output += Int(el.0)! * Int(inEl.0)!
				}
			}
		}
	}
	
	return output / 2
}

//let mappedInput = load(file: "Input").map { Array($0) }
//print(partTwo(mappedInput))
