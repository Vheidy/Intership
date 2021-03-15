//
//  CornerTableViewController.swift
//  FirstTaskWithoutStryBoard
//
//  Created by OUT-Salyukova-PA on 09.03.2021.
//

import UIKit
import GDPerformanceView


class TableViewController: UITableViewController {
    
    enum ViewDraw {
        case cornerRadius
        case bezierPath
        case image
    }
    
    
    let currentTypeViewDraw: ViewDraw
    
    let emojiSet = ["Lion": "🦁", "Dog": "🐶", "Fox": "🦊", "Tiger": "🐯", "Frog": "🐸", "Monkey": "🐵", "Mouse": "🐹", "Pig": "🐷", "Cat": "🐱", "Panda": "🐼"]
    
    
    let animalsNames = ["Lion", "Dog", "Fox", "Tiger", "Frog", "Monkey", "Mouse", "Pig", "Cat", "Panda"]
    
    lazy var items: [String] = (0...10000).map { _ in randomEmojis }
    var randomEmojis: String { return animalsNames[Int(arc4random_uniform(UInt32(emojiSet.count)))] }

    override func viewDidLoad() {
        super.viewDidLoad()
        PerformanceMonitor.shared().start()
        switch currentTypeViewDraw {
        case .image:
            tableView.register(CircleViewCell.self, forCellReuseIdentifier: "cell")
        default:
            tableView.register(CustomViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    func roundedCornersCR(cornerRadius: CGFloat, for cell: UITableViewCell) {
        cell.textLabel?.layer.cornerRadius = cornerRadius
        cell.textLabel?.clipsToBounds = true
    }
    
    
    func roundCornersBP(cornerRadius: CGFloat, for cell: UITableViewCell) {
        
        let path = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.red.cgColor
        
        maskLayer.frame = cell.bounds
        maskLayer.path = path.cgPath
        cell.textLabel!.layer.mask = maskLayer
    }
    
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "FPS: \()"
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch currentTypeViewDraw {
        
        case .cornerRadius, .bezierPath:
            let cell = CustomViewCell()
            let description = items[indexPath.row]
            
            cell.avatarLabel.text = emojiSet[description]
            cell.avatarLabel1.text = cell.avatarLabel.text
            cell.avatarLabel2.text = cell.avatarLabel.text
            cell.avatarLabel3.text = cell.avatarLabel.text
            cell.avatarLabel4.text = cell.avatarLabel.text
            cell.descriptionLabel.text = description
            cell.currentTypeRounded = currentTypeViewDraw
//            cell.layer.shouldRasterize = true
//
//                    cell.layer.rasterizationScale = UIScreen.main.scale
            return cell
        case .image:
            let cell = CircleViewCell()
            
            let description = items[indexPath.row]
            
            cell.descriptionLabel.text = description
//            cell.layer.shouldRasterize = true
//                    cell.layer.rasterizationScale = UIScreen.main.scale
            cell.imageRounded.image = UIImage(named: "circle")
            return cell
        }
    }
    
    init(drawType: TableViewController.ViewDraw) {
        currentTypeViewDraw = drawType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

