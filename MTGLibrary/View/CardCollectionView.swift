//
//  CardCollectionView.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 4/26/21.
//

import UIKit

class CardCollectionView: UIView {
    
    public lazy var search: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.layer.cornerRadius = 10
        searchbar.placeholder = "Search Card Collection..."
        return searchbar
    }()
    
    public lazy var collectionView : UICollectionView = {
        let cv = UICollectionView()
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        // CVcell size
        layout.itemSize = CGSize(width: (frame.size.width/3) - 4,
                                 height: (frame.size.width/3) - 4)
        
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        search.backgroundColor = .black
        search.resignFirstResponder()
        setUpConstraints()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpConstraints() {
        
        
        
        addSubviews(search, collectionView)
        
        search          .translatesAutoresizingMaskIntoConstraints = false
        collectionView  .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([search.topAnchor.constraint(equalTo:           safeAreaLayoutGuide.topAnchor),
                                     search.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     search.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     collectionView.topAnchor.constraint(equalTo: search.bottomAnchor, constant: 5),
                                     collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                                     collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
                                     collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
        
        
    }
}
