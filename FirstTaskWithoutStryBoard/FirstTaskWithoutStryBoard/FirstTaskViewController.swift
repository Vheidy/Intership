//
//  FirstTaskViewController.swift
//  FirstTaskWithoutStryBoard
//
//  Created by OUT-Salyukova-PA on 04.03.2021.
//

import UIKit

protocol ProtocolViewDelegate: AnyObject {
    
//    func assignNewValue(viewName: String)
    var currentTypeView: TypeView {get set}
    
    func getCurrentView(currentView: UIView) -> TypeView
}

 enum TypeView: String {
    case a = "A "
    case b = "B "
    case c = "C "
    case d = "D "
    case e = "E "
    case none
}

class ViewWithSubviewBounds: UIView {
    
     var delegate: ProtocolViewDelegate?
    
    override func point(inside point: CGPoint,
                        with event: UIEvent?) -> Bool
    {
        let inside = super.point(inside: point, with: event)
        if !inside {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return inside
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let resultView = super.hitTest(point, with: event)
        if let _ = resultView {
            let type = delegate?.getCurrentView(currentView: self) ?? .none
            delegate?.currentTypeView = type
//            delegate?.assignNewValue(viewName: type.rawValue)
        }
        return resultView
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        let type = delegate?.getCurrentView(currentView: self) ?? .none
//        delegate?.currentTypeView = type
//    }
    
}

class FirstTaskViewController: UIViewController, ProtocolViewDelegate {
    func assignNewValue(viewName: String) {
        responderChain.text = viewName
    }
    

    var viewB: ViewWithSubviewBounds = ViewWithSubviewBounds()
    var viewC: ViewWithSubviewBounds = ViewWithSubviewBounds()
    var viewD: ViewWithSubviewBounds = ViewWithSubviewBounds()
    var viewE: ViewWithSubviewBounds = ViewWithSubviewBounds()
    
    var viewA = ViewWithSubviewBounds()

    
    
    var responderChain =  UILabel()
    
    var labelB = UILabel()
    var labelD = UILabel()
    var labelC = UILabel()
    var labelE = UILabel()
    var labelA = UILabel()
    
    var currentTypeView: TypeView = .none {
        didSet {
            if currentTypeView != .none, var text = responderChain.text {
                text += currentTypeView.rawValue
                responderChain.text = text
                
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view = viewA
        viewA.bounds = UIScreen.main.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewA.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        setView()
        setLabel()
    }
    
    
//    private func addGestureForAllViews(superView: UIView) {
//        superView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touch(_ :))))
//        for subview in superView.subviews {
//            if getCurrentView(currentView: subview) != .none {
//                addGestureForAllViews(superView: subview)
//            }
//        }
//    }
//
    func getCurrentView(currentView: UIView) -> TypeView {
        switch currentView {
        case viewE:
            return .e
        case viewD:
            return .d
        case viewB:
            return .b
        case viewC:
            return .c
        case viewA:
            return .a
        default:
            return .none
        }
    }
    
    private func setLabel() {
        createLabelParameters(for: labelA, in: viewA, text: "A", fontSize: 30, constraints: [
            labelA.trailingAnchor.constraint(equalTo: viewA.trailingAnchor, constant: -40),
            labelA.topAnchor.constraint(equalTo: viewA.topAnchor, constant: 40)
        ])
        createLabelParameters(for: labelB, in: viewB, text: "B", fontSize: 30, constraints: [
            labelB.topAnchor.constraint(equalTo: viewB.topAnchor, constant: 10),
            labelB.trailingAnchor.constraint(equalTo: viewB.trailingAnchor, constant: -10)
        ])
        createLabelParameters(for: labelC, in: viewC, text: "C", fontSize: 30, constraints: [
            labelC.topAnchor.constraint(equalTo: viewC.topAnchor, constant: 10),
            labelC.trailingAnchor.constraint(equalTo: viewC.trailingAnchor, constant: -10)
        ])
        createLabelParameters(for: labelD, in: viewD, text: "D", fontSize: 30, constraints: [
            labelD.topAnchor.constraint(equalTo: viewD.topAnchor, constant: 10),
            labelD.trailingAnchor.constraint(equalTo: viewD.trailingAnchor, constant: -10)
        ])
        createLabelParameters(for: labelE, in: viewE, text: "E", fontSize: 30, constraints: [
            labelE.topAnchor.constraint(equalTo: viewE.topAnchor, constant: 10),
            labelE.trailingAnchor.constraint(equalTo: viewE.trailingAnchor, constant: -10)
        ])
        createLabelParameters(for: responderChain, in: viewA, text: "Responder Chain: ", fontSize: 20, constraints: [
            responderChain.bottomAnchor.constraint(equalTo: viewA.bottomAnchor, constant: -70
            ),
            responderChain.leadingAnchor.constraint(equalTo: viewA.leadingAnchor, constant: viewA.bounds.width * 0.05),
            responderChain.widthAnchor.constraint(equalToConstant: viewA.bounds.width * 0.8),
            responderChain.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setParametersView(for currentView: ViewWithSubviewBounds) {
        currentView.delegate = self
        currentView.layer.cornerRadius = 20
        currentView.layer.shadowOffset = CGSize(width: 0, height:  0.5)
        currentView.layer.shadowColor = UIColor.black.cgColor
        currentView.layer.shadowOpacity = 0.5
    }
    
    private func setView() {
        setParametersView(for: viewB)
        setParametersView(for: viewA)
        setParametersView(for: viewC)
        setParametersView(for: viewD)
        setParametersView(for: viewE)

        viewA.delegate = self
        createView(for: viewB, in: viewA, color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), constraints: [
            viewB.centerXAnchor.constraint(equalTo: viewA.centerXAnchor),
            viewB.topAnchor.constraint(equalTo: viewA.topAnchor, constant: viewA.bounds.height * 0.1),
            viewB.widthAnchor.constraint(equalToConstant: viewA.bounds.width * 0.60 ),
            viewB.heightAnchor.constraint(equalToConstant: viewA.bounds.height * 0.25)
        ])
        
        createView(for: viewD, in: viewB, color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), constraints: [
            viewD.leadingAnchor.constraint(equalTo: viewB.leadingAnchor, constant: viewB.bounds.width * 0.1),
            viewD.topAnchor.constraint(equalTo: viewB.topAnchor, constant: viewB.bounds.height * 0.6),
            viewD.widthAnchor.constraint(equalToConstant:  viewB.bounds.width * 0.4),
            viewD.heightAnchor.constraint(equalToConstant: viewB.bounds.height * 0.3)
        ])

        createView(for: viewC, in: viewA, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), constraints: [
            viewC.centerXAnchor.constraint(equalTo: viewA.centerXAnchor),
            viewC.topAnchor.constraint(equalTo: viewB.topAnchor, constant: viewA.bounds.height * 0.25 + viewA.bounds.height * 0.15),
            viewC.widthAnchor.constraint(equalToConstant: viewA.bounds.width * 0.60 ),
            viewC.heightAnchor.constraint(equalToConstant: viewA.bounds.height * 0.25)
        ])
        createView(for: viewE, in: viewC, color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), constraints: [
            viewE.centerXAnchor.constraint(equalTo: viewC.centerXAnchor),
            viewE.topAnchor.constraint(equalTo: viewC.topAnchor, constant: viewC.bounds.height * 0.70),
            viewE.widthAnchor.constraint(equalToConstant:  viewA.bounds.width * 0.50),
            viewE.heightAnchor.constraint(equalToConstant: viewA.bounds.height * 0.15)
        ])
    }
    
    
    private func createLabelParameters(for label: UILabel, in superView: UIView, text: String, fontSize: CGFloat, constraints: [NSLayoutConstraint]) {
        label.text = text
        label.font = UIFont(name: "Helvetica", size: fontSize)
        createView(for: label, in: superView, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), constraints: constraints)
    }
    
    private func createView(for subView: UIView, in superView: UIView, color: UIColor, constraints: [NSLayoutConstraint]) {
        superView.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = color
        NSLayoutConstraint.activate(constraints)
        viewA.layoutIfNeeded()
    }

}
