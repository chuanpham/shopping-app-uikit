//
//  AddToCartSuccessView.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 25.02.2024.


import UIKit

final class AddToCartSuccessView: UIViewController {
    // MARK: - Properties
    
    var presenter: ProductDetailsPresenterProtocol?
    
    private let button: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.tintColor = .greenTint
        button.configuration?.title = "Go To Cart"
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Product successfully added to cart"
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .greenTint
        image.image = UIImage(systemName: "checkmark.circle.fill")
        return image
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    private func prepareView() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(addToCartButtonClicked), for: .touchUpInside)
        
        applyConstraints()
    }
    
    @objc func addToCartButtonClicked() {
        presenter?.goToShoppingCartButtonClicked()
        dismiss(animated: true, completion: nil)
    }
    
    private func applyConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
            make.height.equalTo(50)
        }
    }
}
