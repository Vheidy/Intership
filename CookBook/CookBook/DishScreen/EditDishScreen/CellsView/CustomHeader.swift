//
//  CustomHeader.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 18.03.2021.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    var title: UILabel?
    var addButton: UIButton?
    var section: Int?
    var mainSubView: UIView?
    
    var action: ((Int) -> ())?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureContent()
    }
    
    private func configureContent() {
        let mainSubView = UIView()
        
        let title = UILabel()
        let addButton = UIButton()
        
        mainSubView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = .clear
        mainSubView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        contentView.addSubview(mainSubView)
        mainSubView.addSubview(title)
        mainSubView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            mainSubView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            mainSubView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainSubView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainSubView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        title.font = UIFont(name: "Verdana", size: 20)
        title.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: mainSubView.topAnchor, constant: Constants.margin),
            title.leadingAnchor.constraint(equalTo: mainSubView.leadingAnchor, constant: Constants.margin),
            title.bottomAnchor.constraint(equalTo: mainSubView.bottomAnchor),
            
            addButton.topAnchor.constraint(equalTo: mainSubView.topAnchor, constant: Constants.margin),
            addButton.bottomAnchor.constraint(equalTo: mainSubView.bottomAnchor),
            addButton.trailingAnchor.constraint(equalTo: mainSubView.trailingAnchor, constant: -Constants.margin),
            addButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        self.title = title
        self.addButton = addButton
    }
    
    @objc func didTap() {
        action?(self.section ?? 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
