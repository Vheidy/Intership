//
//  SecondTaskViewController.swift
//  fisrstTask
//
//  Created by OUT-Salyukova-PA on 02.03.2021.
//

import UIKit


class SpinnerViewController: UIViewController {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self?.endAction(_:))))
        }
    }
    
    @objc func endAction(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            view.window?.windowLevel = .normal - 1
            spinner.stopAnimating()
            view.window?.resignKey()
        default:
            break
        }
    }
}

class SecondTaskViewController: UIViewController {
    
    
    var coveringWindow: UIWindow?
    
    func coverEverything() {
        coveringWindow = UIWindow(windowScene: view.window!.windowScene!)
        if let coveringWindow = coveringWindow {
            coveringWindow.windowLevel = view.window!.windowLevel + 1
            coveringWindow.isHidden = false
            let vc = storyboard!.instantiateViewController(withIdentifier: "RecordOverlay")
            vc.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
            coveringWindow.rootViewController = vc
            coveringWindow.makeKeyAndVisible()
        }
    }
    
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.layer.cornerRadius = 20
            button.layer.shadowOffset = CGSize(width: 0, height:  0.5)
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.5
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        coverEverything()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
