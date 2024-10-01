//
//  HomeBannerCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 13.02.2024.
//

import UIKit

class HomeBannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeBannerCollectionViewCell"
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 17
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageIndex: Int) {
        imageView.image = UIImage(named: "Banner\(imageIndex+1)")
    }
    
    private func prepareView() {
        addSubview(imageView)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
//            make.size.equalTo(CGSize(width: 500, height: 200))
        }
    }
}
