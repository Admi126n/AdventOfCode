import Cocoa

func load(file: String) -> [String] {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath) else {
		fatalError("Cannot decode file")
	}
	
	return content.components(separatedBy: "\n\n")
}

// MARK: - Part one

func partOne(_ input: [String]) -> Int {
	let seeds = input[0].components(separatedBy: " ").compactMap { Int($0) }
	var minLocation = Int.max
	
	for seed in seeds {
		var translatedValue = seed
		for i in 1...input.count - 1 {
			let mapLines = input[i].components(separatedBy: "\n")
			
			for (i, line) in mapLines.enumerated() where i != 0 {
				let lineComponents = line.components(separatedBy: " ").compactMap { Int($0) }
				
				if lineComponents[1]..<lineComponents[1] + lineComponents[2] ~= translatedValue {
					let diff = translatedValue - lineComponents[1]
					translatedValue = lineComponents[0] + diff
					break
				}
			}
		}
		
		minLocation = min(minLocation, translatedValue)
	}
	
	return minLocation
}

//partOne(load(file: "Input"))


// MARK: - Part two

let example = """
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
""".components(separatedBy: "\n\n")

func getSeeds(from line: String) -> [[Int]] {
	var seedsRanges: [[Int]] = []
	let components = line.components(separatedBy: " ").compactMap { Int($0) }
	
	for i in stride(from: 0, to: components.count, by: 2) {
		seedsRanges.append([components[i], components[i] + components[i + 1] - 1])
	}

	return seedsRanges
}

var seedsRanges = getSeeds(from: example[0])
print(seedsRanges)
