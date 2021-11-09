//
//  OCRScanView.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/10/21.
//

import UIKit

// Note: This view is no longer used in favor of collection view that displays collected cards
// This View was used to check Vision API response on the app

class OCRScanView: UIView {

    public lazy var nameLabel: UITextView = {
       let tv = UITextView()
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()
    
    public lazy var setLabel: UITextView = {
       let tv = UITextView()
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()
    
    public lazy var setNumberLabel: UITextView = {
       let tv = UITextView()
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()
    
    public lazy var choosePhotoButton: UIButton = {
       let button = UIButton()
        button.setTitle("Choose Photo", for: .normal)
        button.backgroundColor = .black
        
        return button
    }()
    
    public lazy var takePhotoButton: UIButton = {
       let button = UIButton()
        button.setTitle("Take Photo", for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(nameLabel)
        addSubview(setLabel)
        addSubview(setNumberLabel)
        addSubview(choosePhotoButton)
        addSubview(takePhotoButton)
        
        
        nameLabel           .translatesAutoresizingMaskIntoConstraints = false
        setLabel            .translatesAutoresizingMaskIntoConstraints = false
        setNumberLabel      .translatesAutoresizingMaskIntoConstraints = false
        choosePhotoButton   .translatesAutoresizingMaskIntoConstraints = false
        takePhotoButton     .translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -11).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.20).isActive = true
        
        setLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 11).isActive = true
        setLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        setLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -11).isActive = true
        setLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.20).isActive = true

        setNumberLabel.topAnchor.constraint(equalTo: setLabel.bottomAnchor, constant: 11).isActive = true
        setNumberLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        setNumberLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -11).isActive = true
        setNumberLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.20).isActive = true

        choosePhotoButton.topAnchor.constraint(equalTo: setNumberLabel.bottomAnchor, constant: 11).isActive = true
        choosePhotoButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        choosePhotoButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -11).isActive = true
        choosePhotoButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.20).isActive = true

        takePhotoButton.topAnchor.constraint(equalTo: choosePhotoButton.bottomAnchor, constant: 11).isActive = true
        takePhotoButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        takePhotoButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -11).isActive = true
        takePhotoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -11).isActive = true
      }
}
