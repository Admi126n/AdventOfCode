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

func split(line: String) -> (UInt128, [UInt128]) {
	let components = line.split(separator: ":")
	
	let result = UInt128(components.first!)!
	let numbers = components.last!.split(separator: " ").compactMap { UInt128($0) }
	
	return (result, numbers)
}

func getPermutations(of length: Int, from characters: [String]) -> [[String]] {
	var result: [[String]] = [[]]
	
	for _ in 0..<length {
		var newResult = [[String]]()
		
		for permutation in result {
			for char in characters {
				newResult.append(permutation + [char])
			}
		}
		result = newResult
	}
	
	return result
}

// MARK: - Part one

func partOne(_ input: [String]) -> UInt128 {
	var output: UInt128 = 0
	
	lineLoop: for line in input {
		var (expectedResult, numbers) = split(line: line)
		let operationsPermutations = getPermutations(of: numbers.count - 1, from: ["*", "+", "||"])
		
		permutationLoop: for permutation in operationsPermutations {
			var tmpResult = numbers.first!
			
			for (operation, number) in zip(permutation, numbers.suffix(numbers.count - 1)) {
				if operation == "+" {
					tmpResult += number
				} else if operation == "*" {
					tmpResult *= number
				}
				
				if tmpResult > expectedResult {
					continue permutationLoop
				}
			}
			
			if tmpResult == expectedResult {
				output += tmpResult
				continue lineLoop
			}
		}
	}
	
	return output
}

//let input = load(file: "Input")
//let result = partOne(input)

// MARK: - Part two

func partTwo(_ input: [String]) -> UInt128 {
	var output: UInt128 = 0
	
	lineLoop: for line in input {
		var (expectedResult, numbers) = split(line: line)
		let operationsPermutations = getPermutations(of: numbers.count - 1, from: ["*", "+", "||"])
		
		permutationLoop: for permutation in operationsPermutations {
			var tmpResult = numbers.first!
			
			for (operation, number) in zip(permutation, numbers.suffix(numbers.count - 1)) {
				if operation == "+" {
					tmpResult += number
				} else if operation == "*" {
					tmpResult *= number
				} else if operation == "||" {
					tmpResult = UInt128("\(tmpResult)\(number)")!
				}
				
				if tmpResult > expectedResult {
					continue permutationLoop
				}
			}
			
			if tmpResult == expectedResult {
				output += tmpResult
				continue lineLoop
			}
		}
	}
	
	return output
}

//let input = load(file: "Input")
//let result = partTwo(input)
