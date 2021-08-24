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
        return label
    }()

    private func setConstraints() {
        contentView.addSubviews(cardText)
        
        cardText.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: contentView.frame.size.width, height: 0, enableInsets: false)
    }

    public func configure(with oracleText: String){
        setConstraints()
        cardText.text = oracleText
    }
    
    
}
