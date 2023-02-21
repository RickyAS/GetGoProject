//
//  LocationViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation
// MARK: - View Model Protocol
protocol LocationViewModelProtocol {
    /// List to populate table data
    var locationList: [LocationModel] { get set }
    /// Retrive text from search bar controller
    var searchText: String { get set }
    /// Fetch location API
    /// - Parameter isReload: set `true`  to fetch more pages
    /// - Parameter completion: get error message from API
    func getLocations(isReload: Bool, completion: @escaping (String?) -> Void)
}

// MARK: - View Model
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
