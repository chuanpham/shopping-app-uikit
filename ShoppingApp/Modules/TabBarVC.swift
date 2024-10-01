//
//  TabBarVC.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 13.02.2024.
//

import UIKit

enum TabBarPages: String {
    case homeVC = "HomeVC"
    case categoriesVC = "CategoriesVC"
    case cartVC = "CartVC"
}

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        let homeVC = UINavigationController(rootViewController: HomeBuilder.make())
        let CategoriesVC = UINavigationController(rootViewController: CategoriesBuilder.make())
        let CartVC = UINavigationController(rootViewController: CartBuilder.make())
        
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        CategoriesVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        CartVC.tabBarItem.selectedImage = UIImage(systemName: "cart.fill")
        CartVC.tabBarItem.image = UIImage(systemName: "cart")
        
        homeVC.title = "Home"
        CategoriesVC.title = "Categories"
        CartVC.title = "Cart"
        
        // set RestorationIdentifier to programmatically switch tab bar tabs
        homeVC.restorationIdentifier = TabBarPages.homeVC.rawValue
        CategoriesVC.restorationIdentifier = TabBarPages.categoriesVC.rawValue
        CartVC.restorationIdentifier = TabBarPages.cartVC.rawValue
        
        tabBar.tintColor = .label
        
        setViewControllers([homeVC, CategoriesVC, CartVC], animated: true)
    }
}
