//
//  WorksDetailViewController.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/03.
//

import UIKit

class WorksDetailViewController: UIViewController {
    
    private let itemData: ItemData!
    private let backButton = UIButton()
    
    private lazy var initViewLayout: Void = {
        setUpLayout()
    }()
    
    // MARK: - View Life Cycle
    
    init(itemData: ItemData) {
        self.itemData = itemData
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
    
    // MARK: - Action
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
    
    // MARK: - Layout
    
    private func setUpLayout() {
        self.view.backgroundColor = .systemBackground
        
        setUpGradientLayer()
        setUpBackButton()
        setUpStackView()
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
    
    private func setUpBackButton() {
        backButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        backButton.tintColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setUpStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        // MEMO: ImageView設定
        let imageview = UIImageView()
        stackView.addArrangedSubview(imageview)
        imageview.image = UIImage(systemName: "photo")
        imageview.tintColor = .white
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageview.topAnchor.constraint(equalTo: stackView.topAnchor),
            imageview.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            imageview.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            imageview.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // MEMO: TitleLabel設定
        let titleLabel = UILabel()
        stackView.addArrangedSubview(titleLabel)
        titleLabel.text = itemData.title
        titleLabel.textColor = .white
        titleLabel.font = Const.largeBoldTextLabelFont
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20)
        ])
        
        // MEMO: DescriptionLabel設定
        let descriptionLabel = UILabel()
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.text = itemData.description
        descriptionLabel.font = Const.MediumTextLabelFont
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20)
        ])
        
        // MEMO: MyListButton設定
        let myListButton = UIButton()
        stackView.addArrangedSubview(myListButton)
        
        var config = UIButton.Configuration.plain()
        config.title = "マイリスト"
        config.image = UIImage(systemName: "plus")
        config.imagePadding = 5
        config.imagePlacement = .top
        config.baseForegroundColor = .white
        myListButton.configuration = config
    }
}
