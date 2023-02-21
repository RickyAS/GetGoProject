//
//  EpisodeCoordinator.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation
import UIKit
// MARK: - Coordinator Protocol
protocol EpisodeCoordinatorDelegate: AnyObject{
    /// Present Episode Detail Page
    /// - Parameter id: Episode id
    func openDetail(id: Int)
}

// MARK: - Coordinator
class EpisodeCoordinator: Coordinator, EpisodeCoordinatorDelegate {
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
        let vm = EpisodeViewModel(service: service)
        let vc = EpisodeController(viewModel: vm, coordinator: self)
        vc.navigationItem.title = title
        navigation.pushViewController(vc, animated: true)
    }
    
    func openDetail(id: Int) {
        let vm = EpisodeDetailViewModel(service: service, id: id)
        let vc = EpisodeDetailController(viewModel: vm, coordinator: self)
        let nav = UINavigationController(rootViewController: vc)
        navigation.viewControllers.last?.present(nav, animated: true)
    }
}
