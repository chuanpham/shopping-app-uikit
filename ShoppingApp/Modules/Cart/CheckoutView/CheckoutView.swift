//
//  CheckoutView.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import UIKit

class CheckoutView: UIViewController {
    let checkoutView = CheckoutContentView()
    var presenter: CartPresenterProtocol?
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    func configure(subtotal: Double) {
        checkoutView.configure(subtotal: subtotal)
    }
    
    func buy() {
        presenter?.buy()
        dismiss(animated: true)
    }
    
    private func prepareView() {
        checkoutView.parentView = self
        view.addSubview(button)
        view.addSubview(checkoutView)
        
        button.addTarget(self, action: #selector(viewCloseButtonClicked), for: .touchUpInside)
        
        applyConstraints()
    }
    
    @objc private func viewCloseButtonClicked() {
        dismiss(animated: true)
    }
    
    private func applyConstraints() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        checkoutView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo((view.frame.height / 4) + 50)
        }
    }
}
