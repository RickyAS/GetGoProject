//
//  EpisodeController.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import UIKit
//MARK: - Main Controller
class EpisodeController: BaseViewController {
    private var viewModel: EpisodeViewModelProtocol
    private let coordinator: EpisodeCoordinator
    
    init(viewModel: EpisodeViewModelProtocol, coordinator: EpisodeCoordinator) {
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
        mainTable.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
        showLoader()
        getEpisodes(isReload: true)
    }
    
    /// Get episode list from view model
    private func getEpisodes(isReload: Bool) {
        viewModel.getEpisodes(isReload: isReload) { [unowned self] errMsg in
            dismissLoader()
            if let errMsg = errMsg {
                showErrorAlert(message: errMsg)
            }
            mainTable.reloadData()
        }
    }

}

// MARK: - Table View
extension EpisodeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.episodeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell") as? EpisodeCell
        cell?.setupValues(item: viewModel.episodeList[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.episodeList.count-1 && indexPath.row > 6 {
            getEpisodes(isReload: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.episodeList[indexPath.row]
        coordinator.openDetail(id: item.id)
    }
}

// MARK: - Search Bar
extension EpisodeController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchText = searchBar.text ?? ""
        getEpisodes(isReload: true)
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchText = ""
        getEpisodes(isReload: true)
    }
}

