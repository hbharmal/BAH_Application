//
//  Item+CoreDataProperties.swift
//  BAH_Application
//
//  Created by Vadrevu, Anirudh S on 12/8/18.
//  Copyright © 2018 BAH. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var isSelected: Bool
    @NSManaged public var itemCategory: String?
    @NSManaged public var itemName: String?
    @NSManaged public var gramsProtein: Float
    @NSManaged public var gramsCarbs: Float
    @NSManaged public var gramsFat: Float
    @NSManaged public var list: GroceryList?

}
