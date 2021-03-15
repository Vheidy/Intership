//
//  SecondTaskViewController.swift
//  FirstTaskWithoutStryBoard
//
//  Created by OUT-Salyukova-PA on 04.03.2021.
//

import UIKit


class SpinnerViewController: UIViewController {
    
    enum StrategyType {
        case window
        case present
        case child
    }
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupSpinner()
        spinner.startAnimating()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endAction(_:))))
        view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.view.isUserInteractionEnabled = true
        }
    }
    
    private func setupSpinner() {
//        spinner =
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func endAction(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            view.window?.windowLevel = .normal - 1
            spinner.stopAnimating()
            view.window?.resignKey()
            
            dismiss(animated: true, completion: nil)
            
            removeFromParent()
            view.removeFromSuperview()
        default:
            break
        }
    }
}

class SecondTaskViewController: UIViewController {

    var coveringWindow: UIWindow?
    
    private func coverEverything() {
        coveringWindow = UIWindow(windowScene: view.window!.windowScene!)
        guard let coveringWindow = coveringWindow else { return }
        coveringWindow.windowLevel = view.window!.windowLevel + 1
        coveringWindow.isHidden = false
        let vc = SpinnerViewController()
        coveringWindow.rootViewController = vc
        coveringWindow.makeKeyAndVisible()
        vc.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    private func presentSpinner() {
        let vc = SpinnerViewController()
        vc.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
        
    }
    
    
    private func loadContent() {
        let loadingVC = SpinnerViewController()
        addChild(loadingVC)
        
        view.addSubview(loadingVC.view)
        
        loadingVC.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        loadingVC.didMove(toParent: self)
    }
    
    var button: UIButton! {
        didSet {
            button.setTitle("Click on me", for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            button.layer.cornerRadius = 20
            button.layer.shadowOffset = CGSize(width: 0, height:  0.5)
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.5
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        setButton()
    }
    
    private func setButton() {
        button = UIButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.6),
            button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.5),
            button.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.15)
        ])
        button.addTarget(self, action: #selector(actionButton(_:)), for: .touchUpInside)
    }
    
    @objc func actionButton(_ sender: UIButton) {
        coverEverything()
//        presentSpinner()
//        loadContent()
    }
    
}
