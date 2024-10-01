//
//  CartEmptyView.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import UIKit

class CartEmptyView: UIView {
    let cartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "cart")
        imageView.tintColor = .greenTint
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Your cart is empty"
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
        addSubview(cartImage)
        addSubview(label)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        cartImage.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(120)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(cartImage.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
    }
    
}
