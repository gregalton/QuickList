//
//  TextCollectionViewCell.swift
//  QuickList
//
//  Created by Greg Alton on 11/5/18.
//  Copyright © 2018 Greg Alton. All rights reserved.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    
    var deleteTapAction : (()->())?
    
    lazy var itemTextLabel: UILabel = {
        let itemTextLabel = UILabel()
        itemTextLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTextLabel.backgroundColor = UIColor.black
        itemTextLabel.tintColor = UIColor.white
        itemTextLabel.textColor = UIColor.white
        itemTextLabel.font = UIFont(name: "Helvetica", size: 30)
        itemTextLabel.textAlignment = .center
        itemTextLabel.adjustsFontSizeToFitWidth = true
        return itemTextLabel
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = 25
        blurView.layer.masksToBounds = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setTitle("X", for: .normal)
        deleteButton.setTitleColor(UIColor.black, for: .normal)
        deleteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    @objc func deleteButtonTapped() {
        // callback to controller
        deleteTapAction?()
    }
    
    func setupViews() {
        self.addSubview(itemTextLabel)
        self.itemTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.itemTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.itemTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.itemTextLabel.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        self.addSubview(blurView)
        blurView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        blurView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        blurView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(deleteButton)
        deleteButton.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 10).isActive = true
        deleteButton.leftAnchor.constraint(equalTo: blurView.leftAnchor, constant: 10).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
    }
}
