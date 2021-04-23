//
//  CardCollectionViewCell.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/29/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    static let identifier = "CardCollectionViewCell"
    
    let cache = NetworkManager.shared.cache
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .yellow
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let cardImage = CardDetailImageView(frame: .zero)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Card Name"
        label.backgroundColor = .green
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray
        contentView.clipsToBounds = true
        addSubviews(cardImage, nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cardImage.frame = CGRect(x: 5,
                                 y: 5,
                                 width: contentView.frame.size.width - 10,
                                 height: contentView.frame.size.height - 45)
        
        nameLabel.frame = CGRect(x: 5,
                                 y: contentView.frame.size.height - 35,
                                 width: contentView.frame.size.width - 10,
                                 height: 30)
        
    }
    
    public func configure(label: String) {
        nameLabel.text = label

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
    
    
    
}


