//
//  LocationViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation

protocol LocationViewModelProtocol {
    var locationList: [LocationModel] { get set }
    var searchText: String { get set }
    func getLocations(isReload: Bool, completion: @escaping (String?) -> Void)
}

class LocationViewModel: LocationViewModelProtocol {
    private let service: MainServiceProtocol
    init(service: MainServiceProtocol) {
        self.service = service
    }
    private var page = 1
    private var isLastPage: Bool = false
    var locationList: [LocationModel] = []
    var searchText: String = ""
    
    func getLocations(isReload: Bool, completion: @escaping (String?) -> Void) {
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
        service.getLocationList(page: page, name: searchText) { [unowned self] result in
            switch result {
            case .success(let response):
                isLastPage = response.info.pages == page
                if  isReload {
                    locationList = response.results
                } else {
                    locationList += response.results
                }
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
}
