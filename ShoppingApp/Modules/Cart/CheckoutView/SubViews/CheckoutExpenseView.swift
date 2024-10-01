//
//  CheckoutView.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import UIKit

final class CheckoutExpenseView: UIView {
    let expenseName = UILabel()
    let price: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
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
        addSubview(expenseName)
        addSubview(price)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        expenseName.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(self)
        }
        
        price.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
}
