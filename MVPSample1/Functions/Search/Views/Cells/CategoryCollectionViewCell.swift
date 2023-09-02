//
//  CategoryCollectionViewCell.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/02.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    let title = UILabel()
    
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
        
        setUpTitle()
    }
    
    private func setUpTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.font = Const.MediumTextLabelFont
        self.contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            title.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            title.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
