//
//  CharacterCoordinator.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation
import UIKit
import BottomHalfModal
// MARK: - Coordinator Protocol
protocol CharacterCoordinatorDelegate: AnyObject{
    /// Push to Character Detail Page
    /// - Parameter id: Character id
    func openDetail(id: Int)
    /// Push to Character Filter Page
    ///  - Parameter completion: selected filter from `CharacterFilterModel`
    ///  - Parameter collections: tuple for status, species, gender
    func openFilter(filter: CharacterFilterModel, collections: ([CharacterStatus], [CharacterSpecies], [CharacterGender]))
    /// Dismiss to apply filter
    /// - Parameter status: selected status
    /// - Parameter species: selected species
    /// - Parameter gender: selected gender
    func closeFilter(status: String, species: String, gender: String)
    /// Get applied filter
    var getFiltered: ((CharacterFilterModel) -> Void)? { get set }
}

//MARK: - Coordinator
class CharacterCoordinator: Coordinator, CharacterCoordinatorDelegate {
    let navigation: UINavigationController
    var childs: [Coordinator] = []
    private let service: MainService
    private let title: String
    var getFiltered: ((CharacterFilterModel) -> Void)?
    
    init(_ navigation: UINavigationController, service: MainService, title: String) {
        self.navigation = navigation
        self.service = service
        self.title = title
    }
    
    func start() {
        let vm = CharacterViewModel(service: service)
        let vc = CharacterController(viewModel: vm, coordinator: self)
        vc.navigationItem.title = title
        navigation.pushViewController(vc, animated: true)
    }
    
    func openDetail(id: Int) {
        let vm = CharacterDetailViewModel(service: service, id: id)
        let vc = CharacterDetailController(viewModel: vm)
        navigation.navigationBar.prefersLargeTitles = false
        navigation.pushViewController(vc, animated: true)
    }
    
    func openFilter(filter: CharacterFilterModel, collections: ([CharacterStatus], [CharacterSpecies], [CharacterGender])) {
        let vc = CharacterFilterController(filter: filter, collections: collections, coordinator: self)
        navigation.viewControllers.last?.presentBottomHalfModal(vc, animated: true, completion: nil)
    }
    
    func closeFilter(status: String, species: String, gender: String) {
        let model = CharacterFilterModel(status: status, species: species, gender: gender)
        navigation.viewControllers.last?.dismiss(animated: true) {
            self.getFiltered?(model)
        }
    }
}
