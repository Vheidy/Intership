//
//  FirstTaskViewController.swift
//  fisrstTask
//
//  Created by OUT-Salyukova-PA on 01.03.2021.
//

import UIKit

class ViewWithSubviewBounds: UIView {
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
}

class FirstTaskViewController: UIViewController {
    
    @IBOutlet weak var viewB: UIView!
    @IBOutlet weak var viewD: UIView!
    @IBOutlet weak var viewC: UIView!
    @IBOutlet weak var viewE: UIView!
    
    
    @IBOutlet var viewCollection: [UIView]!
    
    @IBOutlet weak var responderChain: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        responderChain.text = "Recognizer chain: "
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touch(_:))))
        for item in self.viewCollection {
            item.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touch(_:))))
        }
    }
    
    func getSuperView(for sub: UIView) {
        var currentView: UIView = sub
        repeat {
            responderChain.text! += getChar(for: currentView)
            currentView = currentView.superview!
        } while currentView.superview != nil
        
    }
    
    @objc func touch(_ recognizer: UITapGestureRecognizer) {
        responderChain.text = "Recognizer chain: "
        switch recognizer.state {
        case .ended :
            guard let viewRecognizer = recognizer.view else {
                return
            }
            getSuperView(for: viewRecognizer)
        @unknown default:
            break
        }
    }

    private func getChar(for viewTmp: UIView) -> String {
        switch viewTmp {
        case viewB:
            return "B "
        case viewD:
            return "D "
        case viewC:
            return "C "
        case viewE:
            return "E "
        case view:
            return "A "
        default:
            return ""
        }
    }
}
