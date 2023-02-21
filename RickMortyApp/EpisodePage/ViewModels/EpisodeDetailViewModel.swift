//
//  EpisodeDetailViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import Foundation

protocol EpisodeDetailViewModelProtocol {
    var episode: EpisodeModel? { get set }
    var characterList: [String] { get set }
    func getEpisode(completion: @escaping (String?) -> Void)
}

class EpisodeDetailViewModel: EpisodeDetailViewModelProtocol {
    let service: MainServiceProtocol
    let id: Int
    init(service: MainServiceProtocol, id: Int) {
        self.service = service
        self.id = id
    }
    
    var episode: EpisodeModel?
    var characterList: [String] = []
    
    func getEpisode(completion: @escaping (String?) -> Void) {
        service.getEpisodeDetail(id: id) { [unowned self] result in
            switch result {
            case .success(let model):
                episode = model
                characterList = model.characters
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
}
