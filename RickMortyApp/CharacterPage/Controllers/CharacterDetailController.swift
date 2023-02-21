//
//  CharacterDetailController.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import UIKit

class CharacterDetailController: BaseViewController {
    private let viewModel: CharacterDetailViewModelProtocol
    init(viewModel: CharacterDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(pageType: .table)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let cellId = "CharacterDetailCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.dataSource = self
        mainTable.delegate = self
        mainTable.allowsSelection = false
        mainTable.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        navigationItem.searchController = nil
        showLoader()
        getCharacter()
    }

    private func getCharacter() {
        viewModel.getCharacter { [unowned self] errMsg in
            dismissLoader()
            if let errMsg = errMsg {
                showErrorAlert(message: errMsg)
            }
            mainTable.reloadData()
            navigationItem.title = viewModel.character?.name
        }
    }
}

extension CharacterDetailController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        var content = header.defaultContentConfiguration()
        content.text = "Episodes:"
        content.textProperties.color = .label
        content.textProperties.font = .systemFont(ofSize: 17, weight: .semibold)
        header.contentConfiguration = content
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? nil : "Episodes:"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : viewModel.episodeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CharacterDetailCell
            if let item = viewModel.character {
                cell?.setupValues(item: item)
            }
            return cell ?? UITableViewCell()
        }
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.episodeList[indexPath.row]
        content.textProperties.font = .systemFont(ofSize: 14, weight: .regular)
        cell.contentConfiguration = content
        return cell
    }
}


