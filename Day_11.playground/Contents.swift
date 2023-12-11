import Cocoa

func load(file: String) -> [[String.Element]] {
	guard let filePath = Bundle.main.url(forResource: file, withExtension: "txt") else {
		fatalError("Cannot find file")
	}
	
	guard let content = try? String(contentsOf: filePath) else {
		fatalError("Cannot decode file")
	}
	
	return content.components(separatedBy: "\n").map { Array($0) }
}

func getLinesToInsert(_ input: [[String.Element]]) -> [Int] {
	var lines: [Int] = []
	for (i, line) in input.enumerated() {
		if line.allSatisfy({ $0 == "." }) {
			lines.append(i)
		}
	}
	
	return lines
}

func getColumnsToInseert(_ input: [[String.Element]]) -> [Int] {
	var columns: [Int] = []
	for i in 0..<input[0].count {  // loop over columns
		var addColumn = true
		for j in 0..<input.count {
			if input[j][i] != "." {
				addColumn = false
				break
			}
		}
		
		if addColumn {
			columns.append(i)
		}
	}
	
	return columns
}

func getGalaxies(from input: [[String.Element]]) -> [(row: Int, col: Int)] {
	var galaxies: [(row: Int, col: Int)] = []
	for i in 0..<input.count {
		for j in 0..<input[i].count {
			if input[i][j] == "#" {
				galaxies.append((row: i, col: j))
			}
		}
	}
	
	return galaxies
}

func getSum(_ galaxies: [(row: Int, col: Int)], _ lines: [Int], _ columns: [Int], _ value: Int) -> Int {
	var sum = 0
	for (i, galaxy) in galaxies.enumerated() {
		for (j, inGalaxy) in galaxies.enumerated() where j > i {
			sum += (abs(galaxy.row - inGalaxy.row) + abs(galaxy.col - inGalaxy.col))
			
			for column in columns {
				if galaxy.col < inGalaxy.col {
					if galaxy.col...inGalaxy.col ~= column {
						sum += value
					}
				} else {
					if inGalaxy.col...galaxy.col ~= column {
						sum += value
					}
				}
			}
			
			for row in lines {
				if galaxy.row...inGalaxy.row ~= row {
					sum += value
				}
			}
		}
	}

	return sum
}


// MARK: - Part one

func partOne(_ input: [[String.Element]]) -> Int {
	let linesToInsert = getLinesToInsert(input)
	let columnsToInsert = getColumnsToInseert(input)
	let galaxies = getGalaxies(from: input)
	let valueToAdd = 1
	
	return getSum(galaxies, linesToInsert, columnsToInsert, valueToAdd)
}

//partOne(load(file: "Input"))

// MARK: - Part two

func partTwo(_ input: [[String.Element]]) -> Int {
	let linesToInsert = getLinesToInsert(input)
	let columnsToInsert = getColumnsToInseert(input)
	let galaxies = getGalaxies(from: input)
	let valueToAdd = 999999
	
	return getSum(galaxies, linesToInsert, columnsToInsert, valueToAdd)
}

//partTwo(load(file: "Input"))
