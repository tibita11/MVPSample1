//
//  LibraryViewController.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/01.
//

import UIKit

final class LibraryViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private var categoryCollectionView: UICollectionView!
    private var presenter: LibraryViewPresenterInput!
    
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
    
    func inject(presenter: LibraryViewPresenterInput) {
        self.presenter = presenter
    }
    
    // MARK: - Layout
    
    private func setUpLayout() {
        self.view.backgroundColor = .systemBackground
        
        setUpGradientLayer()
        setUpTitleLabel()
        setUpCategoryCollectionView()
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
        titleLabel.text = "ライブラリ"
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
    
    private func setUpCategoryCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: self.view.bounds.width, height: 40)
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        categoryCollectionView.backgroundColor = .clear
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(categoryCollectionView)
        
        let tabHeight = tabBarController?.tabBar.frame.size.height ?? 0
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -tabHeight)
        ])
    }
}


// MARK: - UICollectionViewDataSource

extension LibraryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.itemData[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        cell.title.text = presenter.itemData[indexPath.section][indexPath.row].title
        cell.imageView.image = UIImage(systemName: presenter.itemData[indexPath.section][indexPath.row].imageName)
        return cell
    }
}


// MARK: - UICollectionViewDelegate

extension LibraryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // MEMO: マイリストのみ遷移処理を実装
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                Router.showMyList(fromVC: self)
            default: break
            }
        default: break
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


// MARK: - LibraryViewPresenterOutput

extension LibraryViewController: LibraryViewPresenterOutput {
    
}
