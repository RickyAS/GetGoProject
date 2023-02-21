//
//  CharacterController.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import UIKit

class CharacterController: BaseViewController {
    private var viewModel: CharacterViewModelProtocol
    unowned let coordinator: CharacterCoordinatorDelegate
    private let cellId = "CharacterCell"
    
    init(viewModel: CharacterViewModelProtocol, coordinator: CharacterCoordinatorDelegate) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(pageType: .collection)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchControl.searchBar.delegate = self
        mainCollection.delegate = self
        mainCollection.dataSource = self
        mainCollection.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        showLoader()
        getCharacters(isReload: true)
    }
    
    func getCharacters(isReload: Bool) {
        viewModel.getCharacters(isReload: isReload) { [unowned self] errMsg in
            dismissLoader()
            if let errMsg = errMsg {
                showErrorAlert(message: errMsg)
            }
            mainCollection.reloadData()
        }
    }
    
    override func didTapFilter(_ sender: UIBarButtonItem) {
        coordinator.openFilter(filter: viewModel.charFilter, collections: viewModel.filterCols)
        coordinator.getFiltered = { [unowned self] filter in
            viewModel.charFilter = filter
            showLoader()
            getCharacters(isReload: true)
        }
    }
}

extension CharacterController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.charList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2) - 18, height: collectionView.frame.width * 0.65)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CharacterCell
        cell?.setupValues(item: viewModel.charList[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.charList.count-1 && indexPath.row > 6 {
            getCharacters(isReload: false)
        } else if indexPath.row < 1 {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else if indexPath.row > 6 {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.charList[indexPath.row]
        coordinator.openDetail(id: item.id)
    }
}

extension CharacterController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchText = searchBar.text ?? ""
        getCharacters(isReload: true)
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchText = ""
        getCharacters(isReload: true)
    }
}
