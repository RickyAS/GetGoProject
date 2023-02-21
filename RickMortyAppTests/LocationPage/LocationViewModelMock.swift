//
//  LocationViewModelMock.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import Foundation
@testable import RickMortyApp

class LocationViewModelMock: LocationViewModelProtocol {
    let service: MainServiceProtocol
    var locationList: [LocationModel] = []
    var searchText: String = ""
    
    init(service: MainServiceProtocol) {
        self.service = service
    }
    
    func getLocations(isReload: Bool, completion: @escaping (String?) -> Void) {
        service.getLocationList(page: 1, name: searchText) { [self] result in
            let errMsg = Service.ServiceError.decodingError.rawValue
            switch result {
            case .success(let response):
                locationList = response.results

                // Check by search text
                let name = locationList.first!.name.lowercased()
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
