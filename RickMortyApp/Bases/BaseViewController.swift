//
//  BaseTableController.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import UIKit
// MARK: Template for Table and Collection based Controller
class BaseViewController: UIViewController {
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var mainCollection: UICollectionView!
    lazy var searchControl = UISearchController()
        
    enum PageType {
        case table, collection
    }
    let pageType: PageType?
    
    /// Select base page type
    init(pageType: PageType?) {
        self.pageType = pageType
        super.init(nibName: "BaseViewController", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide unsused view based on page type
        mainTable.isHidden = pageType != .table
        mainCollection.isHidden = pageType != .collection
        
        // Set filter button for view with collectionview only
        let filterButton = UIBarButtonItem(image: UIImage(named: "nav_filter"), style: .plain, target: self, action: #selector(didTapFilter(_:)))
        navigationItem.rightBarButtonItem = pageType == .collection ? filterButton : nil
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back", style: .plain, target: nil, action: nil)
        
        // Set search bar for navigation bar
        navigationItem.searchController = searchControl
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    /// Open filter page when filter button is pressed
    @objc func didTapFilter(_ sender: UIBarButtonItem) {
        
    }
    
    /// Show alert for API errors
    /// - Parameter message: error message
    func showErrorAlert(message : String) {
        let alert = UIAlertController(title: "There's a mistake", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close", style: .cancel))
        navigationController?.viewControllers.last?.present(alert, animated: true, completion: nil)
    }
    
    /// Show loading indicator, used when fetching API
    func showLoader() {
        guard let navigation = navigationController else { return }
        let loader = UIActivityIndicatorView(style: .large)
        loader.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loader.frame = CGRect(x: 0, y: 0, width: navigation.view.frame.width, height: navigation.view.frame.height)
        loader.startAnimating()
        navigation.viewControllers.last?.view.addSubview(loader)
        loader.center = navigation.view.center
    }
    
    /// Dismiss loading indicator, used when done fetching API
    func dismissLoader() {
        navigationController?.viewControllers.last?.view.subviews.compactMap { $0 as? UIActivityIndicatorView }.forEach {
            $0.backgroundColor = .clear
            $0.removeFromSuperview()
        }
    }
}
