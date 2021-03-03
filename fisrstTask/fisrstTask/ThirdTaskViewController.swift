//
//  ThirdTaskViewController.swift
//  fisrstTask
//
//  Created by OUT-Salyukova-PA on 02.03.2021.
//

import UIKit

class DrawnView: UIView {
    override func draw(_ rect: CGRect) {
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: bounds.midX, y: bounds.minY + 200))
        path1.addLine(to: CGPoint(x: bounds.midX + 100, y: bounds.minY + 400))
        path1.addLine(to: CGPoint(x: bounds.midX - 100, y: bounds.minY + 400))
        path1.close()
        
        
        let area: Double = 200 * 200 / 2
        let perimetr = (sqrt(pow(-100, 2) + pow(-200, 2)) + sqrt(pow((200), 2) + pow((0), 2)) + sqrt(pow(-100, 2) + pow(200, 2)))
        let radius: CGFloat = CGFloat(Double((2 * area)) / perimetr)
        
        let path2 = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.minY + 200 + 200 - radius ), radius: radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: bounds.midX, y: bounds.minY + 200))
        path3.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY + 400))
        
        
        let triangleLayer = CAShapeLayer()
        triangleLayer.path = path1.cgPath
        path1.lineWidth = 3
        UIColor.blue.setStroke()
        path1.stroke()
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = path2.cgPath
        path2.lineWidth = 3
        UIColor.systemBlue.setStroke()
        path2.stroke()
        
        let linelayer = CAShapeLayer()
        linelayer.path = path3.cgPath
        path3.lineWidth = 3
        UIColor.white.setStroke()
        path3.stroke()
    }
}

class ThirdTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
