//
//  CharacterFilterController.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import UIKit

class CharacterFilterController: UIViewController {
    @IBOutlet weak var colStatus: UICollectionView!
    @IBOutlet weak var colSpecies: UICollectionView!
    @IBOutlet weak var colGender: UICollectionView!
    private unowned let coordinator: CharacterCoordinatorDelegate
    private var statusList = [""]
    private var speciesList = [""]
    private var genderList = [""]
    
    private var selectedStatus = ""
    private var selectedSpecies = ""
    private var selectedGender = ""
    
    private let cellId = "CharacterFilterCell"
    var onSelectFilter: ((CharacterFilterModel) -> Void)?
    
    init(filter: CharacterFilterModel, collections: ([CharacterStatus], [CharacterSpecies], [CharacterGender]), coordinator: CharacterCoordinatorDelegate) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
        let col = collections
        self.statusList += col.0.map({$0.rawValue})
        self.speciesList += col.1.map({$0.rawValue})
        self.genderList += col.2.map({$0.rawValue})
        
        self.selectedStatus = filter.status
        self.selectedSpecies = filter.species
        self.selectedGender = filter.gender
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollections()
    }
    
    private func setupCollections() {
        [colStatus, colSpecies, colGender].forEach({
            let nib = UINib(nibName: cellId, bundle: nil)
            $0?.dataSource = self
            $0?.delegate = self
            $0?.register(nib, forCellWithReuseIdentifier: cellId)
            $0?.reloadData()
        })
        
        [colStatus, colGender].forEach({
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 8.0
            flowLayout.minimumLineSpacing = 12.0
            $0?.collectionViewLayout = flowLayout
        })
        
        let flowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .leading, verticalAlignment: .center)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumInteritemSpacing = 8.0
        flowLayout.minimumLineSpacing = 12.0
        colSpecies.collectionViewLayout = flowLayout
    }


    @IBAction func didTapBtnApply(_ sender: Any) {
        coordinator.closeFilter(status: selectedStatus, species: selectedSpecies, gender: selectedGender)
    }
}

extension CharacterFilterController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case colStatus :
            return statusList.count
        case colSpecies:
            return speciesList.count
        case colGender:
            return genderList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CharacterFilterCell else {
            return UICollectionViewCell()
        }
        
        switch collectionView {
        case colStatus:
            let item = statusList[indexPath.row]
            cell.setupValues(name: item, isSelected: item == selectedStatus)
        case colSpecies:
            let item = speciesList[indexPath.row]
            cell.setupValues(name: item, isSelected: item == selectedSpecies)
        case colGender:
            let item = genderList[indexPath.row]
            cell.setupValues(name: item, isSelected: item == selectedGender)
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case colStatus:
            selectedStatus = statusList[indexPath.row]
            colStatus.reloadData()
        case colSpecies:
            selectedSpecies = speciesList[indexPath.row]
            colSpecies.reloadData()
        case colGender:
            selectedGender = genderList[indexPath.row]
            colGender.reloadData()
        default:
            break
        }
    }
}
