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
    var oracleText = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(cardDetailView)
        
        cardDetailView.tableView.register(NumberOfCopiesTableViewCell.self, forCellReuseIdentifier: NumberOfCopiesTableViewCell.identifier)
        cardDetailView.tableView.register(CardTextTableViewCell.self, forCellReuseIdentifier: CardTextTableViewCell.identifier)

        cardDetailView.tableView.delegate = self
        cardDetailView.tableView.dataSource = self
        
        
        
        
        getCardInfo(setCode: setNameCode, setNumber: setNumberCode)
        
        configureSaveButton()
        configureNavBar()
        
        
        // "https://c1.scryfall.com/file/scryfall-cards/art_crop/front/8/1/81e0d739-990f-4ba5-b456-165c033014cf.jpg?1599707370"
        
        
    }
    
    func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteCard))
    }
    
    @objc func deleteCard() {
        if collectedCards.contains(magicCard) {
            let index = collectedCards.firstIndex {
                $0 == magicCard
            }
            showDestructionAlert(title: nil, message: "Delete Card?", style: .alert, handler: {_ in
                MTGCardDataManager.deleteMTGCard(atIndex: index!)
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    func updateCard() {
        if collectedCards.contains(magicCard) {
            let index = collectedCards.firstIndex {
                $0 == magicCard
            }
            showDestructionAlert(title: nil, message: "Update information?", style: .alert, handler: {_ in
                MTGCardDataManager.deleteMTGCard(atIndex: index!)
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    func getCardInfo(setCode: String, setNumber: String) {
        NetworkManager.shared.getCards(for: setCode, setNumber: setNumber) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let mtgCard):
                
                self.magicCard = mtgCard
                DispatchQueue.main.async {
                    self.cardDetailView.cardImage.downloadImage(fromURL: self.magicCard.image_uris.art_crop)
                    
                    self.title = self.magicCard.name
                    self.oracleText = self.magicCard.oracle_text
                    print(self.oracleText)
                    self.cardDetailView.tableView.reloadData()
                    
                    
                    //adjust this to fix update text bug
                    if self.collectedCards.contains(self.magicCard) {
                        self.cardDetailView.saveButton.set(backgroundColor: .systemTeal, title: "Update")
                        
                    }
                }
                
                
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    self.showAlert(title: "Error", message: error.rawValue + " SetNumber: \(setNumber), SetCode:\(setCode)", style: .alert, handler: {_ in
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    print("Result failed: " + error.localizedDescription)
                }
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
                updateCard()
                MTGCardDataManager.addMTGCard(mtgCard: magicCard)
                print("Card Collection Updated")
            } else {
                MTGCardDataManager.addMTGCard(mtgCard: newMTGCard)
                showAlert(title: nil, message: "Card Saved", actionTitle: "OK")
                
            }
            showAlert(title: nil, message: "Saved", actionTitle: "OK")
            
            print(DataPersistenceManager.getDocumentsDirectory())
            
            
        }
    }
    
    
}

//MARK: - TableView
extension CardDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: CardTextTableViewCell.identifier, for: indexPath) as! CardTextTableViewCell
//
//            cell.configure(with: magicCard.oracle_text)
//            return cell
//        }
        if indexPath.row == 1 || indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NumberOfCopiesTableViewCell.identifier, for: indexPath) as! NumberOfCopiesTableViewCell
            // row height to have cardText fit neatly
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 600
            cell.numberOfCopies.textColor = .white
            cell.configure(with: "Normal", quantity: "Num")
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTextTableViewCell.identifier, for: indexPath) as! CardTextTableViewCell
        
            cell.configure(with: self.oracleText)
        
        
        return cell
        
       
    }
    
    
}
