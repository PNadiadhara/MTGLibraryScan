//
//  CardDetailView.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/15/21.
//

import UIKit

class CardDetailView: UIView {

    let cardImage = CardDetailImageView(frame: .zero)
    // using table view to place all api data instead of original plan for specific labels
    let cardDetailTableView: UITableView = {
        let table = UITableView()
    
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 600
    
        return table
    }()
    let saveButton = MTGButton(backgroundColor: .systemTeal, title: "Save")
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        //nameLabel,
        addSubviews(
                    cardImage,
                    cardDetailTableView,
                    saveButton
        )
        
        cardImage                     .translatesAutoresizingMaskIntoConstraints = false
        cardDetailTableView           .translatesAutoresizingMaskIntoConstraints = false
        saveButton                    .translatesAutoresizingMaskIntoConstraints = false
        
        cardDetailTableView.layer.cornerRadius = 10
        
        
        NSLayoutConstraint.activate([
            
            cardImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            cardImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            cardImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -11),
            cardImage.heightAnchor.constraint(equalToConstant: 275),
            
            
            cardDetailTableView.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 4),
            cardDetailTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            cardDetailTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -11),
            
            
            
            saveButton.topAnchor.constraint(equalTo: cardDetailTableView.bottomAnchor, constant: 4),
            saveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -11),
            saveButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            saveButton.heightAnchor.constraint(equalToConstant: 50),

        ])
    }
}
