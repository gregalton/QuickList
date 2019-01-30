//
//  ListCollectionViewController.swift
//  QuickList
//
//  Created by Greg Alton on 10/17/18.
//  Copyright © 2018 Greg Alton. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let imageCell = "imageCell"
    let textCell = "textCell"
    let moContext = PersistentService.context
    var listItems = [ListItem]()
    
    public init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Quick List"
        
        // comment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        collectionView.isPagingEnabled = true
        
        // Register cell classes
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: self.imageCell)
        collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: self.textCell)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getListItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.edgesForExtendedLayout = []
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
        }
    }
    
    func getListItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ListItem")
        
        do {
            listItems = try moContext.fetch(request) as! [ListItem]
        } catch {
            fatalError("Failed to fetch list items: \(error)")
        }
    
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let listItem = self.listItems[indexPath.item]
        
        if(listItem.image != nil) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCell, for: indexPath) as! ImageCollectionViewCell
            cell.itemImageView.image = UIImage(data: listItem.image! as Data)
            cell.deleteTapAction = {
                () in
                print("Deleting Item")
                let itemIndex = self.collectionView?.indexPath(for: cell)!
                self.listItems.remove(at: itemIndex!.item)
                self.collectionView?.deleteItems(at: [itemIndex!])
                self.moContext.delete(listItem)
                PersistentService.saveContext()
            }
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: textCell, for: indexPath) as! TextCollectionViewCell
            cell.itemTextLabel.text = listItem.text ?? "Empty"
            cell.deleteTapAction = {
                () in
                print("Deleting Item")
                let itemIndex = self.collectionView?.indexPath(for: cell)!
                self.listItems.remove(at: itemIndex!.item)
                self.collectionView?.deleteItems(at: [itemIndex!])
                self.moContext.delete(listItem)
                PersistentService.saveContext()
            }
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
