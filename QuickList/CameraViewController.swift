//
//  CameraViewController.swift
//  QuickList
//
//  Created by Greg Alton on 10/26/18.
//  Copyright © 2018 Greg Alton. All rights reserved.
//

import UIKit
import CoreData

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    let moContext = PersistentService.context
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Image Item"
        self.picker.delegate = self
        self.picker.sourceType = .camera
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        present(self.picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let data = image.jpegData(compressionQuality: 1)! as NSData
        let entity = NSEntityDescription.entity(forEntityName: "ListItem", in: self.moContext)
        let listItem = NSManagedObject(entity: entity!, insertInto: self.moContext) as? ListItem
        listItem?.image = data
        PersistentService.saveContext()
        self.picker.dismiss(animated: true, completion: nil)
        self.tabBarController?.selectedIndex = 0
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.tabBarController?.selectedIndex = 0
        self.picker.dismiss(animated: true, completion: nil)
    }
    
}
