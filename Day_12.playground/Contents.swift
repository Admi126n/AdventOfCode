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

/*
 1,1,3 - 1
 1,1,3 - 4
 1,3,1,6 - 1
 4,1,1 - 1
 1,6,5 - 4
 3,2,1 - 10
 */

let example = """
???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1
""".components(separatedBy: "\n")

let input = example

let lines: [(map: [String.Element], count: [Int])] = input.map { line in
	let components = line.components(separatedBy: " ")
	let numbers = components[1].components(separatedBy: ",")
	
	return (map: Array(components[0]), count: numbers.compactMap { Int($0) })
}

for line in lines {
	print(line)
}

