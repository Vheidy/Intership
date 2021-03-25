//
//  IngredientModel.swift
//  CookBook
//
//  Created by Полина Салюкова on 23.03.2021.
//

import Foundation



class IngredientModel {
    var array: [EditScreenModelSection] = [EditScreenModelSection(title: "Name", needsHeader: .notNeeded, items: [.inputItem(placeholder: "Name")])]
    
    func getSectionCount() -> Int {
        array.count
   }
   
    func getRowsInSectionCount(section: Int) -> Int {
        guard let mySection = getSection(section: section) else { return 0 }
      return mySection.items.count
   }
   
   func getRowsInSection(section: Int) -> [EditScreenItemType] {
    guard let mySection = getSection(section: section) else { return [] }
    return mySection.items
   }
//   
//    func getTitleSection(section: Int) -> String? {
//        getSection(section: section)?.title
//   }
    
    func getSection(section: Int) -> EditScreenModelSection? {
        guard array.indices.contains(section) else { return nil }
        return array[section]
    }
}
