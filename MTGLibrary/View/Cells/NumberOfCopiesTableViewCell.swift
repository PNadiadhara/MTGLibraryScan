//
//  NumberOfCopiesTableViewCell.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 8/11/21.
//

import UIKit

class NumberOfCopiesTableViewCell: UITableViewCell {

    static let identifier = "NumberOfCopiesTableViewCell"
    var numberOfCopies : UILabel!
    var numberOfFoilCopies: UILabel!
    
    public func configure(with normal: String, foils: String) {
        numberOfCopies.text = normal
        numberOfFoilCopies.text = foils
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
