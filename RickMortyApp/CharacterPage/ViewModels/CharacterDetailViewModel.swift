//
//  CharacterDetailViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import Foundation
// MARK: - View Model Protocol
protocol CharacterDetailViewModelProtocol {
    /// Model for the first table cell
    var character: CharacterModel? { get set }
    /// List to populate section 2 table data
    var episodeList: [String] { get set }
    /// Fetch character API
    /// - Parameter completion: get error message from API
    func getCharacter(completion: @escaping (String?) -> Void)
}

// MARK: - View Model
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
        // get data from API
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
