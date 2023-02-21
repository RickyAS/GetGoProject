//
//  LocationDetailViewModelMock.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import Foundation
@testable import RickMortyApp

class LocationDetailViewModelMock: LocationDetailViewModelProtocol {
    let service: MainServiceProtocol
    let id: Int
    var location: LocationModel?
    var residentList: [String] = []
    
    init(service: MainServiceProtocol, id: Int) {
        self.service = service
        self.id = id
    }
    
    func getLocation(completion: @escaping (String?) -> Void) {
        service.getLocationDetail(id: id) { [self] result in
            switch result {
            case .success(let model):
                // Check by id
                if self.id != model.id {
                    completion(Service.ServiceError.decodingError.rawValue)
                    return
                }
                location = model
                residentList = model.residents
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
}
