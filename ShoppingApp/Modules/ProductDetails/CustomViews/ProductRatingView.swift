//
//  ProductRatingView.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 16.02.2024.
//

import UIKit

final class ProductRatingView: UIView {
    // MARK: - Properties
    
    let stack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()

    let rating: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    let starsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    var stars = [UIImageView]()
    
    let ratingCount: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(rating: Double, ratingCount: Int) {
        self.rating.text = String(rating)
        self.ratingCount.text = " | \(ratingCount) ratings"
        
        createStars()
        fillStars(rating: rating)
    }
    
    private func prepareView() {
        addSubview(stack)
        stack.addArrangedSubview(rating)
        stack.addArrangedSubview(starsStack)
        stack.addArrangedSubview(ratingCount)
        
        stack.setCustomSpacing(10, after: rating)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func fillStars(rating: Double) {
        let wholeNumber = Int(rating)
        
        // whole stars
        for i in 0...wholeNumber-1 {
            stars[i].image = UIImage(systemName: "star.fill")
        }
        
        // Half Stars
        let remainder = rating.truncatingRemainder(dividingBy: 1)
        if remainder > 0 {
            stars[wholeNumber].image = UIImage(systemName: "star.leadinghalf.filled")
        }
    }
    
    private func createStars() {
        for _ in 0...4 {
            let star = UIImageView(image: UIImage(systemName: "star"))
            star.tintColor = .greenTint
            stars.append(star)
            starsStack.addArrangedSubview(star)
        }
    }
}
