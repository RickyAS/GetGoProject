//
//  EpisodeDetailViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import Foundation

protocol EpisodeDetailViewModelProtocol {
    /// Model for the first table cell
    var episode: EpisodeModel? { get set }
    /// List to populate section 2 table data
    var characterList: [String] { get set }
    /// Fetch episode API
    /// - Parameter completion: get error message from API
    func getEpisode(completion: @escaping (String?) -> Void)
}

// MARK: - View Model
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
        // get data from API
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
