//
//  EpisodeCell.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import UIKit

class EpisodeCell: UITableViewCell {
    @IBOutlet weak var lblPilot: UILabel!
    @IBOutlet weak var lblSeason: UILabel!
    @IBOutlet weak var lblEpisode: UILabel!
    @IBOutlet weak var lblAirDate: UILabel!
    
    /// Set cell values by specified model
    /// - Parameter item: EpisodeModel
    func setupValues(item: EpisodeModel) {
        // Split string to get season and episode for labels
        let episode = item.episode.replacingOccurrences(of: "[A-Z]", with: " ", options: .regularExpression)
        let split = episode.split(separator: " ")
        lblSeason.text = "Season: " + String(Int(split[0]) ?? 0)
        lblEpisode.text = "Episode: " + String(Int(split[1]) ?? 0)
        
        // Apply other labels
        lblPilot.text = item.name
        lblAirDate.text = item.airDate.convertDateFormat(from: "MMMM dd, yyyy", to: "dd MMMM yyyy")
    }
}
