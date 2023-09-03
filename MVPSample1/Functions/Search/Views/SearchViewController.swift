//
//  SearchViewController.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/01.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let searchBar = UISearchBar()
    private var categoryCollectionView: UICollectionView!
    private var presenter: SearchViewPresenter!
    
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
    
    func inject(presenter: SearchViewPresenter) {
        self.presenter = presenter
    }
    
    // MARK: - Layout
     
    private func setUpLayout() {
        self.view.backgroundColor = .systemBackground
        
        setUpGradientLayer()
        setUpTitleLabel()
        setUpSearchBar()
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
        titleLabel.text = "検索"
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
            string: "作品名、人名で検索",
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
    
    private func setUpCategoryCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: self.view.bounds.width, height: 30)
        collectionViewLayout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: 50)
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        categoryCollectionView.backgroundColor = .clear
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        categoryCollectionView.register(CategoryCollectionReusableView.self,
                                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: "sectionHeader")
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(categoryCollectionView)
        
        let tabHeight = tabBarController?.tabBar.frame.size.height ?? 0
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -tabHeight)
        ])
    }
}


// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.category.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.category[section].itemSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.title.text = presenter.category[indexPath.section].itemSection[indexPath.row].title
        cell.imageView.image = UIImage(systemName: presenter.category[indexPath.section].itemSection[indexPath.row].imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! CategoryCollectionReusableView
        header.title.text = presenter.category[indexPath.section].title
        return header
    }
}


// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.getSection(at: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - SearchViewPresenterOutput

extension SearchViewController: SearchViewPresenterOutput {
    func transitionToNext(itemSection: ItemSection) {
        Router.showAllWorksList(fromVC: self, itemSection: itemSection)
    }
}
 
