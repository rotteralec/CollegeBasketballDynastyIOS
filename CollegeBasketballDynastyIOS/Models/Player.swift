//
//  Player.swift
//  CollegeBasketballDynastyIOS
//
//  Created by Al Rotter on 7/16/25.
//




import Foundation
import SwiftData

struct name: Codable {
    let firstName: String
    let lastName: String
}

struct PlayerSkills: Codable {
    
    var overall: Int
    var mid: Int
    var post: Int
    var threePT: Int
    var deepThreePT: Int
    var speed: Int
    var strength: Int
    var intDef: Int
    var perDef: Int
    var steal: Int
    var block: Int
    var offRB: Int
    var defRB: Int
    var passing: Int
    var ftShooting: Int
    
    init() {
        self.overall = 0
        self.mid = 0
        self.threePT = 0
        self.post = 0
        self.deepThreePT = 0
        self.speed = 0
        self.strength = 0
        self.intDef = 0
        self.perDef = 0
        self.steal = 0
        self.block = 0
        self.offRB = 0
        self.defRB = 0
        self.passing = 0
        self.ftShooting = 0
    }
    
    
}

@Model
class Player: Codable {
    @Attribute(.unique) var id: Int
    var fName: String
    var lName: String
    var pos: String
    var year: Int
    var ht: Int
    var wt: Int
    var ln: Int
    var stats: PlayerSkills //NEED TO CHANGE TO A STRUCT OF SKILLS LIKE IN SCHOOL
    var overall: Int
    var offense: Int
    var defense: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case fName
        case lName
        case pos
        case ht
        case wt
        case ln
    }
    //STILL TO DO
    //generateFirstName()
    //generateLastName()
    //generateStats(pos, ht, wt)
    //generateWT()
    //generateHT()
    //generateType(pos, wt, ht)
    
    //gen year (IF NEEDED FOR INITIALIZATION OF GAME ENGINE)
    
    //trainPlayer
    //calcOverall
    //reload() should be replaced by decode of Codable
    
    init(id: Int, fName: String, lName: String, pos: String, year: Int, ht: Int, wt: Int, ln: Int, stats: PlayerSkills, overall: Int, offense: Int, defense: Int) {
        self.id = id
        self.fName = fName
        self.lName = lName
        self.pos = pos
        self.year = year
        self.ht = ht
        self.wt = wt
        self.ln = ln
        self.stats = stats
        self.overall = overall
        self.offense = offense
        self.defense = defense
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(Int.self, forKey: .id)
        let fName = try container.decode(String.self, forKey: .fName)
        let lName = try container.decode(String.self, forKey: .lName)
        let pos = try container.decode(String.self, forKey: .pos)
        let ht = try container.decode(Int.self, forKey: .ht)
        let wt = try container.decode(Int.self, forKey: .wt)
        let ln = try container.decode(Int.self, forKey: .ln)
        
        self.init(id: id, fName: fName, lName: lName, pos: pos, year: 0, ht: ht, wt: wt, ln: ln, stats: PlayerSkills(), overall: 0, offense: 0, defense: 0)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(fName, forKey: .fName)
        try container.encode(lName, forKey: .lName)
        try container.encode(pos, forKey: .pos)
        try container.encode(ht, forKey: .ht)
        try container.encode(wt, forKey: .wt)
        try container.encode(ln, forKey: .ln)
    }
    
    func generateFirstName() -> String {
        return ""
    }
    
}


class CSVReader {
    enum CSVError: Error, LocalizedError {
        case fileNotFound(String)
        case fileCorrupted(String)
        case parsingError(String)
        
        var errorDescription: String? {
            switch self {
            case .fileNotFound(let filename): return "CSV file '(filename)' not found."
            case .fileCorrupted(let filename): return "CSV file '(filename)' is courrupted."
            case .parsingError(let message): return "Error parsing CSV data: \(message)."
            }
        }
    }
    
    static func readNamesFromCSV(filename: String) throws -> [name] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "csv") else {
            throw CSVError.fileNotFound(filename)
        }
        do {
            let data = try String(contentsOf: url, encoding: .utf8)
            var newName: [name] = []
            let rows = data.components(separatedBy: "\n")
            
            guard rows.count > 1 else {
                throw CSVError.parsingError("CSV file is empty or only contains a header row")
            }
            //process data rows
            for i in 1..<rows.count {
                let row = rows[i].trimmingCharacters(in: .whitespacesAndNewlines)
                guard !row.isEmpty else { continue } //skips empty lines
                
                let columns = row.components(separatedBy: ",")
                
                //basic validation ensuring expected number of columns
                guard columns.count == 2 else {
                    throw CSVError.parsingError("Row \(i+1) has incorrect number of columns")
                }
                
                //Extract and convert data
//                guard let newFirstName = String(columns[0].trimmingCharacters(in: .whitespaces)) else {
//                    throw CSVError.parsingError("Failed to parse age at row \(i+1), column 1: \(columns[0])")
//                }
                let newFirstName = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let newLastName = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)
                let tempName = name(firstName: newFirstName, lastName: newLastName)
                newName.append(tempName)
            }
            return newName
        }
        
    }
}
