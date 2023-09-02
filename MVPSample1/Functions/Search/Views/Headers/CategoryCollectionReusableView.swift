//
//  CategoryCollectionReusableView.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/02.
//

import UIKit

class CategoryCollectionReusableView: UICollectionReusableView {
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
        self.backgroundColor = .clear
        
        setUpTitle()
    }
    
    private func setUpTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.font = Const.SmallTextLabelFont
        self.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}