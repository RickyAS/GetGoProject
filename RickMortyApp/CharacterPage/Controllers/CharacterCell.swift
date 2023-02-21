//
//  CharacterCell.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSpecies: UILabel!
    
    /// Set cell values by specified model
    /// - Parameter item: CharacterModel
    func setupValues(item: CharacterModel) {
        lblName.text = item.name
        lblSpecies.text = item.species.capitalized
        let species = CharacterSpecies(rawValue: item.species.lowercased())
        imgProfile.superview?.backgroundColor = getBackColor(species)
    }
    
    /// Get background color for collection cell
    private func getBackColor(_ species: CharacterSpecies?) -> UIColor {
        switch species {
        case .human:
            return .systemGray5
        case .humanoid:
            return .systemGray3
        case .alien:
            return .systemGreen
        case .poopybutthole:
            return .systemPink
        case .cronenberg:
            return .systemRed
        case .mythological:
            return .systemCyan
        case .animal:
            return .systemOrange
        case .robot:
            return .systemMint
        case .disease:
            return .systemPurple
        default:
            return .systemGray
        }
    }
}
