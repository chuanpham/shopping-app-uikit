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
        stackView.addArrangedSubview(addToCartButton)
        view.addSubview(spinner)
        
        stackView.setCustomSpacing(20, after: details)
        
        addToCartButton.addTarget(self, action: #selector(addToCartButtonClicked), for: .touchUpInside)
        
        applyConstraints()
    }
    
    @objc private func addToCartButtonClicked() {
        presenter?.addToCartButtonClicked()
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
            productRatingView.configure(rating: product.rate, ratingCount: product.ratingCount)
            price.text = "$" + String(format: "%.2f", product.price)
            details.text = product.description
            
            if let url = URL(string: product.image) {
                productImage.kf.setImage(with: url)
            }
        }
    }
}
