//
//  HomeInteractor.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 29.02.2024.
//

import Foundation

class HomeInteractor {
    weak var delegate: HomeInteractorDelegate?
    private let service: StoreServiceDelegate
    
    var bestSelling = [Product]()
    var specialOffers = [Product]()
    
    init(service: StoreServiceDelegate) {
        self.service = service
    }
    
    private func fetchBestSellingProducts(completion: @escaping () -> Void) {
        StoreService.shared.fetchBestSelling(limit: 5) { [weak self] result in
            switch(result){
            case .success(let products):
                self?.bestSelling.append(contentsOf: products)
                self?.delegate?.handleOutput(.showBestSelling(products))
            case .failure(let error):
                print(error)
            }
            completion()
        }
    }
    
    private func fetchSpecialOffers(completion: @escaping () -> Void) {
        StoreService.shared.fetchSpecialOffers(limit: 5) { [weak self] result in
            switch(result){
            case .success(let products):
                self?.specialOffers.append(contentsOf: products)
                self?.delegate?.handleOutput(.showSpecialOffers(products))
            case .failure(let error):
                print(error)
            }
            completion()
        }
    }
}

extension HomeInteractor: HomeInteractorProtocol {
    func load() {
        delegate?.handleOutput(.setLoading(true))
        let group = DispatchGroup()
        group.enter()
        fetchBestSellingProducts() {
            group.leave()
        }
        group.enter()
        fetchSpecialOffers() {
            group.leave()
        }
        group.notify(queue: .main) {
            self.delegate?.handleOutput(.setLoading(false))
        }
    }
    
    func selectProductItem(from section: Int, at index: Int) {
        let product: Product
        
        if section == HomeSections.bestSelling.rawValue {
            product = bestSelling[index]
        }else {
            product = specialOffers[index]
        }
        
        delegate?.handleOutput(.showProductDetails(product))
    }
}
