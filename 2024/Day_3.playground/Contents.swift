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

func partOne(_ input: String) -> Int {
	var output = 0
	let ranges = input.ranges(of: /mul\(\d{,3},\d{,3}\)/)
	
	for range in ranges {
		var mul = String(input[range]).replacingOccurrences(of: "mul(", with: "").replacingOccurrences(of: ")", with: "")
		let numbers = mul.split(separator: ",")
		
		output += Int(numbers.first!)! * Int(numbers.last!)!
	}
	
	return output
}

//let input = load(file: "Input").replacingOccurrences(of: "\n", with: "")
//let result = partOne(input)
