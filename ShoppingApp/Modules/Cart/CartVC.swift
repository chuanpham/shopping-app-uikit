//
//  CartVC.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 13.02.2024.
//

import UIKit

protocol CartVCProtocol: AnyObject {
    func showAlertDialog(at indexPath: IndexPath)
}

class CartVC: UIViewController {
    // MARK: - TypeAlias
    
    typealias Cell = CartTableViewCell
    
    // MARK: - Properties
    
    var presenter: CartPresenterProtocol?
    
    var products = [ProductCartPresentation]()
    var subTotal = 0.0
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
        return tableView
    }()
    
    let checkoutButton: CheckoutButton = {
        let button = CheckoutButton()
        button.configuration = .plain()
        button.backgroundColor = .greenTint
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.configuration?.title = "Checkout"
        button.priceLabel.text = "$0.00"
        return button
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.style = .large
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.load()
    }
    
    let cartEmptyView: CartEmptyView = {
        let view = CartEmptyView()
        view.isHidden = true
        return view
    }()
    
    // MARK: - LifeCycle
    
    private func prepareView() {
        title = "My Cart"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
        view.addSubview(spinner)
        view.addSubview(cartEmptyView)
        
        checkoutButton.addTarget(self, action: #selector(checkoutButtonClicked), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        applyConstraints()
    }
    
    @objc private func checkoutButtonClicked() {
        presenter?.checkout(subtotal: subTotal)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        checkoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(60)
        }
        
        spinner.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        cartEmptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.cartVCDelegate = self
        cell.indexPath = indexPath
        cell.configure(with: products[indexPath.row], presenter: presenter, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            self.presenter?.deleteProduct(at: indexPath.row)
            self.products.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.updateProductSubtotal()
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
}

extension CartVC: CartViewProtocol {
    func handleOutput(_ output: CartPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            setLoading(isLoading: isLoading)
        case .showProducts(let products):
            showProducts(products: products)
        case .showCheckoutSuccess:
            showCheckoutSuccess()
        case .showEmptyCartView:
            showEmptyCartView()
        }
    }
    
    private func setLoading(isLoading: Bool) {
        if isLoading {
            spinner.startAnimating()
        }else {
            spinner.stopAnimating()
        }
    }
    
    private func showProducts(products: ([ProductCartPresentation])) {
        cartEmptyView.isHidden = true
        self.products = products
        tableView.reloadData()
        
        checkoutButton.isHidden = false
        updateProductSubtotal()
    }
    
    private func updateProductSubtotal() {
        subTotal = 0.0
        for product in products {
            subTotal += product.price * Double(product.amount)
        }
        checkoutButton.setPriceValue("$" + String(format: "%.2f",subTotal))
    }
    
    private func showCheckoutSuccess() {
        let indexPaths = products.indices.map { IndexPath(row: $0, section: 0) }
        products.removeAll()
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.showEmptyCartView()
        }
        self.tableView.deleteRows(at: indexPaths, with: .automatic)
        CATransaction.commit()
    }
    
    private func showEmptyCartView() {
        checkoutButton.isHidden = true
        cartEmptyView.isHidden = false
    }
}

extension CartVC: CartVCProtocol {
    func deleteProductAndReloadTableView(at indexPath: IndexPath) {
        self.presenter?.deleteProduct(at: indexPath.row)
        self.products.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.updateProductSubtotal()
    }
    
    func showAlertDialog(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Information", message: "Do you want to remove this item from your cart?", preferredStyle: .alert)
        alert.view.tintColor = .blue
        let actionOK = UIAlertAction(title: "Ok", style: .destructive) { _ in
            self.dismiss(animated: true)
            self.deleteProductAndReloadTableView(at: indexPath)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(actionOK)
        alert.addAction(actionCancel)

        present(alert, animated: true, completion: nil)
    }
}
