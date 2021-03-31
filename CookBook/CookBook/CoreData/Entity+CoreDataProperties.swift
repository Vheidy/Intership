//
//  Entity+CoreDataProperties.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 29.03.2021.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var ingredients: String?

}

extension Entity : Identifiable {

}
