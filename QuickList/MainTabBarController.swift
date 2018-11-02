//
//  MainTabBarController.swift
//  QuickList
//
//  Created by Greg Alton on 10/17/18.
//  Copyright © 2018 Greg Alton. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        setupTabBar()
        
    }
    
    func setupTabBar() {
        
        let listViewController = UINavigationController(rootViewController: ListViewController())
        listViewController.tabBarItem.image = UIImage(named: "home")
        
        let cameraViewController = UINavigationController(rootViewController: CameraViewController())
        cameraViewController.tabBarItem.image = UIImage(named: "camera")
        
        let textItemViewController = UINavigationController(rootViewController: TextItemViewController())
        textItemViewController.tabBarItem.image = UIImage(named: "text")
        
        viewControllers = [listViewController, cameraViewController, textItemViewController]
        
        tabBar.barTintColor = UIColor.black
    }


}

