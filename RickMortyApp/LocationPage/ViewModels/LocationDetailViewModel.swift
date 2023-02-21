//
//  LocationDetailViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import Foundation
// MARK: - View Model Protocol
protocol LocationDetailViewModelProtocol {
    /// Model for the first table cell
    var location: LocationModel? { get set }
    /// List to populate section 2 table data
    var residentList: [String] { get set }
    /// Fetch location API
    /// - Parameter completion: get error message from API
    func getLocation(completion: @escaping (String?) -> Void)
}

// MARK: - View Model
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
        // get data from API
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
