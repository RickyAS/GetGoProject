//
//  MainService.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation
// MARK: - Service Protocol
protocol MainServiceProtocol {
    /// Base completion result
    typealias ParentResponse<T:Decodable> = (Result<BaseResponse<T>,Service.ServiceError>) -> Void
    /// Base completion result alternative
    typealias Response<T:Decodable> = (Result<T,Service.ServiceError>) -> Void
    ///  Get characters
    /// - Parameter page: page number to get
    /// - Parameter name: find data based on search
    /// - Parameter filter: find data based on selected filters
    /// - Parameter completion: get fetched model
    func getCharacterList(page: Int, name: String, filter: CharacterFilterModel, completion: @escaping ParentResponse<[CharacterModel]>)
    ///  Get character detail
    /// - Parameter id: find data based on id
    /// - Parameter completion: get fetched model
    func getCharacterDetail(id: Int, completion: @escaping Response<CharacterModel>)
    ///  Get locations
    /// - Parameter page: page number to get
    /// - Parameter name: find data based on search
    /// - Parameter completion: get fetched model
    func getLocationList(page: Int, name: String, completion: @escaping ParentResponse<[LocationModel]>)
    ///  Get location detail
    /// - Parameter id: find data based on id
    /// - Parameter completion: get fetched model
    func getLocationDetail(id: Int, completion: @escaping Response<LocationModel>)
    ///  Get episodes
    /// - Parameter page: page number to get
    /// - Parameter name: find data based on search
    /// - Parameter completion: get fetched model
    func getEpisodeList(page: Int, name: String, completion: @escaping ParentResponse<[EpisodeModel]>)
    ///  Get episode detail
    /// - Parameter id: find data based on id
    /// - Parameter completion: get fetched model
    func getEpisodeDetail(id: Int, completion: @escaping Response<EpisodeModel>)
}

// MARK: - Service
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
