//
//  GroceryItemsCollectionViewCell.swift
//  BAH_Application
//
//  Created by Hussain Bharmal on 11/19/18.
//  Copyright © 2018 BAH. All rights reserved.
//

import UIKit

class GroceryItemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var groceryItemImageView: UIImageView!
    
    // add an image to the ImageView associated with the Collection View
    func addImage(image name: String) {
        groceryItemImageView.image = UIImage(named: name)
    }
    
}
