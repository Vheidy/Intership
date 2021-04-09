//
//  LoadDishViewController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 08.04.2021.
//

import UIKit

class LoadDishViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var searchBar: UISearchBar
    var searchService: SearchService
    var collectionView: UICollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchService.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        searchBar = UISearchBar()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        searchService = SearchService()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }

    private func setup() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        navigationItem.title = "Search"
    }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
