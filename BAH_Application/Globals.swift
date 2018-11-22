//
//  categories.swift
//  BAH_Application
//
//  Created by Hussain Bharmal on 11/22/18.
//  Copyright © 2018 BAH. All rights reserved.
//

class Globals {
    static var categories: [String] = ["Dairy", "Beverages", "Bread/Bakery", "Baking Goods", "Meat", "Fruits", "Vegetables", "Other"]
    
    static func getCategories() -> [String] {
        return categories
    }
}
