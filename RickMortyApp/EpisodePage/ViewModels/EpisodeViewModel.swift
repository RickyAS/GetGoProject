//
//  EpisodeViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation
// MARK: - View Model Protocol
protocol EpisodeViewModelProtocol {
    /// List to populate table data
    var episodeList: [EpisodeModel] { get set }
    /// Retrive text from search bar controller
    var searchText: String { get set }
    /// Fetch episode API
    /// - Parameter isReload: set `true`  to fetch more pages
    /// - Parameter completion: get error message from API
    func getEpisodes(isReload: Bool, completion: @escaping (String?) -> Void)
}

// MARK: - View Model
class EpisodeViewModel: EpisodeViewModelProtocol {
    private let service: MainServiceProtocol
    init(service: MainServiceProtocol) {
        self.service = service
    }
    private var page = 1
    private var isLastPage: Bool = false
    var episodeList: [EpisodeModel] = []
    var searchText: String = ""
    
    func getEpisodes(isReload: Bool, completion: @escaping (String?) -> Void) {
        // reload to restart page
        if isReload {
            page = 1
            isLastPage = false
        } else {
            page += 1
        }
        
        // stop fetching when it reaches the last page
        if isLastPage {
            completion(nil)
            return
        }
        
        // get data from API
        service.getEpisodeList(page: page, name: searchText) { [unowned self] result in
            switch result {
            case .success(let response):
                isLastPage = response.info.pages == page
                if  isReload {
                    episodeList = response.results
                } else {
                    episodeList += response.results
                }
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
}
