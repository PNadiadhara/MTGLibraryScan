//
//  MTGCardDataManager.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 4/7/21.
//

import Foundation

final class MTGCardDataManager {
    private init() {}
    
    private static let mtgCardFileName = "MTGCard.plist"
    private static var mtgCards = [MTGCard]()
    
    static func saveMTGCard() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: mtgCardFileName)
        do {
            let data = try PropertyListEncoder().encode(mtgCards)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func getMTGCards() -> [MTGCard]{
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: mtgCardFileName).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path){
                do {
                    mtgCards = try PropertyListDecoder().decode([MTGCard].self, from: data)
                } catch {
                    print("Property List Decoding Error: \(error)")
                }
            } else {
                print("MTG Card data is nil")
            }
        } else {
            print("\(mtgCardFileName) does not exist")
        }
        return mtgCards
    }
    
    static func addMTGCard(mtgCard: MTGCard){
        mtgCards.append(mtgCard)
        saveMTGCard()
    }
    
    static func deleteMTGCard(atIndex: Int){
        mtgCards.remove(at: atIndex)
        saveMTGCard()
    }
    
    
    
}
