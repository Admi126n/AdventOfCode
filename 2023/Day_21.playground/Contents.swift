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

// MARK: - Part one

struct Coords: Hashable {
	let row: Int
	let col: Int
	
	init(_ row: Int, _ col: Int) {
		self.row = row
		self.col = col
	}
}

func getStartCoords(_ input: [[String.Element]]) -> (Int, Int)? {
	for i in 0..<input.count {
		if let index = input[i].firstIndex(of: "S") {
			return (index, i)
		}
	}
	
	return nil
}

func partOne(_ input: [[String.Element]]) -> Int {
	var field = input
	guard let (startXCoord, startYCoord) = getStartCoords(field) else { fatalError("Wrong input") }
	
	field[startYCoord][startXCoord] = "."
	
	var set: Set<Coords> = [Coords(startYCoord, startXCoord)]
	var tempSet: Set<Coords> = []
	
	for i in 0..<64 {
		for el in set {
			if field[el.row + 1][el.col] == "." { tempSet.insert(Coords(el.row + 1, el.col)) }
			if field[el.row - 1][el.col] == "." { tempSet.insert(Coords(el.row - 1, el.col)) }
			if field[el.row][el.col + 1] == "." { tempSet.insert(Coords(el.row, el.col + 1)) }
			if field[el.row][el.col - 1] == "." { tempSet.insert(Coords(el.row, el.col - 1)) }
		}
		
		set = tempSet
		tempSet.removeAll(keepingCapacity: true)
	}
	
	return set.count
}

//partOne(load(file: "Input"))
