//
//  MainServiceMock.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import Foundation
@testable import RickMortyApp

class MainServiceMock: MainServiceProtocol {
    var jsonString = ""
    
    func getCharacterList(page: Int, name: String, filter: CharacterFilterModel, completion: @escaping ParentResponse<[CharacterModel]>) {
        requestMock(responseType: BaseResponse<[CharacterModel]>.self, completion: completion)
    }
    
    func getCharacterDetail(id: Int, completion: @escaping Response<CharacterModel>) {
        requestMock(responseType: CharacterModel.self, completion: completion)
    }
    
    func getLocationList(page: Int, name: String, completion: @escaping ParentResponse<[LocationModel]>) {
        requestMock(responseType: BaseResponse<[LocationModel]>.self, completion: completion)
    }
    
    func getLocationDetail(id: Int, completion: @escaping Response<LocationModel>) {
        requestMock(responseType: LocationModel.self, completion: completion)
    }
    
    func getEpisodeList(page: Int, name: String, completion: @escaping ParentResponse<[EpisodeModel]>) {
        requestMock(responseType: BaseResponse<[EpisodeModel]>.self, completion: completion)
    }
    
    func getEpisodeDetail(id: Int, completion: @escaping Response<EpisodeModel>) {
        requestMock(responseType: EpisodeModel.self, completion: completion)
    }
    
    private func requestMock<T: Decodable>(responseType: T.Type, completion: @escaping (_ result: Result<T, Service.ServiceError>) -> Void) {
        let data = Data(jsonString.utf8)
        if let model = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(model))
        } else {
            completion(.failure(.decodingError))
        }
    }
}
