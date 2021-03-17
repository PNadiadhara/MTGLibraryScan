//
//  CardDetailView.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/15/21.
//

import UIKit

class CardDetailView: UIView {

    let nameLabel = TitleLabel(textAlignment: .center, fontSize: 14)
    let cardImage = CardDetailImageView(frame: .zero)
    let oracleTextView = OracleTextView()
    let numberOfCopies = MTGTextField()
    let numberOfFoilCopies = MTGTextField()
    let saveButton = MTGButton(backgroundColor: .systemTeal, title: "Save")
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        nameLabel           .translatesAutoresizingMaskIntoConstraints = false
        cardImage           .translatesAutoresizingMaskIntoConstraints = false
        oracleTextView      .translatesAutoresizingMaskIntoConstraints = false
        numberOfCopies      .translatesAutoresizingMaskIntoConstraints = false
        numberOfFoilCopies  .translatesAutoresizingMaskIntoConstraints = false
        saveButton          .translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }
    
    
    
    
    
    
    

}
