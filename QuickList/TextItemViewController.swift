//
//  TextItemViewController.swift
//  QuickList
//
//  Created by Greg Alton on 10/18/18.
//  Copyright © 2018 Greg Alton. All rights reserved.
//

import UIKit
import CoreData

class TextItemViewController: UIViewController, UITextFieldDelegate {
    
    let moContext = PersistentService.context
    private var tap: UITapGestureRecognizer?
    
    private lazy var textItemField: UITextField = {
        let textItemField = UITextField()
        textItemField.translatesAutoresizingMaskIntoConstraints = false
        textItemField.placeholder = "Enter item text"
        textItemField.textColor = UIColor.white
        textItemField.font = .systemFont(ofSize: 30)
        textItemField.borderStyle = .roundedRect
        textItemField.backgroundColor = UIColor.black
        textItemField.textAlignment = .center
        textItemField.returnKeyType = .done
        return textItemField
    }()
    
    /* Lost to simplification
    private lazy var addItemButton: UIButton = {
        let addItemButton = UIButton()
        addItemButton.translatesAutoresizingMaskIntoConstraints = false
        addItemButton.tintColor = UIColor.white
        addItemButton.setTitle("Add", for: .normal)
        addItemButton.titleLabel!.font = UIFont.systemFont(ofSize: 30)
        return addItemButton
    }()
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Text Item"
        self.textItemField.delegate = self
        
        // Dismiss keyboard when tapping in view
        /* Lost to simplification, but this didn't work and I need to know why
        self.tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap!)
        self.view.isUserInteractionEnabled = true
        */
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(self.textItemField.text != "") {
            print("previous state displayed")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.view.removeGestureRecognizer(tap!)
    }
    
    @objc func handleTap() {
        self.textItemField.resignFirstResponder()
    }
    
    
    func setupViews() {

        self.view.addSubview(textItemField)
        textItemField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        textItemField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        textItemField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        textItemField.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        
        /* Lost to simplification
        self.view.addSubview(addItemButton)
        addItemButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addItemButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70).isActive = true
        addItemButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        */
    }
    
    /* Lost to simplification
    @objc func addButtonTapped() {
        print("add button tapped")
    }
    */
    
    
    
    /*
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
    }
    */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let entity = NSEntityDescription.entity(forEntityName: "ListItem", in: self.moContext)
        let listItem = NSManagedObject(entity: entity!, insertInto: self.moContext) as? ListItem
        listItem?.text = textField.text
        PersistentService.saveContext()
        textField.text = ""
        self.tabBarController?.selectedIndex = 0
        return true
    }
    
}
