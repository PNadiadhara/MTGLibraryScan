//
//  FlipController.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 4/21/21.
//

import UIKit

class FlipController: UIViewController {
    
//    let mainView = CardCollectionView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(mainView)
//        self.view.backgroundColor = .green
//        mainView.collectionView.backgroundColor = .blue
//
//
//    }
    
    
    var username: String!
    var savedMTGCards = [MTGCard]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    var filterdMTGCards = [MTGCard]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    
    private var collectionView: UICollectionView?
    private var searchController = UISearchController(searchResultsController: nil)
    private let searchbar = UISearchBar()
    var image: UIImage?
    var setCode: String = ""
    var setNumber: String = ""
    
    
    
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func configureCollectionView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped() {
    print("add button tapped")
    }
    
    
}

extension FlipController: UICollectionViewDelegate {
    
}

extension FlipController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
