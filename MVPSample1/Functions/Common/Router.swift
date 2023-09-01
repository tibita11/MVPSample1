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
        let rootVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
}
