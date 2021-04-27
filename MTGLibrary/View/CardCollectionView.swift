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
        super.init(frame: frame)
        setUpConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpConstraints() {
        
    }
}
