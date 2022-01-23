//
//  ViewController.swift
//  PhotoTestProject
//
//  Created by Василий on 20.01.2022.
//

import UIKit

class StartTabBarController: UITabBarController {

// MARK: - properties

    private var photoCollectionVc = PhotoCollectionView()
    private var photoTableVc = PhotoTableView()

// MARK: - lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }

// MARK: - UI

    private func setup(){
        let collectionItem = UITabBarItem(title: "Search", image: .strokedCheckmark, tag: 0)
        photoCollectionVc.tabBarItem = collectionItem

        let tableItem = UITabBarItem(title: "Loves", image: .actions, tag: 0)
        photoTableVc.tabBarItem = tableItem

        self.viewControllers = [photoCollectionVc, photoTableVc]
    }

}

