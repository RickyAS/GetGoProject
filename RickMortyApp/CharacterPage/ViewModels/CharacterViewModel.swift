//
//  CharacterViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation

protocol CharacterViewModelProtocol {
    /// List to populate table view
    var charList: [CharacterModel] { get set }
    var charFilter: CharacterFilterModel { get set }
    var searchText: String { get set }
    var filterCols: ([CharacterStatus], [CharacterSpecies], [CharacterGender]) { get }
    func getCharacters(isReload: Bool, completion: @escaping (String?) -> Void)
}

class CharacterViewModel: CharacterViewModelProtocol {
    private let service: MainServiceProtocol
    init(service: MainServiceProtocol) {
        self.service = service
    }
    
    private var page = 1
    private var isLastPage: Bool = false
    var charList: [CharacterModel] = []
    var charFilter: CharacterFilterModel = .init()
    var searchText: String = ""
    
    var filterCols: ([CharacterStatus], [CharacterSpecies], [CharacterGender]) {
        let status: [CharacterStatus] = [.alive, .dead, .unknown]
        let species: [CharacterSpecies] = [.alien, .animal, .mythological, .human]
        let gender: [CharacterGender] = [.male, .female, .genderless, .unknown]
        return (status, species, gender)
    }
    
    func getCharacters(isReload: Bool, completion: @escaping (String?) -> Void) {
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
        service.getCharacterList(page: page, name: searchText, filter: charFilter) { [unowned self] result in
            switch result {
            case .success(let response):
                isLastPage = response.info.pages <= page
                if  isReload {
                    charList = response.results
                } else {
                    charList += response.results
                }
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
}

