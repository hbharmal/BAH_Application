//
//  GroceryList+CoreDataProperties.swift
//  BAH_Application
//
//  Created by Vadrevu, Anirudh S on 12/8/18.
//  Copyright © 2018 BAH. All rights reserved.
//
//

import Foundation
import CoreData


extension GroceryList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryList> {
        return NSFetchRequest<GroceryList>(entityName: "GroceryList")
    }

    @NSManaged public var groceryListName: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension GroceryList {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
