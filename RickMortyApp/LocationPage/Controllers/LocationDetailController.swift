//
//  LocationDetailController.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import UIKit
// MARK: - Main Controller
class LocationDetailController: BaseViewController {
    private let viewModel: LocationDetailViewModelProtocol
    
    init(viewModel: LocationDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(pageType: .table)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let cellId = "LocationDetailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.dataSource = self
        mainTable.delegate = self
        mainTable.allowsSelection = false
        mainTable.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        navigationItem.searchController = nil
        showLoader()
        getLocation()
    }
    
    /// Get location data from view model
    private func getLocation() {
        viewModel.getLocation { [unowned self] errMsg in
            dismissLoader()
            if let errMsg = errMsg {
                showErrorAlert(message: errMsg)
            }
            mainTable.reloadData()
            navigationItem.title = viewModel.location?.name
        }
    }
}

// MARK: - Table View
extension LocationDetailController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        var content = header.defaultContentConfiguration()
        content.text = "Residents:"
        content.textProperties.color = .label
        content.textProperties.font = .systemFont(ofSize: 17, weight: .semibold)
        header.contentConfiguration = content
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? nil : "Residents:"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : viewModel.residentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? LocationDetailCell
            if let item = viewModel.location {
                cell?.setupValues(item: item)
            }
            return cell ?? UITableViewCell()
        }
        
        // display reference list in default cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.residentList[indexPath.row]
        content.textProperties.font = .systemFont(ofSize: 14, weight: .regular)
        cell.contentConfiguration = content
        return cell
    }
}
