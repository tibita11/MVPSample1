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
        
        // MEMO: 初期化時にPresenterを設定する
        let searchVC = SearchViewController()
        let presenter = SearchViewPresenter(output: searchVC)
        searchVC.inject(presenter: presenter)
        let searchNavigationController = UINavigationController(rootViewController: searchVC)
        searchNavigationController.tabBarItem = UITabBarItem(title: "検索", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        // MEMO: 初期化時にPresenterを設定する
        let libraryVC = LibraryViewController()
        let libraryViewPresenter = LibraryViewPresenter(output: libraryVC)
        libraryVC.inject(presenter: libraryViewPresenter)
        let libraryNavigationController = UINavigationController(rootViewController: libraryVC)
        libraryNavigationController.tabBarItem = UITabBarItem(title: "ライブラリ", image: UIImage(systemName: "books.vertical.fill"), tag: 0)
        
        viewControllers = [searchNavigationController, libraryNavigationController]
    }
}
