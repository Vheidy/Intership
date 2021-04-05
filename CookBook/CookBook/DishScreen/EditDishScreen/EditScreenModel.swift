//
//  EditScreenModel.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 18.03.2021.
//

import Foundation
import UIKit

//struct ConstantSection {
//    let title: String
//    let placeholderArray: [String]
//}
//
//struct ConstantNamesView {
//    static let array: [ConstantSection] = [ConstantSection(title: "Image", placeholderArray: []),
//                                           ConstantSection(title: "Base Info", placeholderArray: ["Dish Name", "Dish Type"]),
//                                           ConstantSection(title: "Ingredients", placeholderArray: ["Ingredient"]),
//                                           ConstantSection(title: "Order of Action", placeholderArray: ["Action"]),
//                                           ConstantSection(title: "Extra", placeholderArray: ["Cuisine", "Calories"])
//    ]
//}

enum EditScreenItemType {
    case image
    case inputItem(placeholder: String)
    case labelItem(title: String)
}

enum EditScreenHeaderType {
    case need(title: String)
    case notNeeded
}

struct EditScreenModelSection {
    let title: String
    let needsHeader: EditScreenHeaderType
    var items: [EditScreenItemType]
}

class EditScreenModel {
    // Contains a structure of view in Edit Screen
    var array: [EditScreenModelSection] = [ EditScreenModelSection(title: "Image", needsHeader: .notNeeded, items: [.image]),
                                            EditScreenModelSection(title: "Base Info", needsHeader: .notNeeded, items: [.inputItem(placeholder: "Dish Name"), .inputItem(placeholder: "Dish Type")]),
                                            EditScreenModelSection(title: "Ingredients", needsHeader: .need(title: "Ingredients"), items: []),
                                            EditScreenModelSection(title: "Order of Action", needsHeader: .need(title: "Order of Action"), items: [.inputItem(placeholder: "Action")]),
                                            EditScreenModelSection(title: "Extra", needsHeader: .notNeeded, items: [.inputItem(placeholder: "Cuisine"), .inputItem(placeholder: "Calories")])
    ]
    
    var sectionCount: Int {
        array.count
   }
    
    // Return type of the cell
    func getRow(for indexPath: IndexPath) -> EditScreenItemType? {
        guard array.indices.contains(indexPath.section), array[indexPath.section].items.indices.contains(indexPath.row) else { return nil }
        return array[indexPath.section].items[indexPath.row]
    }
   
    
    // Add the new cell in section and return the indexPath of this cell
    func appEnd(section: Int, ingredient: IngredientModel?) -> IndexPath {
       let mySection = array[section]
       let indexPath = IndexPath(row: mySection.items.count, section: section)
       switch mySection.title {
       case "Ingredients":
        if let newIngredient = ingredient {
            array[section].items.append(.labelItem(title: newIngredient.name))
        }
       case "Order of Action":
           array[section].items.append(.inputItem(placeholder: "Action"))
       default:
           break
       }
       return indexPath
   }
    
    // Check if the cells need to be delete
    func checkDeleting(indexPath: IndexPath) -> Bool {
        guard array.indices.contains(indexPath.section), array[indexPath.section].items.indices.contains(indexPath.row)  else { return false }
       let section = array[indexPath.section]
       guard section.items.count > 1 && (section.title == "Order of Action" || section.title == "Ingredients") else { return false }
       array[indexPath.section].items.remove(at: indexPath.row)
       return true
   }
   
    // Количесто рядов в секции
    func getRowsInSectionCount(section: Int) -> Int {
        guard let mySection = getSection(section: section) else { return 0 }
      return mySection.items.count
   }
   
    // Возвращает ряды секции
   func getRowsInSection(section: Int) -> [EditScreenItemType] {
    guard let mySection = getSection(section: section) else { return [] }
    return mySection.items
   }
   
    // Возвращает название секции
    func getTitleSection(section: Int) -> String? {
        getSection(section: section)?.title
   }
    
    // Возвращает секцию
    func getSection(section: Int) -> EditScreenModelSection? {
        guard array.indices.contains(section) else { return nil }
        return array[section]
    }
    
    // FIXME: add get Image from name
//    func fetchImage(from url: URL) -> Data? {
//        do {
//            let data = try Data(contentsOf: url)
//            return data
//        } catch {
//            print(error)
//            return nil
//        }
//    }
    
    
    func getDocumentPath(with name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        var path = paths[0] as String
        path.append(name)
        return path
    }
    
    func saveImageToDocuments(image: UIImage, withName name: String){
        if let data = image.pngData() {
            let path = getDocumentPath(with: name)
            let imageFileUrl = URL(fileURLWithPath: path)
            do {
                try data.write(to: imageFileUrl)
                print("Successfully saved image at path: \(imageFileUrl)")
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }
    
}

