//
//  CardDetailView.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/15/21.
//

import UIKit

class CardDetailView: UIView {

    let nameLabel = TitleLabel(textAlignment: .center, fontSize: 30)
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
        addSubviews(nameLabel,
                    cardImage,
                    oracleTextView,
                    numberOfCopies,
                    numberOfFoilCopies,
                    saveButton
        )
        
        nameLabel           .translatesAutoresizingMaskIntoConstraints = false
        cardImage           .translatesAutoresizingMaskIntoConstraints = false
        oracleTextView      .translatesAutoresizingMaskIntoConstraints = false
        numberOfCopies      .translatesAutoresizingMaskIntoConstraints = false
        numberOfFoilCopies  .translatesAutoresizingMaskIntoConstraints = false
        saveButton          .translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            cardImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            cardImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            cardImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -11),
            cardImage.heightAnchor.constraint(equalToConstant: 275),
            
            oracleTextView.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 4),
            oracleTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            oracleTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -11),
            oracleTextView.heightAnchor.constraint(equalToConstant: 200),
            
            numberOfCopies.topAnchor.constraint(equalTo: oracleTextView.bottomAnchor, constant: 4),
            numberOfCopies.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            numberOfCopies.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33),
            
            numberOfFoilCopies.topAnchor.constraint(equalTo: oracleTextView.bottomAnchor, constant: 4),
            numberOfFoilCopies.leadingAnchor.constraint(equalTo: numberOfCopies.trailingAnchor, constant: 4),
            numberOfFoilCopies.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -11),
            numberOfFoilCopies.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33),
            
            saveButton.topAnchor.constraint(equalTo: numberOfCopies.bottomAnchor, constant: 4),
            saveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -11),
            saveButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11)

        ])
        
    }


}
