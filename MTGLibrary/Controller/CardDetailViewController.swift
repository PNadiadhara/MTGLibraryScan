//
//  CardDetailViewController.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/17/21.
//

import UIKit

class CardDetailViewController: UIViewController {
   
    
    let cardDetailView = CardDetailView()

    public var setNameCode: String!
    public var setNumberCode: String!
    public var magicCard : MTGCard! {
        didSet {
            self.cardDetailView.cardImage.downloadImage(fromURL: magicCard.image_uris.art_crop)
            
        }
    }
    
    var imgURL : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        DispatchQueue.main.async {
            self.getCardInfo(setCode: self.magicCard.set, setNumber: self.magicCard.collector_number)
            
        }
        
        
        view.backgroundColor = .systemOrange
        view.addSubview(cardDetailView)
        
        
        
        // "https://c1.scryfall.com/file/scryfall-cards/art_crop/front/8/1/81e0d739-990f-4ba5-b456-165c033014cf.jpg?1599707370"
        
        cardDetailView.oracleTextView.backgroundColor = .blue
    }
    
    func getCardInfo(setCode: String, setNumber: String) {
        NetworkManager.shared.getCards(for: setCode, setNumber: setNumber) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let mtgCard):
                self.magicCard = mtgCard
                print(mtgCard.oracle_text)
                print(mtgCard.image_uris.art_crop)
                self.imgURL = self.magicCard.image_uris.art_crop
                self.cardDetailView.nameLabel.text = self.magicCard.name
            
            case .failure(let error):
                
                print("Result failed: " + error.localizedDescription)
            }
            
        }
    }
    
    
    

   

}
