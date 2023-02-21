//
//  MainService.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation

protocol MainServiceProtocol {
    typealias ParentResponse<T:Decodable> = (Result<BaseResponse<T>,Service.ServiceError>) -> Void
    typealias Response<T:Decodable> = (Result<T,Service.ServiceError>) -> Void
    func getCharacterList(page: Int, name: String, filter: CharacterFilterModel, completion: @escaping ParentResponse<[CharacterModel]>)
    func getCharacterDetail(id: Int, completion: @escaping Response<CharacterModel>)
    func getLocationList(page: Int, name: String, completion: @escaping ParentResponse<[LocationModel]>)
    func getLocationDetail(id: Int, completion: @escaping Response<LocationModel>)
    func getEpisodeList(page: Int, name: String, completion: @escaping ParentResponse<[EpisodeModel]>)
    func getEpisodeDetail(id: Int, completion: @escaping Response<EpisodeModel>)
}

class MainService: MainServiceProtocol {
    func getCharacterList(page: Int, name: String, filter: CharacterFilterModel, completion: @escaping ParentResponse<[CharacterModel]>) {
        var param: [String:Any] = ["page": page]
        if !name.isEmpty {
            param["name"] = name
        }
        if !filter.status.isEmpty {
            param["status"] = filter.status
        }
        if !filter.species.isEmpty {
            param["species"] = filter.species
        }
        if !filter.gender.isEmpty {
            param["gender"] = filter.gender
        }
        Service.shared.request(.get, .character(ids: []), parameters: param, responseType: BaseResponse<[CharacterModel]>.self, completion: completion)
    }
    
    func getCharacterDetail(id: Int, completion: @escaping Response<CharacterModel>) {
        Service.shared.request(.get, .character(ids: [id]), responseType: CharacterModel.self, completion: completion)
    }
    
    func getLocationList(page: Int, name: String, completion: @escaping ParentResponse<[LocationModel]>) {
        var param: [String:Any] = ["page": page]
        if !name.isEmpty {
            param["name"] = name
        }
        Service.shared.request(.get, .location(ids: []), parameters: param, responseType: BaseResponse<[LocationModel]>.self, completion: completion)
    }
    
    func getLocationDetail(id: Int, completion: @escaping Response<LocationModel>) {
        Service.shared.request(.get, .location(ids: [id]), responseType: LocationModel.self, completion: completion)
    }
    
    func getEpisodeList(page: Int, name: String, completion: @escaping ParentResponse<[EpisodeModel]>) {
        var param: [String:Any] = ["page": page]
        if !name.isEmpty {
            param["name"] = name
        }
        Service.shared.request(.get, .episode(ids: []), parameters: param, responseType: BaseResponse<[EpisodeModel]>.self, completion: completion)
    }
    
    func getEpisodeDetail(id: Int, completion: @escaping Response<EpisodeModel>) {
        Service.shared.request(.get, .episode(ids: [id]), responseType: EpisodeModel.self, completion: completion)
    }
    
}
