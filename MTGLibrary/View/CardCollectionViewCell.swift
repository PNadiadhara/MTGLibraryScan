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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Card Name"
        label.backgroundColor = .green
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray
        contentView.clipsToBounds = true
        addSubviews(imageView, nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.frame = CGRect(x: 5,
                                 y: contentView.frame.size.height - 50,
                                 width: contentView.frame.size.width - 10,
                                 height: 50)
        imageView.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.frame.size.width - 10,
                                 height: contentView.frame.size.height - 50)
    }
    
    public func configure(label: String) {
        nameLabel.text = label
        // Update to include image
        //imageView.image = NetworkManager.
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
    
    
    
}


