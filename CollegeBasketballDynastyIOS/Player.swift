//
//  Player.swift
//  CollegeBasketballDynastyIOS
//
//  Created by Al Rotter on 7/16/25.
//




import Foundation
import SwiftData

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
    var stats: Int //NEED TO CHANGE TO A STRUCT OF SKILLS LIKE IN SCHOOL
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
    
    init(id: Int, fName: String, lName: String, pos: String, year: Int, ht: Int, wt: Int, ln: Int, stats: Int, overall: Int, offense: Int, defense: Int) {
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
        
        self.init(id: id, fName: fName, lName: lName, pos: pos, year: 0, ht: ht, wt: wt, ln: ln, stats: 0, overall: 0, offense: 0, defense: 0)
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
    
    
}
