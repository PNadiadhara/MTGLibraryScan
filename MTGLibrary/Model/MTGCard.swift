//
//  MTGCard.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/16/21.
//

import Foundation

struct MTGCard: Codable, Equatable {
    // Set name and number are unique enough to check for copies that already exist in user's colleciton. Currently reprints in different sets will count as unique copies
    static func == (lhs: MTGCard, rhs: MTGCard) -> Bool {
        return lhs.set == rhs.set && lhs.set_name == rhs.set_name
    }
    
    let object: String
    let name: String
    let scryfall_uri: String
    let image_uris: ImageURIs
    let mana_cost: String
    let cmc: Double
    let type_line: String
    let oracle_text: String
    //Planeswalkers only
    let loyalty: String?
    // Creatures only
    let power: String?
    let toughness: String?
    let keywords: [String]?
    
    let colors: [String]
    let color_identity: [String]
    let set: String
    let set_name: String
    let rarity: String?
    let collector_number: String
    let artist: String
    let prices : Price
      
}

struct ImageURIs: Codable {
    let small: String
    let normal: String
    let large: String
    let png: String
    let art_crop: String
    let border_crop: String
}

struct Price: Codable {
    let usd: String
    let usd_foil: String
}


// Creature API Result
// https://api.scryfall.com/cards/thb/226
// Planeswalker
// https://api.scryfall.com/cards/iko/175
//

