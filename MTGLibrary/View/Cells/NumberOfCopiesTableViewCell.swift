//
//  NumberOfCopiesTableViewCell.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 8/11/21.
//

import UIKit

class NumberOfCopiesTableViewCell: UITableViewCell {

    static let identifier = "NumberOfCopiesTableViewCell"
    
    var mtgCard: MTGCard? {
        didSet {
            numberOfCopies.text = "Normal Copies"
            
        }
    }
    
    //This label will display string either #ofNormal or #ofFoils
    var numberOfCopies : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let decreaseButton : UIButton = {
     let btn = UIButton(type: .custom)
     btn.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
     btn.imageView?.contentMode = .scaleAspectFill
     return btn
     }()
     
     private let increaseButton : UIButton = {
     let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
     btn.imageView?.contentMode = .scaleAspectFill
     return btn
     }()
    
     var cardQuantity : UILabel = {
     let label = UILabel()
     label.font = UIFont.boldSystemFont(ofSize: 16)
     label.textAlignment = .left
     //label.text = "1"
     label.textColor = .white
     return label
     
     }()
    
    
    public func configure(with quantity: String) {
        // use this for both normal and foil copies
        setConstraints()
        numberOfCopies.text = "quantity"
        
    }
    
    
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setConstraints() {
        addSubviews(
            numberOfCopies,
            decreaseButton,
            increaseButton,
            cardQuantity
        )
        
        numberOfCopies.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
        let stackView = UIStackView(arrangedSubviews: [decreaseButton,cardQuantity,increaseButton])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: numberOfCopies.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 15, paddingRight: 10, width: 0, height: 70, enableInsets: false)
        
        }
        
        
    

}
