//
//  CornerTableViewController.swift
//  FirstTaskWithoutStryBoard
//
//  Created by OUT-Salyukova-PA on 09.03.2021.
//

import UIKit


class TableViewController: UITableViewController {
    
    enum ViewDraw {
        case cornerRadius
        case bezierPath
        case image
    }
    
    let currentTypeViewDraw: ViewDraw
    
    let emojiSet = ["Lion": "🦁", "Dog": "🐶", "Fox": "🦊", "Tiger": "🐯", "Frog": "🐸", "Monkey": "🐵", "Mouse": "🐹", "Pig": "🐷", "Cat": "🐱", "Panda": "🐼"]
    
    
    let animalsNames = ["Lion", "Dog", "Fox", "Tiger", "Frog", "Monkey", "Mouse", "Pig", "Cat", "Panda"]
    
    lazy var items: [String] = (0...1000).map { _ in randomEmojis }
    var randomEmojis: String { return animalsNames[Int(arc4random_uniform(UInt32(emojiSet.count)))] }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
        
        let path = UIBezierPath(roundedRect: CGRect(x: 25, y: 15, width: 40, height: 60), cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.gray.cgColor
        
        maskLayer.frame = cell.bounds
        maskLayer.path = path.cgPath
        cell.layer.mask = maskLayer
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        let description = items[indexPath.row]

        cell.textLabel?.text = emojiSet[description]
        cell.detailTextLabel?.text = description
        cell.detailTextLabel?.isHidden = false
        cell.textLabel?.backgroundColor = .gray
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 60)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 20)
        let cornerRadius: CGFloat = 20
        switch currentTypeViewDraw {
        case .cornerRadius:
            roundedCornersCR(cornerRadius: cornerRadius, for: cell)
        case .bezierPath:
           roundCornersBP(cornerRadius: cornerRadius, for: cell)
        default:
            break
        }

        cell.textLabel?.textAlignment = .center
        cell.textLabel?.contentMode = .center

        return cell
    }
    
    init(drawType: TableViewController.ViewDraw) {
        currentTypeViewDraw = drawType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
