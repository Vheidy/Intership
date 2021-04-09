//
//  SearchService.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 09.04.2021.
//

import Foundation

protocol SearchProtocol {
    var numberOfItems: Int { get }
    func searchFor(word: String, completion: VoidCallback?)
}

class SearchService {
    var recipeStore: [Recipe]
    var newtworkService: RecipeProvider
    
    var numberOfItems: Int {
        recipeStore.count
    }
    
    init() {
        recipeStore = []
        newtworkService = NetworkService()
        searchFor(word: "lunch", completion: nil)
    }
    
    func searchFor(word: String, completion: VoidCallback?) {
        newtworkService.fetchRecipe(query: word) {
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let response):
                self.updateStore(with: response)
                completion?()
            }
        }
    }
    
    private func updateStore(with response: ResponseModel) {
        recipeStore = response.hits.map( { $0.recipe })
    }
    
}
