//
//  ProductDetailsVC.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 16.02.2024.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    var presenter: ProductDetailsPresenterProtocol?
    
    // MARK: - Properties
    
    var amount: Int = 1
    var productPrice: Double = 0.0
    
    let productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    let productRatingView = ProductRatingView()
    
    let price: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let details: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let addToCartButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.backgroundColor = .greenTint
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.configuration?.title = "Add To Cart"
        return button
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
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let estimatedPrice: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        //        stack.distribution = .equalSpacing
        return stack
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.style = .large
        return spinner
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
        prepareView()
    }
    
    private func prepareView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(productImage)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(productRatingView)
        stackView.addArrangedSubview(price)
        stackView.addArrangedSubview(details)
        
        stackView.addArrangedSubview(amountStack)
        amountStack.addArrangedSubview(amountDecreaseButton)
        amountStack.addArrangedSubview(amountLabel)
        amountStack.addArrangedSubview(amountIncreaseButton)
        amountStack.addArrangedSubview(estimatedPrice)
        
        stackView.addArrangedSubview(addToCartButton)
        
        view.addSubview(spinner)
        
        amountDecreaseButton.addTarget(self, action: #selector(amountDecreaseButtonClicked), for: .touchUpInside)
        amountIncreaseButton.addTarget(self, action: #selector(amountIncreaseButtonClicked), for: .touchUpInside)
        
        //stackView.setCustomSpacing(20, after: amountStack)
        
        stackView.setCustomSpacing(100, after: addToCartButton)
        
        addToCartButton.addTarget(self, action: #selector(addToCartButtonClicked), for: .touchUpInside)
        
        applyConstraints()
    }
    
    @objc func amountDecreaseButtonClicked() {
        if amount == 1 { return }
        amount -= 1
        amountLabel.text = String(amount)
        estimatedPrice.text = "$" + String(format: "%.2f", productPrice * Double(amount))
    }
    
    @objc func amountIncreaseButtonClicked() {
        amount += 1
        amountLabel.text = String(amount)
        estimatedPrice.text = "$" + String(format: "%.2f", productPrice * Double(amount))
    }
    
    @objc private func addToCartButtonClicked() {
        presenter?.addToCartButtonClicked(amount: amount)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        productImage.snp.makeConstraints { make in
            make.height.equalTo(350)
        }
        
        amountStack.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.6)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        amountDecreaseButton.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        amountIncreaseButton.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        spinner.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ProductDetailsVC: ProductDetailsViewProtocol {
    func handleOutput(_ output: ProductDetailsPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading {
                spinner.startAnimating()
            }else {
                spinner.stopAnimating()
            }
        case .showProductDetails(let product):
            name.text = product.name
            productPrice = product.price
            productRatingView.configure(rating: product.rate, ratingCount: product.ratingCount)
            price.text = "$" + String(format: "%.2f", product.price)
            estimatedPrice.text = "$" + String(format: "%.2f", product.price)
            details.text = product.description
            
            if let url = URL(string: product.image) {
                productImage.kf.setImage(with: url)
            }
        }
    }
}
