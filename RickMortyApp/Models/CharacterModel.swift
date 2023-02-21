//
//  CharacterModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation

struct CharacterModel: Decodable{
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin : NameModel
    let location : NameModel
    let episode : [String]
    let image: String
    let created: String
    
    struct NameModel: Decodable {
        let name: String
        let url: String
    }
}

struct CharacterFilterModel {
    let status: String
    let species: String
    let gender: String
    
    init(status: String, species: String, gender: String) {
        self.status = status
        self.species = species
        self.gender = gender
    }
    
    init() {
        self.status = ""
        self.species = ""
        self.gender = ""
    }
}


enum CharacterStatus: String {
    case alive, dead, unknown
    
    var icon: String {
        switch self {
        case .alive: return "status_alive"
        case .dead: return "status_dead"
        case .unknown: return "status_unknown"
        }
    }
}

enum CharacterSpecies: String {
    case human, humanoid, alien, poopybutthole, cronenberg
    case mythological = "mythological creature"
    case animal, robot, disease, unknown
}

enum CharacterGender: String {
    case male, female, genderless, unknown
    
    var icon: String {
        switch self {
        case .male: return "gender_male"
        case .female: return "gender_female"
        case .genderless: return "gender_agender"
        case .unknown: return "status_unknown"
        }
    }
}

