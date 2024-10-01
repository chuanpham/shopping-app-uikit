//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 12.02.2024.
//

import UIKit
import SnapKit

enum HomeSections: Int, CustomStringConvertible, CaseIterable {
    case bestSelling
    case specialOffers
    
    var description: String {
        switch self.rawValue {
        case 0: return "Best Selling"
        case 1: return "Special Offers"
        default: return ""
        }
    }
}

protocol HomeVCProtocol {
    func reloadTableView()
    func navigateToProductDetails(vc: ProductDetailsVC)
}

class HomeVC: UIViewController {
    // MARK: - TypeAlias
    
    typealias BannerCell = HomeBannerCollectionViewCell
    typealias ProductCell = HomeProductTableViewCell
    
    // MARK: - Properties
    
    var presenter: HomePresenterProtocol?
    
    let sectionNames = ["Best Selling", "Special Offer"]
    
    var bestSellingProducts = [ProductItemPresentation]()
    var specialOfferProducts = [ProductItemPresentation]()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    let bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.style = .large
        return spinner
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
        prepareView()
    }
    
    private func prepareView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(bannerCollectionView)
        stackView.addArrangedSubview(tableView)
        view.addSubview(spinner)
        
        tableView.delegate = self
        tableView.dataSource = self
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        applyConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layoutIfNeeded()
        tableView.snp.updateConstraints { make in
            make.height.equalTo(tableView.contentSize.height)
        }
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
        
        bannerCollectionView.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.width.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.height.equalTo(0)
            make.width.equalToSuperview()
        }
        
        spinner.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == HomeSections.bestSelling.rawValue {
            return HomeSections.bestSelling.description
        }else {
            return HomeSections.specialOffers.description
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            cell.configure(with: bestSellingProducts, presenter: presenter!, sectionIndex: indexPath.section)
        } else {
            cell.configure(with: specialOfferProducts, presenter: presenter!, sectionIndex: indexPath.section)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

// MARK: - BannerCollectionView

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
            return UICollectionViewCell()
        }
        cell.configure(imageIndex: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 180)
    }
}

extension HomeVC: HomeViewProtocol {
    func handleOutput(_ output: HomePresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading {
                spinner.startAnimating()
            }else {
                spinner.stopAnimating()
            }
        case .showBestSelling(let products):
            bestSellingProducts = products
            tableView.reloadData()
        case .showSpecialOffers(let products):
            specialOfferProducts = products
            tableView.reloadData()
        }
    }
}
