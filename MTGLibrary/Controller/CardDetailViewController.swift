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
        cardDetailView.cardImage.downloadImage(fromURL: "https://c1.scryfall.com/file/scryfall-cards/art_crop/front/8/1/81e0d739-990f-4ba5-b456-165c033014cf.jpg?1599707370")
        
        cardDetailView.oracleTextView.backgroundColor = .blue
    }
    

   

}
