//
//  CharacterDetailCell.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import UIKit

class CharacterDetailCell: UITableViewCell {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var imgGender: UIImageView!
    @IBOutlet weak var lblSpecies: UILabel!
    @IBOutlet weak var lblCreated: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    /// Set cell values by specified model
    /// - Parameter item: CharacterModel
    func setupValues(item: CharacterModel) {
        // apply status label and icon
        lblStatus.text = "Status: " + item.status
        let status = CharacterStatus(rawValue: item.status.lowercased()) ?? .unknown
        imgStatus.image = UIImage(named: status.icon)
        
        // apply gender label and icon
        lblGender.text = "Gender: " + item.gender
        let gender = CharacterGender(rawValue: item.gender.lowercased()) ?? .unknown
        imgGender.image = UIImage(named: gender.icon)
        
        // apply species label
        lblSpecies.text = "Species: " + item.species
        
        // apply other labels
        lblName.text = item.name
        lblCreated.text = item.created.convertDateFormat(to: "HH:mm, MMMM yyyy")
        lblOrigin.text = item.origin.name
        lblLocation.text = item.location.name
    }
    
}
