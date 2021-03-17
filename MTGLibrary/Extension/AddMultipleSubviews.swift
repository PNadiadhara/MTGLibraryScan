//
//  AddMultipleSubviews.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/17/21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
