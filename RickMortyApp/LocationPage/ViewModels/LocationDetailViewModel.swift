//
//  LocationDetailViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import Foundation

protocol LocationDetailViewModelProtocol {
    var location: LocationModel? { get set }
    var residentList: [String] { get set }
    func getLocation(completion: @escaping (String?) -> Void)
}

class LocationDetailViewModel: LocationDetailViewModelProtocol {
    let service: MainServiceProtocol
    let id: Int
    init(service: MainServiceProtocol, id: Int) {
        self.service = service
        self.id = id
    }
    
    var location: LocationModel?
    var residentList: [String] = []
    
    func getLocation(completion: @escaping (String?) -> Void) {
        service.getLocationDetail(id: id) { [unowned self] result in
            switch result {
            case .success(let model):
                location = model
                residentList = model.residents
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
}
