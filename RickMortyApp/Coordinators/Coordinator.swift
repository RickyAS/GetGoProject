//
//  Coordinator.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation
import UIKit

protocol Coordinator {
    /// Init parent navigation controller
    var navigation: UINavigationController { get }
    ///  Keep other coordinators which start from one coordiantor parent
    var childs: [Coordinator] { get set }
    /// Push initial view of the coordinator
    func start()
}

class TabCoordinator: Coordinator {
    let navigation: UINavigationController
    var childs: [Coordinator] = []
    private let tabBar: UITabBarController
    private let service: MainService
    
    required init(_ navigation: UINavigationController) {
        self.navigation = navigation
        self.tabBar = UITabBarController()
        self.service = MainService()
        navigation.setNavigationBarHidden(true, animated: true)
    }
    
    enum TabPage: String{
        case character, location, episode
        
        var img: String {
            switch self {
            case .character: return "bar_character"
            case .location: return "bar_location"
            case .episode: return "bar_episode"
            }
        }
    }
    
    func start() {
        let pages: [TabPage] = [.character, .location, .episode]
        let controllers: [UINavigationController] =  pages.map({ getTabController($0) })
        tabBar.setViewControllers(controllers, animated: true)
        tabBar.selectedIndex = 0
        navigation.viewControllers = [tabBar]
    }
    
    /// Get pages from each tab
    private func getTabController(_ page: TabPage) -> UINavigationController {
        // Setup tab bar style
        let size = CGSize(width: 32, height: 32)
        let nav = UINavigationController()
        nav.setNavigationBarHidden(false, animated: false)
        nav.tabBarItem.title = page.rawValue.capitalized
        nav.tabBarItem.image = UIImage(named: "\(page.img)_off")?.resize(size: size)
        nav.tabBarItem.selectedImage = UIImage(named: page.img)?.resize(size: size)
        nav.navigationBar.prefersLargeTitles = true
        
        // Start each tab's coordinator and append each to the `childs` array
        switch page {
        case .character:
            let coordinator = CharacterCoordinator(nav, service: service, title: page.rawValue.capitalized)
            childs.append(coordinator)
            coordinator.start()
        case .location:
            let coordinator = LocationCoordinator(nav, service: service, title: page.rawValue.capitalized)
            childs.append(coordinator)
            coordinator.start()
        case .episode:
            let coordinator = EpisodeCoordinator(nav, service: service, title: page.rawValue.capitalized)
            childs.append(coordinator)
            coordinator.start()
        }
        return nav
    }
}
