//
//  OracleTextField.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/17/21.
//

import UIKit

class OracleTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // Customization
        autocorrectionType = .no
        backgroundColor = .secondarySystemBackground
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        layer.cornerRadius = 20
        textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        //Shadow
        layer.shadowColor = UIColor.gray.cgColor;
        layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 20
        layer.masksToBounds = false
    }
    
    

}
