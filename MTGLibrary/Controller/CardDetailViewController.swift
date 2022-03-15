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
        
        cardDetailView.cardDetailTableView.rowHeight = UITableView.automaticDimension
        cardDetailView.cardDetailTableView.estimatedRowHeight = 600
        cardDetailView.cardDetailTableView.allowsSelection = false
        
        cardDetailView.cardDetailTableView.register(NumberOfCopiesTableViewCell.self, forCellReuseIdentifier: NumberOfCopiesTableViewCell.identifier)
        cardDetailView.cardDetailTableView.register(CardTextTableViewCell.self, forCellReuseIdentifier: CardTextTableViewCell.identifier)
        
        cardDetailView.cardDetailTableView.delegate = self
        cardDetailView.cardDetailTableView.dataSource = self
        
        getCardInfo(setCode: setNameCode, setNumber: setNumberCode)
        
        configureSaveButton()
        configureNavBar()
        
        
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
                MTGCardDataManager.saveMTGCard()
                MTGCardDataManager.deleteMTGCard(atIndex: index!)
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    //MARK: - Network Call
    
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
                    //print(self.oracleText)
                    self.cardDetailView.cardDetailTableView.reloadData()
                    
                    //self.checkForCopies(magicCard: self.magicCard)
                    
                    //adjust this to fix update text bug
                    if self.collectedCards.contains(self.magicCard) {
                        self.cardDetailView.saveButton.set(backgroundColor: .systemTeal, title: "Update")
                    } else {
                        self.cardDetailView.saveButton.set(backgroundColor: .systemGreen, title: "Save")
                    }
                    
                }
                
                
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    self.showAlert(title: "Error", message: error.rawValue + " SetNumber: \(setNumber), SetCode:\(setCode)", style: .alert, handler: {_ in
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    print("Result failed: " + error.localizedDescription)
                    self.cardDetailView.cardDetailTableView.rowHeight = UITableView.automaticDimension
                }
            }
        }
        
        
    }
    
//    func checkForCopies(magicCard: MTGCard) -> Bool {
//        if collectedCards.contains(magicCard) {
//            print("Card found in collection")
//            return true
//        }
//        print("Card not found in collection")
//        return false
//    }
    
    func configureSaveButton() {
        
        cardDetailView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    @objc private func saveButtonPressed() {
        // cancel saves new copy while saving overwrites
        if let newMTGCard = magicCard {
            if collectedCards.contains(magicCard) {
                updateCard()
                MTGCardDataManager.addMTGCard(mtgCard: magicCard)
                //print("Card Collection Updated")
            } else {
                MTGCardDataManager.addMTGCard(mtgCard: newMTGCard)
                showAlert(title: nil, message: "Card Saved", actionTitle: "OK")
                
            }
            showAlert(title: nil, message: "Saved", actionTitle: "OK")
            
            //print(DataPersistenceManager.getDocumentsDirectory())
        }
    }
}

//MARK: - TableView
extension CardDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 || indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NumberOfCopiesTableViewCell.identifier, for: indexPath) as! NumberOfCopiesTableViewCell
            
            cell.numberOfCopies.textColor = .white
            cell.configure(with: "Normal", quantity: "1")
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTextTableViewCell.identifier, for: indexPath) as! CardTextTableViewCell
        
        
        cell.configure(with: self.oracleText)
        cell.backgroundColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0) /* #3d3d3d */
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
