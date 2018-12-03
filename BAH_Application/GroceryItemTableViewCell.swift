//
//  GroceryItemTableViewCell.swift
//  BAH_Application
//
//  Created by Hussain Bharmal on 12/2/18.
//  Copyright © 2018 BAH. All rights reserved.
//

import UIKit

class GroceryItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var groceryItemLabel: UILabel!
    @IBOutlet weak var checkItemButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
