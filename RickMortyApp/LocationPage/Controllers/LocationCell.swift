//
//  LocationCell.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import UIKit

class LocationCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDimension: UILabel!
    
    /// Set cell values by specified model
    /// - Parameter item: LocationModel
    func setupValues(item: LocationModel) {
        lblName.text = item.name
        lblType.text = item.type
        lblDimension.text = item.dimension
    }
}
