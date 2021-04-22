//
//  FlipController.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 4/21/21.
//

import UIKit

class FlipController: UIViewController {
    
    var firstView: UIView!
    var secondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //firstView = UIView(frame: )
        secondView = UIView(frame: UIScreen.main.bounds)
        
        firstView.backgroundColor = UIColor.red
        secondView.backgroundColor = UIColor.blue
        
        secondView.isHidden = true
        
        view.addSubview(firstView)
        view.addSubview(secondView)
        
        perform(#selector(flip), with: nil, afterDelay: 2)
        
        
    }
    
    
    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: firstView, duration: 1.0, options: transitionOptions, animations: {
            self.firstView.isHidden = true
        })
        
        UIView.transition(with: secondView, duration: 1.0, options: transitionOptions, animations: {
            self.secondView.isHidden = false
        })
    }
    
    
    
}
