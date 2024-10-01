//
//  CheckoutButton.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import UIKit

class CheckoutButton: UIButton {
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .black.withAlphaComponent(0.3)
        label.textColor = .white
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(priceLabel)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(30)
        }
    }
    
    func setPriceValue(_ value: String) {
        priceLabel.text = value
        let textWidth = (value as NSString).size(withAttributes: [NSAttributedString.Key.font: priceLabel.font!]).width
//        badgeWidthConstraint?.constant = max(30, textWidth + 10)  10 for padding
        priceLabel.snp.updateConstraints { make in
            make.width.equalTo(max(100,textWidth + 10))
        }
    }
}
