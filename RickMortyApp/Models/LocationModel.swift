//
//  LocationModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation

struct BaseResponse<T:Decodable>: Decodable{
    let info: InfoModel
    let results: T
    
    struct InfoModel: Decodable{
        let count: Int
        let pages: Int
    }
}

struct LocationModel: Decodable{
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents : [String]
    let url : String
    let created: String
}
