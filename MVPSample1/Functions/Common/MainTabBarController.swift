//
//  MainTabBarController.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/01.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    private func setUp() {
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.tintColor = .white
        
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "検索", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        let libraryVC = LibraryViewController()
        libraryVC.tabBarItem = UITabBarItem(title: "ライブラリ", image: UIImage(systemName: "books.vertical.fill"), tag: 0)
        viewControllers = [searchVC, libraryVC]
    }
}
