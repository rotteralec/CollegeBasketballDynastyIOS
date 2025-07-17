//
//  School.swift
//  CollegeBasketballDynastyIOS
//
//  Created by Al Rotter on 7/15/25.
//

import Foundation
import SwiftData

struct schoolSkills: Codable {
    
    let facilities: Int
    let fundraising: Int
    let campus: Int
    let academics: Int
    let marketing: Int
}

@Model
class school: Codable, Identifiable {
    @Attribute(.unique) var id: Int
    var name: String //EK
    var mascot: String//EK
    var coach: String//EK
    var prestige: Int
    var city: String//EK
    var state: String//EK
    var skills: schoolSkills
    
    init(id: Int, name: String, mascot: String, coach: String, prestige: Int, city: String, state: String, skills: schoolSkills) {
        self.id = id
        self.name = name
        self.mascot = mascot
        self.coach = coach
        self.prestige = prestige
        self.city = city
        self.state = state
        self.skills = skills
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case mascot
        case coach
        case city
        case state
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let mascot = try container.decode(String.self, forKey: .mascot)
        let coach = try container.decode(String.self, forKey: .coach)
        let city = try container.decode(String.self, forKey: .city)
        let state = try container.decode(String.self, forKey: .state)
        
        self.init(id: id, name: name, mascot: mascot, coach: coach, prestige: 0, city: city, state: state, skills: schoolSkills(facilities: 0, fundraising: 0, campus: 0, academics: 0, marketing: 0))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(coach, forKey: .coach)
        try container.encode(city, forKey: .city)
        try container.encode(state, forKey: .state)
    }
    
    //MIGHT MOVE TO GAME ENGINE PATTERN
    //generateHistory()
    
    //generateStats()
    //GenerateBoosters()
    //generateSchedule()
    
//    func encodeSchool () {
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted //Human readable
//        
//        do {
//            let jsonData = try encoder.encode(self)
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                
//            }
//        } catch {
//            
//        }
//    }
}
