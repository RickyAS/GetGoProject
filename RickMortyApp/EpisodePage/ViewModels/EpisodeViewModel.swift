//
//  EpisodeViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation

protocol EpisodeViewModelProtocol {
    var episodeList: [EpisodeModel] { get set }
    var searchText: String { get set }
    func getEpisodes(isReload: Bool, completion: @escaping (String?) -> Void)
}

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
        if isReload {
            page = 1
            isLastPage = false
        } else {
            page += 1
        }
        if isLastPage {
            completion(nil)
            return
        }
        isReload ? (page = 1) : (page += 1)
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
