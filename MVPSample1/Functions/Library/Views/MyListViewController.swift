//
//  MyListViewController.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/06.
//

import UIKit

class MyListViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let searchBar = UISearchBar()
    private var collectionView: UICollectionView!
    
    private lazy var initViewLayout: Void = {
        setUpLayout()
    }()
    
    private var heightToNavBar: CGFloat {
        var height: CGFloat = 0
        if let navigationController = self.navigationController {
            let navBarMaxY = navigationController.navigationBar.frame.maxY
            height = navBarMaxY
        }
        return height
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _ = initViewLayout
    }
    
    // MARK: - Action
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Layout
    
    private func setUpLayout() {
        self.view.backgroundColor = .systemBackground
        
        setUpGradientLayer()
        setUpTitleLabel()
        setUpSearchBar()
        configureCollectionView()
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
    
    private func setUpTitleLabel() {
        titleLabel.text = "マイリスト"
        titleLabel.font = Const.TitleLabelFont
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: heightToNavBar + 30),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            titleLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setUpSearchBar() {
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .clear
        searchBar.searchTextField.backgroundColor = Const.mainGradientTopColor
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "リスト内検索",
            attributes: attributes
        )
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.searchTextField.layer.borderColor = UIColor.white.cgColor
        searchBar.searchTextField.layer.borderWidth = 0.5
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureCollectionView() {
        // MEMO: CollectionViewの初期化
        let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        }
        collectionView = UICollectionView(frame: .null, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        let tabHeight = tabBarController?.tabBar.bounds.height ?? 0
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -tabHeight),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
