//
//  EpisodeDetailViewModelMock.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import Foundation
@testable import RickMortyApp

class EpisodeDetailViewModelMock: EpisodeDetailViewModelProtocol {
    let service: MainServiceProtocol
    let id: Int
    var episode: EpisodeModel?
    var characterList: [String] = []
    
    init(service: MainServiceProtocol, id: Int) {
        self.service = service
        self.id = id
    }
    
    func getEpisode(completion: @escaping (String?) -> Void) {
        service.getEpisodeDetail(id: id) { [self] result in
            switch result {
            case .success(let model):
                // Check by id
                if self.id != model.id {
                    completion(Service.ServiceError.decodingError.rawValue)
                    return
                }
                episode = model
                characterList = model.characters
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
}
