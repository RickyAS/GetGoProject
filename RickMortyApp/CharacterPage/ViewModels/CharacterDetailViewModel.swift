//
//  CharacterDetailViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import Foundation

protocol CharacterDetailViewModelProtocol {
    var character: CharacterModel? { get set }
    var episodeList: [String] { get set }
    func getCharacter(completion: @escaping (String?) -> Void)
}

class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    let service: MainServiceProtocol
    let id: Int
    init(service: MainServiceProtocol, id: Int) {
        self.service = service
        self.id = id
    }
    
    var character: CharacterModel?
    var episodeList: [String] = []
    
    func getCharacter(completion: @escaping (String?) -> Void) {
        service.getCharacterDetail(id: id) { [unowned self] result in
            switch result {
            case .success(let model):
                character = model
                episodeList = model.episode
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
}
