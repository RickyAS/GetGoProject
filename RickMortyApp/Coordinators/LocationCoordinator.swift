//
//  LocationCoordinator.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation
import UIKit
// MARK: - Coordinator Protocol
protocol LocationCoordinatorDelegate: AnyObject{
    /// Present Location Detail Page
    /// - Parameter id: Location id
    func openDetail(id: Int)
}

// MARK: - Coordinator
class LocationCoordinator: Coordinator, LocationCoordinatorDelegate {
    let navigation: UINavigationController
    var childs: [Coordinator] = []
    private let service: MainService
    private let title: String
    
    init(_ navigation: UINavigationController, service: MainService, title: String) {
        self.navigation = navigation
        self.service = service
        self.title = title
    }
    
    func start() {
        let vm = LocationViewModel(service: service)
        let vc = LocationController(viewModel: vm, coordinator: self)
        vc.navigationItem.title = title
        navigation.pushViewController(vc, animated: true)
    }
    
    func openDetail(id: Int) {
        let vm = LocationDetailViewModel(service: service, id: id)
        let vc = LocationDetailController(viewModel: vm)
        let nav = UINavigationController(rootViewController: vc)
        navigation.viewControllers.last?.present(nav, animated: true)
    }
}
