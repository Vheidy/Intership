//
//  CollectionViewCell.swift
//  FirstTaskWithoutStryBoard
//
//  Created by OUT-Salyukova-PA on 09.03.2021.
//

import UIKit

class CustomViewCell: UITableViewCell {
    let avatarLabel = UILabel()
    let avatarLabel1 = UILabel()
    let avatarLabel2 = UILabel()
    let avatarLabel3 = UILabel()
    let avatarLabel4 = UILabel()
    let descriptionLabel = UILabel()
    let likeButton = UIButton()
    var currentTypeRounded: TableViewController.ViewDraw = .cornerRadius

    func roundedCornersCR(for label: UILabel) {
        label.layer.cornerRadius = 25
        label.clipsToBounds = true
    }
    
    func roundCornersBP(for label: UILabel) {
        let path = UIBezierPath(roundedRect: label.layer.bounds, cornerRadius: 25)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = label.bounds
        maskLayer.path = path.cgPath
        label.layer.mask = maskLayer
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLabel()
 
    }
    
    fileprivate func setLabel() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likeButton)
        
        contentView.addSubview(avatarLabel)
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarLabel.textAlignment = .center
        avatarLabel.contentMode = .center
        avatarLabel.backgroundColor = .gray
        avatarLabel.font = UIFont(name: "Helvetica", size: 40)
        NSLayoutConstraint.activate([
            avatarLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            avatarLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            avatarLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
        
//        setEmoji(for: avatarLabel, leadingFor: contentView)
        setEmoji(for: avatarLabel1, leadingFor: avatarLabel)
        setEmoji(for: avatarLabel2, leadingFor: avatarLabel1)
//        setEmoji(for: avatarLabel3, leadingFor: avatarLabel2)
        

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false


        descriptionLabel.font = UIFont(name: "Helvetica", size: 25)
//        descriptionLabel.backgroundColor = .gray]
        descriptionLabel.layer.shadowOffset = CGSize(width: 0, height:  0.5)
        descriptionLabel.layer.shadowColor = UIColor.black.cgColor
        descriptionLabel.layer.shadowOpacity = 0.5
        descriptionLabel.textColor = .lightGray
        NSLayoutConstraint.activate([
            descriptionLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
        
        likeButton.backgroundColor = .systemPink
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.layer.shadowOffset = CGSize(width: 0, height:  0.5)
        likeButton.layer.shadowColor = UIColor.black.cgColor
        likeButton.layer.shadowOpacity = 0.5
        
        NSLayoutConstraint.activate([
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            likeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            likeButton.widthAnchor.constraint(equalToConstant: contentView.bounds.width * 0.2)
        ])
        

    }
    
    func setEmoji(for subview: UILabel, leadingFor offset: UIView) {
        contentView.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.textAlignment = .center
        subview.contentMode = .center
        subview.backgroundColor = .gray
        subview.font = UIFont(name: "Helvetica", size: 40)
        subview.layer.shadowOffset = CGSize(width: 0, height:  0.5)
        subview.layer.shadowColor = UIColor.black.cgColor
        subview.layer.shadowOpacity = 0.5
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            subview.leadingAnchor.constraint(equalTo: offset.trailingAnchor, constant: 16),
            subview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            subview.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch currentTypeRounded {
        case .bezierPath:
            roundCornersBP(for: avatarLabel)
            roundCornersBP(for: avatarLabel1)
            roundCornersBP(for: avatarLabel2)
//            roundCornersBP(for: avatarLabel3)
        case .cornerRadius:
            roundedCornersCR(for: avatarLabel)
            roundedCornersCR(for: avatarLabel1)
            roundedCornersCR(for: avatarLabel2)
//            roundedCornersCR(for: avatarLabel3)
        default:
            break
        }
    }
    
//    override func prepareForReuse() {
//        roundCornersBP(cornerRadius: 20, for: avatarLabel)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

