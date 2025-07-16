//
//  School.swift
//  CollegeBasketballDynastyIOS
//
//  Created by Al Rotter on 7/15/25.
//

import Foundation

struct schoolSkills: Codable {
    
    let facilities: Int
    let fundraising: Int
    let campus: Int
    let academics: Int
    let marketing: Int
}

class school: Codable, Identifiable {
    let id: Int
    let name: String
    let mascot: String
    var coach: String
    var prestige: Int
    let city: String
    let state: String
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
    
    func encodeSchool () {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted //Human readable
        
        do {
            let jsonData = try encoder.encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                
            }
        } catch {
            
        }
    }
}
