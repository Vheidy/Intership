//
//  FouthTaskViewController.swift
//  fisrstTask
//
//  Created by OUT-Salyukova-PA on 03.03.2021.
//

import UIKit

class CornerRadiusView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 25
        layer.masksToBounds = true
    }
}

class RoundedRectView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let roundedRect = CAShapeLayer()
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 25)
        roundedRect.path = path.cgPath
//        layer.delegate
        layer.addSublayer(roundedRect)
    }
}


class FouthTaskViewController: UIViewController {

    
    @IBOutlet weak var yellowView: RoundedRectView!
    
    override func viewDidLoad() {
        
//        UIPreviewParameters
        super.viewDidLoad()
        yellowView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        // Do any additional setup after loading the view.
    }
    

}
