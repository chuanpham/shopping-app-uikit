//
//  HomeItemCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 13.02.2024.
//

import UIKit
import Kingfisher

class HomeItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeItemCollectionViewCell"
    
    let productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        label.text = "Apple"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$4.99"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareView() {
        layer.cornerRadius = 17
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(productImage)
        addSubview(nameLabel)
        addSubview(priceLabel)
        
        applyConstraints()
    }
    
    func configure(with product: ProductItemPresentation) {
        nameLabel.text = product.name
        priceLabel.text = "$" + String(format: "%.2f", product.price)
        
        if let imageURL = URL(string: product.imageURL) {
            productImage.kf.setImage(with: imageURL)
        }
    }
    
    private func applyConstraints() {
        productImage.snp.makeConstraints { make in
            make.leading.top.equalTo(self).offset(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(185)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.top.equalTo(productImage.snp.bottom).offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
    }
}
