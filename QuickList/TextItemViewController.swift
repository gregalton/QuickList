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
        textItemField.adjustsFontSizeToFitWidth = true
        textItemField.returnKeyType = .done
        return textItemField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Text Item"
        self.textItemField.delegate = self
        
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
        textItemField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150).isActive = true
        textItemField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        textItemField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        textItemField.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        
    }
    
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
