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
    //    {
    //        didSet {
    //            getCardInfo(setCode: setNameCode, setNumber: setNumberCode)
    //        }
    //    }
    public var magicCard : MTGCard!{
        didSet {
            self.cardDetailView.cardImage.downloadImage(fromURL: imgURL)
            self.cardDetailView.nameLabel.text = magicCard.name
        }
    }
    
    var imgURL : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .systemOrange
        view.addSubview(cardDetailView)
        
        getCardInfo(setCode: setNameCode, setNumber: setNumberCode)
        
        
        
        // "https://c1.scryfall.com/file/scryfall-cards/art_crop/front/8/1/81e0d739-990f-4ba5-b456-165c033014cf.jpg?1599707370"
        
        cardDetailView.oracleTextView.backgroundColor = .blue
    }
    
    func getCardInfo(setCode: String, setNumber: String) {
        NetworkManager.shared.getCards(for: setCode, setNumber: setNumber) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let mtgCard):
                
                print("CardDetailVC")
                print(mtgCard.oracle_text)
                print(mtgCard.image_uris.art_crop)
                //self.imgURL = mtgCard.image_uris.art_crop
                //self.cardDetailView.nameLabel.text = mtgCard.name
                self.magicCard = mtgCard
                
                
            case .failure(let error):
                
                print("Result failed: " + error.localizedDescription)
            }
            
        }
        
    }
    
    
    
    
    
    
}
