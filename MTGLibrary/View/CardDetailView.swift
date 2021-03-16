//
//  CardDetailView.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/15/21.
//

import UIKit

class CardDetailView: UIView {

    var nameLabel: UITextView = {
       let tv = UITextView()
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()
    
    var cardImage: UIImageView = {
       let iv = UIImageView()
        
        return iv
    }()
    
    

}
