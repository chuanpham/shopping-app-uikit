//
//  CategoryCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 15.02.2024.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    let categoryImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 17
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with categoryName: String) {
        categoryNameLabel.text = categoryName
        categoryImage.image = UIImage(named: categoryName)
    }
    
    private func prepareCell() {
        layer.cornerRadius = 17
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(categoryImage)
        addSubview(categoryNameLabel)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        categoryImage.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.height.equalTo(140)
        }
        
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryImage.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
        }
    }
}
