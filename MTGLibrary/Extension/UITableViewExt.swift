//
//  UITableViewExt.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 4/23/21.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
