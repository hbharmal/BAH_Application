//
//  Item+CoreDataProperties.swift
//  BAH_Application
//
//  Created by Hussain Bharmal on 11/22/18.
//  Copyright © 2018 BAH. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var itemCategory: String?
    @NSManaged public var itemName: String?
    @NSManaged public var list: GroceryList?

}
