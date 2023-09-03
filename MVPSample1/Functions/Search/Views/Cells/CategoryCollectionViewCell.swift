//
//  CategoryCollectionViewCell.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/02.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    let title = UILabel()
    let imageView = UIImageView()
    let indicatorImageView = UIImageView()
    private let separatorLineView = UIView()
    
    override var isSelected: Bool {
        // MEMO: 選択時の色を変える
        didSet {
            contentView.backgroundColor = isSelected ? .systemGray : .clear
        }
    }
    
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
        
        setUpSeparatorLineView()
        setUpImageView()
        setUpIndicatorImageView()
        setUpTitle()
    }
    
    private func setUpSeparatorLineView() {
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        separatorLineView.backgroundColor = .systemGray
        self.contentView.addSubview(separatorLineView)
        
        NSLayoutConstraint.activate([
            separatorLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            separatorLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            separatorLineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func setUpImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        self.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setUpIndicatorImageView() {
        indicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        indicatorImageView.image = UIImage(systemName: "chevron.right")
        indicatorImageView.tintColor = .systemGray
        indicatorImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(indicatorImageView)
        
        NSLayoutConstraint.activate([
            indicatorImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            indicatorImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            indicatorImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            indicatorImageView.heightAnchor.constraint(equalTo: indicatorImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setUpTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.font = Const.MediumTextLabelFont
        self.contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            title.trailingAnchor.constraint(equalTo: indicatorImageView.leadingAnchor, constant: -10),
            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            title.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
