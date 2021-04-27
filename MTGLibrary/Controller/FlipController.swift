//
//  FlipController.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 4/21/21.
//

import UIKit

class FlipController: UIViewController {
    
    let mainView = CardCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        self.view.backgroundColor = .green
        mainView.collectionView.backgroundColor = .blue
        
        
    }
    
    
    
    
}
