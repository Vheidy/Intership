//
//  CollectionViewCell.swift
//  FirstTaskWithoutStryBoard
//
//  Created by OUT-Salyukova-PA on 09.03.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    var avatarLabel: UILabel! {
        didSet {
            avatarLabel.backgroundColor = .red
            avatarLabel.translatesAutoresizingMaskIntoConstraints = false
            avatarLabel.font = UIFont(name: "Helvetica", size: 40)
            NSLayoutConstraint.activate([
                avatarLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                avatarLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                avatarLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16)
            ])
        }
    }
    var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.backgroundColor = .blue
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.font = UIFont(name: "Helvetica", size: 20)
            NSLayoutConstraint.activate([
                descriptionLabel.leadingAnchor.constraint(equalTo: avatarLabel.trailingAnchor, constant: 25)
            ])
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
