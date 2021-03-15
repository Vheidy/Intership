//
//  CircleViewCell.swift
//  FirstTaskWithoutStryBoard
//
//  Created by OUT-Salyukova-PA on 11.03.2021.
//

import UIKit

class CircleViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    let imageRounded = UIImageView()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setImage()
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImage() {
        contentView.addSubview(imageRounded)
        
        imageRounded.translatesAutoresizingMaskIntoConstraints = false
        
        imageRounded.sizeToFit()
        NSLayoutConstraint.activate([
            imageRounded.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageRounded.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageRounded.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            imageRounded.widthAnchor.constraint(equalToConstant: contentView.bounds.width * 0.2)
        ])
    }
    
    private func setLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = UIFont(name: "Helvetica", size: 25)
        descriptionLabel.textColor = .gray
        NSLayoutConstraint.activate([
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
