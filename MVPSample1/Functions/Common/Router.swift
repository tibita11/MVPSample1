//
//  Router.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/01.
//

import UIKit

final class Router {
    /// アプリ起動時にルートを設定する
    static func showRoot(window: UIWindow?) {
        let vc = MainTabBarController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    static func showAllWorksList(fromVC: UIViewController, itemSection: ItemSection) {
        let nextVC = AllWorksListViewController(itemSection: itemSection)
        show(fromVC: fromVC, nextVC: nextVC)
    }
    
    static func showWorksDetail(fromVC: UIViewController, itemData: ItemData) {
        let nextVC = WorksDetailViewController()
        let nextPresenter = WorksDetailViewPresenter(output: nextVC, itemData: itemData)
        nextVC.inject(presenter: nextPresenter)
        fromVC.present(nextVC, animated: true)
    }
    
    static func showMyList(fromVC: UIViewController) {
        let nextVC = MyListViewController()
        show(fromVC: fromVC, nextVC: nextVC)
    }
    
    private static func show(fromVC: UIViewController, nextVC: UIViewController) {
        if let nav = fromVC.navigationController {
            nav.pushViewController(nextVC, animated: true)
        } else {
            fromVC.present(nextVC, animated: true, completion: nil)
        }
    }
}
