//
//  LocationDetailCell.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import UIKit

class LocationDetailCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCreated: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblSeason: UILabel!
    @IBOutlet weak var lblDimension: UILabel!
    
    /// Set cell values by specified model
    /// - Parameter item: Location Model
    func setupValues(item: LocationModel) {
        // apply labels
        lblName.text = item.name
        lblType.text = "Type: " + item.type
        lblSeason.text = "Dimension:"
        lblDimension.text = item.dimension
        
        // change date format
        lblCreated.text = item.created.convertDateFormat(to: "HH:mm, dd MMMM yyyy")
    }
    
    /// Set cell values by specified model
    /// - Parameter item: Episode Model
    func setupValues(item: EpisodeModel) {
        lblName.text = item.name
        
        // change date format
        lblCreated.text = item.created.convertDateFormat(to: "HH:mm, dd MMMM yyyy")
        lblType.text = "Air Date: " + item.airDate.convertDateFormat(from: "MMMM dd, yyyy", to: "dd MMMM yyyy")
        
        // split value to get separate season and episode values
        let episode = item.episode.replacingOccurrences(of: "[A-Z]", with: " ", options: .regularExpression)
        let split = episode.split(separator: " ")
        lblSeason.text = "Season: " + String(Int(split[0]) ?? 0)
        lblDimension.text = "Episode: " + String(Int(split[1]) ?? 0)
    }
    
}
