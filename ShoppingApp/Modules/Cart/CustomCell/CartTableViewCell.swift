//
//  CartTableViewCell.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 17.02.2024.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    // MARK: - Properties

    static let identifier = "CartTableViewCell"
    
    weak var presenter: CartPresenterProtocol?
    
    weak var cartVCDelegate: CartVCProtocol?
    
    var indexPath: IndexPath!
    var index: Int?
    var amount: Int?
    
    let productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let productName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    let amountDecreaseButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 8
        button.configuration?.title = "-"
        button.tintColor = .systemGray
        return button
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        return label
    }()
    
    let amountIncreaseButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.cornerRadius = 8
        button.configuration?.title = "+"
        button.tintColor = .systemGreen
        return button
    }()
    
    let amountStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        return stack
    }()
    
    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: ProductCartPresentation, presenter: CartPresenterProtocol?, index: Int) {
        self.presenter = presenter
        self.index = index
        self.amount = product.amount
        
        productName.text = product.name
        amountLabel.text = String(product.amount)
        price.text = "$" + String(format: "%.2f", product.price * Double(product.amount))
        
        if let url = URL(string: product.image) {
            productImage.kf.setImage(with: url)
        }
    }
    
    private func prepareView() {
        addSubview(productImage)
        addSubview(productName)
        addSubview(price)
        contentView.addSubview(amountStack)
        amountStack.addArrangedSubview(amountDecreaseButton)
        amountStack.addArrangedSubview(amountLabel)
        amountStack.addArrangedSubview(amountIncreaseButton)
        
        amountDecreaseButton.addTarget(self, action: #selector(amountDecreaseButtonClicked), for: .touchUpInside)
        amountIncreaseButton.addTarget(self, action: #selector(amountIncreaseButtonClicked), for: .touchUpInside)
        
        applyConstraints()
    }
    
    @objc func amountDecreaseButtonClicked() {
        guard let index = index else { return }
        if amount == 1 {
            cartVCDelegate?.showAlertDialog(at: indexPath)
        } else {
            presenter?.decreaseAmount(at: index)
        }
    }
    
    @objc func amountIncreaseButtonClicked() {
        guard let index = index else { return }
        presenter?.increaseAmount(at: index)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        productImage.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(15)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        
        productName.snp.makeConstraints { make in
            make.leading.equalTo(productImage.snp.trailing).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(15)
        }
        
        price.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        }
        
        amountStack.snp.makeConstraints { make in
            make.leading.equalTo(productImage.snp.trailing).offset(10)
            make.bottom.equalTo(self).offset(-15)
        }
    }
}
