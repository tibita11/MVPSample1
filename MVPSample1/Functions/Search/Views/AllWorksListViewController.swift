//
//  AllWorksListViewController.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/03.
//

import UIKit

class AllWorksListViewController: UIViewController {
    
    private let itemSection: ItemSection!
    
    private lazy var initViewLayout: Void = {
        setUpLayout()
    }()
    
    // MARK: - View Life Cycle
    
    init(itemSection: ItemSection) {
        self.itemSection = itemSection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _ = initViewLayout
    }
    
    // MARK: - Layout
    
    private func setUpLayout() {
        self.view.backgroundColor = .clear
        
        setUpGradientLayer()
    }
    
    private func setUpGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        let gradientColors: [CGColor] = [
            Const.mainGradientTopCGColor,
            Const.mainGradientBottomCGColor
        ]
        gradientLayer.colors = gradientColors
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
