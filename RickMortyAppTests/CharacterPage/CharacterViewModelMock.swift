//
//  CharacterViewModelMock.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import Foundation
@testable import RickMortyApp

class CharacterViewModelMock: CharacterViewModelProtocol {
    let service: MainServiceProtocol
    var charList: [CharacterModel] = []
    var charFilter = CharacterFilterModel.init()
    var searchText: String = ""
    var filterCols: ([RickMortyApp.CharacterStatus], [RickMortyApp.CharacterSpecies], [RickMortyApp.CharacterGender]) {
        return ([],[],[])
    }
    
    init(service: MainServiceProtocol) {
        self.service = service
    }
    
    func getCharacters(isReload: Bool, completion: @escaping (String?) -> Void) {
        service.getCharacterList(page: 1, name: searchText, filter: charFilter) { [self] result in
            let errMsg = Service.ServiceError.decodingError.rawValue
            switch result {
            case .success(let response):
                charList = response.results

                // Check by search text
                let name = charList.first!.name.lowercased()
                if !searchText.lowercased().isEmpty && !name.hasPrefix(searchText) {
                    completion(errMsg)
                    return
                }
                
                // Check by filter
                let status = charList.first!.status.lowercased()
                if !charFilter.status.isEmpty && !status.hasPrefix(charFilter.status.lowercased()) {
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
