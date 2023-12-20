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

struct Part {
	let x: Int
	let m: Int
	let a: Int
	let s: Int
	
	init(from line: String) {
		let cleanedLine = line.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "")
		let components = cleanedLine.components(separatedBy: ",")
		
		self.x = Int(components[0].components(separatedBy: "=")[1])!
		self.m = Int(components[1].components(separatedBy: "=")[1])!
		self.a = Int(components[2].components(separatedBy: "=")[1])!
		self.s = Int(components[3].components(separatedBy: "=")[1])!
	}
}

func getWorkflows(from input: [String]) -> [String: String] {
	var output: [String: String] = [:]
	
	for line in input {
		let lineComponents = line.components(separatedBy: "{")
		output[lineComponents[0]] = lineComponents[1].replacingOccurrences(of: "}", with: "")
	}
	
	return output
}

func getParts(from input: [String]) -> [Part] {
	var output: [Part] = []
	
	for line in input {
		output.append(Part(from: line))
	}
	
	return output
}

func getNextWorkflow(from workflow: String, _ part: Part) -> String {
	let instructions = workflow.components(separatedBy: ",")
	for instruction in instructions {
		let instructionComponents = instruction.components(separatedBy: ":")
		
		guard instructionComponents.count != 1 else { return instructionComponents[0] }
		
		let nextInstruction = instructionComponents[1]
		var sign = "<"
		var components: [String] = []
		
		if instructionComponents[0].components(separatedBy: sign).count != 1 {
			components = instructionComponents[0].components(separatedBy: sign)
		} else {
			sign = ">"
			components = instructionComponents[0].components(separatedBy: sign)
		}
		
		if sign == "<" {
			if components[0] == "x", part.x < Int(components[1])! {
				return nextInstruction
			} else if components[0] == "m", part.m < Int(components[1])! {
				return nextInstruction
			} else if components[0] == "a", part.a < Int(components[1])! {
				return nextInstruction
			} else if components[0] == "s", part.s < Int(components[1])! {
				return nextInstruction
			}
		} else {
			if components[0] == "x", part.x > Int(components[1])! {
				return nextInstruction
			} else if components[0] == "m", part.m > Int(components[1])! {
				return nextInstruction
			} else if components[0] == "a", part.a > Int(components[1])! {
				return nextInstruction
			} else if components[0] == "s", part.s > Int(components[1])! {
				return nextInstruction
			}
		}
	}
	
	fatalError()
}

func partOne(_ input: [String]) -> Int {
	let workflows = getWorkflows(from: input[0].components(separatedBy: "\n"))
	let parts: [Part] = getParts(from: input[1].components(separatedBy: "\n"))
	var result = 0
	
	for part in parts {
		var nextWorkflow = ""
		var workflow = workflows["in"]!
		
		repeat {
			nextWorkflow = getNextWorkflow(from: workflow, part)
			
			if let safeWorkflow = workflows[nextWorkflow] {
				workflow = safeWorkflow
			}
			
		} while nextWorkflow != "A" && nextWorkflow != "R"
		
		if nextWorkflow == "A" {
			result += part.x + part.m + part.a + part.s
		}
	}
	
	return result
}

//partOne(load(file: "Input"))
