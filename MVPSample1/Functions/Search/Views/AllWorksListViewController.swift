//
//  AllWorksListViewController.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/03.
//

import UIKit

class AllWorksListViewController: UIViewController {
    
    private let itemSection: ItemSection!
    private let titleLabel = UILabel()
    private var allWorksCollectionView: UICollectionView!
    
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
        self.view.backgroundColor = .systemBackground
        
        setUpGradientLayer()
        setUpTitleLabel()
        setUpAllWorksCollectionView()
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
        titleLabel.text = "すべての作品"
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
    
    private func setUpAllWorksCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.width, height: 80)
        layout.minimumLineSpacing = 0
        allWorksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        allWorksCollectionView.backgroundColor = .clear
        allWorksCollectionView.dataSource = self
        allWorksCollectionView.register(AllWorksCollectionViewCell.self, forCellWithReuseIdentifier: "allWorksCell")
        allWorksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(allWorksCollectionView)
        
        let tabHeight = tabBarController?.tabBar.frame.size.height ?? 0
        NSLayoutConstraint.activate([
            allWorksCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            allWorksCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            allWorksCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            allWorksCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -tabHeight)
        ])
    }
}


// MARK: - UICollectionViewDataSource

extension AllWorksListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemSection.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allWorksCell", for: indexPath) as! AllWorksCollectionViewCell
        cell.titleLabel.text = itemSection.items[indexPath.row].title
        cell.descriptionLabel.text = itemSection.items[indexPath.row].description
        return cell
    }
}
