//
//  ThirdTaskViewController.swift
//  FirstTaskWithoutStryBoard
//
//  Created by OUT-Salyukova-PA on 04.03.2021.
//

import UIKit

class ThirdTaskViewController: UIViewController, CAAnimationDelegate {

    var triangleLayer: CAShapeLayer?
    var circleLayer: CAShapeLayer?
    var lineLayer: CAShapeLayer?
    
    private var animatedLayers: [CAShapeLayer] = []
    
    var button: UIButton! {
        didSet {
            button.setTitle("Tap", for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            button.layer.cornerRadius = 20
            button.layer.shadowOffset = CGSize(width: 0, height:  0.5)
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.5

        }
    }
    
    private func startAnimation() {
        guard let lastLayer = animatedLayers.popLast() else { return }
        let firstAnimation = CABasicAnimation(keyPath: "strokeEnd")
        firstAnimation.fromValue = 0
        firstAnimation.duration = 1
        firstAnimation.delegate = self
        lastLayer.add(firstAnimation, forKey: "stroke")
        view.layer.addSublayer(lastLayer)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        button = UIButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.6),
            button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.4),
            button.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.2)
        ])
        button.addTarget(self, action: #selector(actionButton(_:)), for: .touchUpInside)
//        button.addAction(#selector(actionButton(_:)), for: .touchUpInside)
    }

    @objc func actionButton(_ sender: Any) {
        self.triangleLayer?.removeFromSuperlayer()
        self.circleLayer?.removeFromSuperlayer()
        self.lineLayer?.removeFromSuperlayer()

        
        let triangleLayer =  createShapeLayer(color: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        triangleLayer.path = drawTriangle().cgPath
        
        let circleLayer =  createShapeLayer(color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        circleLayer.path = drawCircle().cgPath

        let lineLayer = createShapeLayer(color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        lineLayer.path = drawLine().cgPath
        
        animatedLayers = [lineLayer, circleLayer, triangleLayer]
        startAnimation()
        

        self.triangleLayer = triangleLayer
        self.circleLayer = circleLayer
        self.lineLayer = lineLayer
    }
    
    func drawTriangle() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: view.bounds.midX, y: view.bounds.minY + 200))
        path.addLine(to: CGPoint(x: view.bounds.midX + 100, y: view.bounds.minY + 400))
        path.addLine(to: CGPoint(x: view.bounds.midX - 100, y: view.bounds.minY + 400))
        path.close()
        return path
    }
    
    func drawCircle() -> UIBezierPath {
        let area: Double = 200 * 200 / 2
        let perimetr = (sqrt(pow(-100, 2) + pow(-200, 2)) + sqrt(pow((200), 2) + pow((0), 2)) + sqrt(pow(-100, 2) + pow(200, 2)))
        let radius: CGFloat = CGFloat(Double((2 * area)) / perimetr)
        
        return UIBezierPath(arcCenter: CGPoint(x: view.bounds.midX, y: view.bounds.minY + 400 - radius ), radius: radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
    }
    
    func drawLine() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: view.bounds.midX, y: view.bounds.minY + 200))
        path.addLine(to: CGPoint(x: view.bounds.midX, y: view.bounds.minY + 400))
        return path
    }
    
    func createShapeLayer(color: UIColor) -> CAShapeLayer {
        let triangleLayer = CAShapeLayer()
        triangleLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        triangleLayer.strokeColor = color.cgColor
        triangleLayer.lineWidth = 4
        return triangleLayer
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard flag else { return }
        startAnimation()
    }
}
