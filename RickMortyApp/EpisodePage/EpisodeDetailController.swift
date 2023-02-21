//
//  EpisodeDetailController.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import UIKit

class EpisodeDetailController: BaseViewController {
    private let viewModel: EpisodeDetailViewModelProtocol
    unowned let coordinator: EpisodeCoordinator
    
    init(viewModel: EpisodeDetailViewModelProtocol, coordinator: EpisodeCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(pageType: .table)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let cellId = "LocationDetailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.dataSource = self
        mainTable.delegate = self
        mainTable.allowsSelection = false
        mainTable.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        navigationItem.searchController = nil
        showLoader()
        getEpisode()
    }
    
    private func getEpisode() {
        viewModel.getEpisode { [unowned self] errMsg in
            dismissLoader()
            if let errMsg = errMsg {
                showErrorAlert(message: errMsg)
            }
            mainTable.reloadData()
            navigationItem.title = viewModel.episode?.name
        }
    }
}

extension EpisodeDetailController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        var content = header.defaultContentConfiguration()
        content.text = "Characters:"
        content.textProperties.color = .label
        content.textProperties.font = .systemFont(ofSize: 17, weight: .semibold)
        header.contentConfiguration = content
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? nil : "Characters:"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : viewModel.characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? LocationDetailCell
            if let item = viewModel.episode {
                cell?.setupValues(item: item)
            }
            return cell ?? UITableViewCell()
        }
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.characterList[indexPath.row]
        content.textProperties.font = .systemFont(ofSize: 14, weight: .regular)
        cell.contentConfiguration = content
        return cell
    }
}

