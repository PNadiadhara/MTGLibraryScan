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
        addSubviews(nameLabel,cardImage)
        
        nameLabel           .translatesAutoresizingMaskIntoConstraints = false
        cardImage           .translatesAutoresizingMaskIntoConstraints = false
        oracleTextView      .translatesAutoresizingMaskIntoConstraints = false
        numberOfCopies      .translatesAutoresizingMaskIntoConstraints = false
        numberOfFoilCopies  .translatesAutoresizingMaskIntoConstraints = false
        saveButton          .translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            cardImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            cardImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cardImage.widthAnchor.constraint(equalToConstant: 540),
            cardImage.heightAnchor.constraint(equalToConstant: 690)

        ])
        
    }
    
    
   
    
    
    
    

}
