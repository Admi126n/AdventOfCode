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

let example = """
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
""".components(separatedBy: ",")


// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	var output = 0
	
	for range in input {
		let start = Int(range.components(separatedBy: ["-"])[0])!
		let end = Int(range.components(separatedBy: ["-"])[1])!
		
		for number in start...end {
			let strNum = String(number)
			
			if strNum.count.isMultiple(of: 2) {
				let a = strNum.prefix(strNum.count / 2)
				let b = strNum.suffix(strNum.count / 2)
				if a == b {
					output += number
				}
			}
		}
	}
	
	return output
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partOne(input)

// MARK: - Part two

func partTwo(_ input: [String]) -> Int {
	var output = 0
	
	for range in input {
		let start = Int(range.components(separatedBy: ["-"])[0])!
		let end = Int(range.components(separatedBy: ["-"])[1])!
		
		for number in start...end {
			let strNum = String(number)
			
			for i in 1..<strNum.count where strNum.count.isMultiple(of: i) {
				let a = String(strNum.prefix(i))
				let times = strNum.count / i
				
				if strNum == String(repeating: a, count: times) {
					output += number
					break
				}
			}
		}
	}
	
	return output
}

//let input = load(file: "Input").split(separator: "\n").map { String($0) }
//let result = partTwo(input)
