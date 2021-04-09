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
    var imgURL : String = ""
    public var magicCard : MTGCard!
    var collectedCards = MTGCardDataManager.getMTGCards()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        view.addSubview(cardDetailView)
        
        cardDetailView.oracleTextView.clipsToBounds = true
        
        getCardInfo(setCode: setNameCode, setNumber: setNumberCode)
        
        configureSaveButton()
        
        
        
        // "https://c1.scryfall.com/file/scryfall-cards/art_crop/front/8/1/81e0d739-990f-4ba5-b456-165c033014cf.jpg?1599707370"
        
        
    }
    
    func getCardInfo(setCode: String, setNumber: String) {
        NetworkManager.shared.getCards(for: setCode, setNumber: setNumber) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let mtgCard):
                
                print("CardDetailVC")
                print(mtgCard.oracle_text)
                print(mtgCard.image_uris.art_crop)
                
                
                
                self.magicCard = mtgCard
                DispatchQueue.main.async {
                    self.cardDetailView.nameLabel.text = self.magicCard.name
                    self.cardDetailView.cardImage.downloadImage(fromURL: self.magicCard.image_uris.art_crop)
                    
                    self.cardDetailView.oracleTextView.text = self.magicCard.oracle_text
                }
                
                
            case .failure(let error):
                
                print("Result failed: " + error.localizedDescription)
            }
        }
        
        func checkForCopies(magicCard: MTGCard) -> Bool {
            if collectedCards.contains(magicCard) {
                return true
            }
            return false
        }
        
    }
    
    func configureSaveButton() {
        cardDetailView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    @objc private func saveButtonPressed() {
        if let newMTGCard = magicCard {
            if collectedCards.contains(magicCard) {
                print("Card Collection Updated")
            } else {
                MTGCardDataManager.addMTGCard(mtgCard: newMTGCard)
                showAlert(title: nil, message: "Card Saved", actionTitle: "OK")
                print("Card Added to colleciton")
            }
            MTGCardDataManager.addMTGCard(mtgCard: newMTGCard)
            showAlert(title: nil, message: "Card Saved", actionTitle: "OK")
            
            print(DataPersistenceManager.getDocumentsDirectory())
            print("save button tapped")
            
        }
    }
    
    
}
