//
//  AllWorksCollectionViewCell.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/03.
//

import UIKit

class AllWorksCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setUpLayout() {
        self.contentView.backgroundColor = .clear
        
        setUpImageView()
        setUpStackView()
        setUpSeparatorLineView()
    }
    
    private func setUpImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant:  -5),
            imageView.widthAnchor.constraint(equalToConstant: self.contentView.bounds.width / 5 * 2)
        ])
    }
    
    private func setUpStackView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15)
        ])
        
        // MEMO: TitleLabelの設定
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = Const.mediumBoldTextLabelFont
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        // MEMO: DetailLabelの設定
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = Const.smallTextLabelFont
        descriptionLabel.numberOfLines = 0
    }
    
    private func setUpSeparatorLineView() {
        let separatorLineView = UIView()
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        separatorLineView.backgroundColor = Const.spaceLineColor
        self.contentView.addSubview(separatorLineView)
        
        NSLayoutConstraint.activate([
            separatorLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            separatorLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            separatorLineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
