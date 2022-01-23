//
//  ViewController.swift
//  PhotoTestProject
//
//  Created by Василий on 20.01.2022.
//

import UIKit

class StartTabBarController: UITabBarController {

// MARK: - lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }

// MARK: - UI

    private func setup(){
        tabBar.barTintColor = .systemYellow
        let photoCollectionViewController = PhotoCollectionViewController()
        let photoTableViewController = PhotoTableViewController()

        let collectionItem = UITabBarItem(title: "Search", image: .strokedCheckmark, tag: 0)
        photoCollectionViewController.tabBarItem = collectionItem

        let tableItem = UITabBarItem(title: "Favourite", image: .actions, tag: 0)
        photoTableViewController.tabBarItem = tableItem

        self.viewControllers = [photoCollectionViewController, photoTableViewController]
    }

}

