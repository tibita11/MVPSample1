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
    private var dataSource: UICollectionViewDiffableDataSource<Section, ItemData>!
    private var presenter: MyListViewPresenterInput!
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.fetchArray()
    }
    
    // MARK: - Action
    
    func inject(presenter: MyListViewPresenterInput) {
        self.presenter = presenter
    }
    
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
        configureDataSource()
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
            // MEMO: セルの大きさを指定する
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
            // MEMO: アイテムのレイアウトを作成する
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            // MEMO: アイテムを含むグループのレイアウトを作成する
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            // MEMO: グループを含むセクションのレイアウトを作成する
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        collectionView = UICollectionView(frame: .null, collectionViewLayout: layout)
        collectionView.delegate = self
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
    
    private func configureDataSource() {
        let allWorksCellRegistration = UICollectionView.CellRegistration<AllWorksCollectionViewCell, ItemData> { cell, indexPath, itemData in
            cell.titleLabel.text = itemData.title
            cell.descriptionLabel.text = itemData.description
        }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                collectionView.dequeueConfiguredReusableCell(using: allWorksCellRegistration, for: indexPath, item: itemIdentifier)
            })
    }
}

// MARK: - MyListViewPresenterOutput

extension MyListViewController: MyListViewPresenterOutput {
    func applySnapshot(items: [ItemData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


// MARK: - UICollectionViewDelegate

extension MyListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Router.showWorksDetail(fromVC: self, itemData: self.presenter.items[indexPath.row])
    }
}


// MARK: - UIAdaptivePresentationControllerDelegate

extension MyListViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        // MEMO: Dismiss後に再取得
        presenter.fetchArray()
    }
}
