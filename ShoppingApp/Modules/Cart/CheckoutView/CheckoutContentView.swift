//
//  CheckoutView.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import UIKit

final class CheckoutContentView: UIView {
    weak var parentView: CheckoutView?
    
    let subtotal: CheckoutExpenseView = {
        let view = CheckoutExpenseView()
        view.expenseName.text = "Sub Total"
        view.price.text = "$0.00"
        return view
    }()
    
    let shipment: CheckoutExpenseView = {
        let view = CheckoutExpenseView()
        view.expenseName.text = "Shipment"
        view.price.text = "$0.00"
        return view
    }()
    
    let tax: CheckoutExpenseView = {
        let view = CheckoutExpenseView()
        view.expenseName.text = "Tax"
        view.price.text = "$0.00"
        return view
    }()
    
    let divider = UIView()
    
    let total: CheckoutExpenseView = {
        let view = CheckoutExpenseView()
        view.expenseName.text = "Total"
        view.price.text = "$0.00"
        return view
    }()
    
    let buyNowButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.backgroundColor = .greenTint
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.configuration?.title = "Buy Now"
        return button
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()

    let spacerView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareView() {
        backgroundColor = .systemBackground
        addSubview(stackView)
        stackView.addArrangedSubview(subtotal)
        stackView.addArrangedSubview(shipment)
        stackView.addArrangedSubview(tax)
        stackView.addArrangedSubview(divider)
        stackView.addArrangedSubview(total)
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(buyNowButton)
        
        buyNowButton.addTarget(self, action: #selector(buyNowButtonPressed), for: .touchUpInside)
        
        divider.backgroundColor = .lightGray
        applyConstraints()
    }
    
    @objc private func buyNowButtonPressed() {
        parentView?.buy()
    }
    
    func configure(subtotal: Double) {
        let tax = (subtotal / 100) * 18
        let shipment = 23.80
        
        self.subtotal.price.text = String(format: "%.2f", subtotal)
        self.tax.price.text = String(format: "%.2f", tax)
        self.shipment.price.text = String(format: "%.2f", shipment)
        self.total.price.text = "$" + String(format: "%.2f", subtotal + tax + shipment)
    }
    
    private func applyConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(15)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(15)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-15)
        }
        
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        buyNowButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
}
