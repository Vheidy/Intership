//
//  SearchService.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 09.04.2021.
//

import Foundation
import UIKit

struct CollectionViewItem {
    var label: String
    var image: UIImage
}

protocol SearchProtocol {
    var numberOfItems: Int { get }
    func searchFor(word: String, errorHandler: ((String) -> ())?, completion: VoidCallback?)
    func fetchItem(for indexPath: IndexPath) -> CollectionViewItem?
}

class SearchService: SearchProtocol {

    var recipeStore: [Recipe]
//        [Recipe(label: "Dinner Tonight: Chipped Beef Gravy",
//                                        image: "https://www.edamam.com/web-img/8eb/8eb4bcfbe8c89c21fcaecdc4e7ac6da5.jpg",
//                                        url: "http://www.seriouseats.com/recipes/2010/02/chipped-beef-gravy-on-toast-stew-on-a-shingle-recipe.html"),
//                                 Recipe(label: "Crispy Potato Mojos recipes",
//                                        image: "https://www.edamam.com/web-img/77a/77a79534149036235152fa0c40ecf02b",
//                                        url: "http://pinchofyum.com/crispy-potato-mojos"),
//                                 Recipe(label: "Dinner Tonight: Chipped Beef Gravy",
//                                                                     image: "https://www.edamam.com/web-img/8eb/8eb4bcfbe8c89c21fcaecdc4e7ac6da5.jpg",
//                                                                     url: "http://www.seriouseats.com/recipes/2010/02/chipped-beef-gravy-on-toast-stew-on-a-shingle-recipe.html"),
//                                 Recipe(label: "Crispy Potato Mojos recipes",
//                                        image: "https://www.edamam.com/web-img/77a/77a79534149036235152fa0c40ecf02b",
//                                        url: "http://pinchofyum.com/crispy-potato-mojos"),
//    ]
    var newtworkService: RecipeProvider
    
    var numberOfItems: Int {
        recipeStore.count
    }
    
    init() {
        recipeStore = []
        newtworkService = NetworkService()
//        searchFor(word: "lunch", errorHandler: nil, completion: nil)
    }
    
    func fetchItem(for indexPath: IndexPath) -> CollectionViewItem? {
        guard recipeStore.indices.contains(indexPath.row)else {
            return nil
        }
        let recipe = recipeStore[indexPath.row]
        guard let standartImage = UIImage(named: "breakfast") else {
            return nil
        }
        let image = self.fetchImage(from: recipe.image) ?? standartImage
        return CollectionViewItem(label: recipe.label, image: image)
    }
    
    private func fetchImage(from urlString: String) -> UIImage? {
        do {
            guard let url = URL(string: urlString) else { return nil }
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    func searchFor(word: String, errorHandler: ((String) -> ())?, completion: VoidCallback?) {
        newtworkService.fetchRecipe(query: word) {
            switch $0 {
            case .failure(let error):
                let errorDescription: String
                switch error {
                case .internalError:
                    errorDescription = "Invalid input"
                case .serverError:
                    errorDescription = "Server error"
                case .parsingError:
                    errorDescription = "Parsing error"
                }
                DispatchQueue.main.async {
                    errorHandler?(errorDescription)
                }
            case .success(let response):
                if response.hits.count > 0 {
                    self.updateStore(with: response)
                    DispatchQueue.main.async {
                        completion?()
                    }
                } else {
                    DispatchQueue.main.async {
                        errorHandler?("No results found")
                    }
                }
            }
        }
    }

    
    private func updateStore(with response: ResponseModel) {
        recipeStore = response.hits.map( { $0.recipe })
    }
    
}
