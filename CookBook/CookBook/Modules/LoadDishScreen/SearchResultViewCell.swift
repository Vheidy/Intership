//
//  SearchResultViewCell.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 09.04.2021.
//

import UIKit

class SearchResultViewCell: UICollectionViewCell {
    var imageDish: UIImageView
    var label: UILabel
    
    init() {
        imageDish = UIImageView()
        label = UILabel()
        super.init(frame: .zero)
        setup()
    }
    
    func setup()
    {
        contentView.addSubview(imageDish)
        contentView.addSubview(label)
        
        imageDish.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageDish.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.margin),
            imageDish.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.margin),
            imageDish.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.margin),
            imageDish.heightAnchor.constraint(equalToConstant: contentView.size.hei)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage, title: String) {
        imageDish.image = image
        label.text = title
    }
}
