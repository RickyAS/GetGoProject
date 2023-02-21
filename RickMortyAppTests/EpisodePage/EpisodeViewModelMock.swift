//
//  EpisodeViewModelMock.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import Foundation
@testable import RickMortyApp

class EpisodeViewModelMock: EpisodeViewModelProtocol {
    let service: MainServiceProtocol
    var episodeList: [EpisodeModel] = []
    var searchText: String = ""
    
    init(service: MainServiceProtocol) {
        self.service = service
    }
    
    func getEpisodes(isReload: Bool, completion: @escaping (String?) -> Void) {
        service.getEpisodeList(page: 1, name: searchText) { [self] result in
            let errMsg = Service.ServiceError.decodingError.rawValue
            switch result {
            case .success(let response):
                episodeList = response.results

                // Check by search text
                let name = episodeList.first!.name.lowercased()
                if !searchText.lowercased().isEmpty && !name.hasPrefix(searchText) {
                    completion(errMsg)
                    return
                }
                
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
    
    
}
