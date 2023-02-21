//
//  CharacterViewModel.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation
// MARK: - View Model Protocol
protocol CharacterViewModelProtocol {
    /// List to populate table data
    var charList: [CharacterModel] { get set }
    /// Retrive filter from Character Filter Modal
    var charFilter: CharacterFilterModel { get set }
    /// Retrive text from search bar controller
    var searchText: String { get set }
    /// Filter selections in Character Filter Modal
    /// - Parameter 0: status
    /// - Parameter 1: species
    /// - Parameter 2: gender
    var filterCols: ([CharacterStatus], [CharacterSpecies], [CharacterGender]) { get }
    /// Fetch character API
    /// - Parameter isReload: set `true`  to fetch more pages
    /// - Parameter completion: get error message from API
    func getCharacters(isReload: Bool, completion: @escaping (String?) -> Void)
}

// MARK: - View Model
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

