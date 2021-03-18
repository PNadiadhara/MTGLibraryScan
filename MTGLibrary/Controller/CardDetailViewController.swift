//
//  CardDetailViewController.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/17/21.
//

import UIKit

class CardDetailViewController: UIViewController {
    
    let cardDetailView = CardDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        view.addSubview(cardDetailView)
        
        cardDetailView.nameLabel.text = "Test Text"
    }
    

   

}
