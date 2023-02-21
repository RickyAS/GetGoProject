//
//  LocationModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation
// MARK: - Base Model Decodable
struct BaseResponse<T:Decodable>: Decodable{
    let info: InfoModel
    let results: T
    
    struct InfoModel: Decodable{
        let count: Int
        let pages: Int
    }
}

// MARK: - Main Location Model
struct LocationModel: Decodable{
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents : [String]
    let url : String
    let created: String
}
