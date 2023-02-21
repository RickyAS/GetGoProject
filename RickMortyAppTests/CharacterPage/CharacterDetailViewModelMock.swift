//
//  CharacterDetailViewModelMock.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import Foundation
@testable import RickMortyApp

class CharacterDetailViewModelMock: CharacterDetailViewModelProtocol {
    let service: MainServiceProtocol
    let id: Int
    var character: CharacterModel?
    
    var episodeList: [String] = []
    
    init(service: MainServiceProtocol, id: Int) {
        self.service = service
        self.id = id
    }
    
    func getCharacter(completion: @escaping (String?) -> Void) {
        service.getCharacterDetail(id: id) { [self] result in
            switch result {
            case .success(let model):
                // Check by id
                if self.id != model.id {
                    completion(Service.ServiceError.decodingError.rawValue)
                    return
                }
                character = model
                episodeList = model.episode
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
    
    
}
