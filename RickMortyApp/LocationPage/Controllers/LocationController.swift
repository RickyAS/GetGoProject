//
//  LocationController.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import UIKit

class LocationController: BaseViewController {
    private var viewModel: LocationViewModelProtocol
    private let coordinator: LocationCoordinator
    
    init(viewModel: LocationViewModelProtocol, coordinator: LocationCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(pageType: .table)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchControl.searchBar.delegate = self
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(UINib(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: "LocationCell")
        showLoader()
        getLocations(isReload: true)
    }
    
    private func getLocations(isReload: Bool) {
        viewModel.getLocations(isReload: isReload) { [unowned self] errMsg in
            dismissLoader()
            if let errMsg = errMsg {
                showErrorAlert(message: errMsg)
            }
            mainTable.reloadData()
        }
    }
}

extension LocationController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as? LocationCell
        cell?.setupValues(item: viewModel.locationList[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.locationList.count-1 && indexPath.row > 6 {
            getLocations(isReload: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.locationList[indexPath.row]
        coordinator.openDetail(id: item.id)
    }
}

extension LocationController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchText = searchBar.text ?? ""
        getLocations(isReload: true)
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchText = ""
        getLocations(isReload: true)
    }
}
