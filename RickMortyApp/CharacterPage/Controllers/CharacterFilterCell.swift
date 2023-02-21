//
//  CharacterFilterCell.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 19/02/23.
//

import UIKit

class CharacterFilterCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellWidth.isActive = true
    }
    
    /// Set cell values by name
    /// - Parameter name: `.rawvalue` of enum
    /// - Parameter isSelected: set cell state when being pressed
    func setupValues(name: String, isSelected: Bool) {
        lblName.text = name.isEmpty ? "All" : name.capitalized
        
        // set colors when cell is selected
        lblName.textColor = isSelected ? .systemBlue : .systemGray
        lblName.superview?.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.systemGray.cgColor
        
        // set cell's width based on text's width
        cellWidth.constant = lblName.intrinsicContentSize.width + 32
    }
}
