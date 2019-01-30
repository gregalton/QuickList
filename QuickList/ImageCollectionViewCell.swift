//
//  ImageCollectionViewCell.swift
//  QuickList
//
//  Created by Greg Alton on 11/7/18.
//  Copyright © 2018 Greg Alton. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    var deleteTapAction : (()->())?
    
    lazy var itemImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        self.addSubview(self.itemImageView)
        self.itemImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        self.itemImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.itemImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.itemImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        //self.itemImageView.heightAnchor.constraint(equalToConstant: 200.0)
        
        self.addSubview(blurView)
        blurView.topAnchor.constraint(equalTo: itemImageView.topAnchor, constant: 40).isActive = true
        blurView.leftAnchor.constraint(equalTo: itemImageView.leftAnchor, constant: 20).isActive = true
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
