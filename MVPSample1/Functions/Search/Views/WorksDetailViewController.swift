//
//  WorksDetailViewController.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/03.
//

import UIKit

final class WorksDetailViewController: UIViewController {
    
    private let backButton = UIButton()
    private var presenter: WorksDetailViewPresenterInput!
    private let myListButton = UIButton()
    
    private lazy var initViewLayout: Void = {
        setUpLayout()
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MEMO: マイリスト登録状況に応じてButton表示を変える
        animateMyListButton(isRegistered: self.presenter.isRegistered)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _ = initViewLayout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - Action
    
    func inject(presenter: WorksDetailViewPresenterInput) {
        self.presenter = presenter
    }
    
    @objc private func dismissView() {
        if let presentationController = presentationController,
           let delegate = presentationController.delegate {
            delegate.presentationControllerDidDismiss?(presentationController)
        }
        self.dismiss(animated: true)
    }
    
    @objc private func tapMyListButton() {
        // MEMO: 追加・削除の動きを実装
        self.presenter.changeMyListStatus()
    }
    
    /// マイリストボタンのアニメーション実行
    func animateMyListButton(isRegistered: Bool) {
        let imageName = isRegistered ? "checkmark" : "plus"
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.myListButton.alpha = 0
        }, completion: { [weak self] _ in
            self?.myListButton.setImage(UIImage(systemName: imageName), for: .normal)
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.myListButton.alpha = 1
            })
        })
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
        titleLabel.text = self.presenter.title
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
        descriptionLabel.text = self.presenter.description
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
        stackView.addArrangedSubview(myListButton)
        
        var config = UIButton.Configuration.plain()
        config.title = "マイリスト"
        config.image = UIImage(systemName: "plus")
        config.imagePadding = 5
        config.imagePlacement = .top
        config.baseForegroundColor = .white
        myListButton.configuration = config
        myListButton.addTarget(self, action: #selector(tapMyListButton), for: .touchUpInside)
    }
}


// MARK: - WorksDetailViewPresenterOutput

extension WorksDetailViewController: WorksDetailViewPresenterOutput {
    func updateMyList(isRegistered: Bool) {
        animateMyListButton(isRegistered: isRegistered)
    }
}
