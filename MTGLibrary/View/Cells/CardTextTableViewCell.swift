//
//  CardTextTableViewCell.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 8/24/21.
//

import UIKit

class CardTextTableViewCell: UITableViewCell {
    
    static let identifier = "CardTextTableViewCell"
    
    var cardText : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    
    private func setConstraints() {
        
        contentView.addSubview(cardText)
        let marginGuide = contentView.layoutMarginsGuide
        

        cardText.translatesAutoresizingMaskIntoConstraints = false
        
        //https://medium.com/@satindersingh71/self-sizing-table-view-cells-programmatically-b0e82a20f264
        
        cardText.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        cardText.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        cardText.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        cardText.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        cardText.numberOfLines = 0
        
        
        
    }

    public func configure(with oracleText: String){
        setConstraints()
        cardText.text = oracleText
    }
    
    
}
