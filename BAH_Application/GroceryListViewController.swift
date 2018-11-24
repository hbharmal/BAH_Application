//
//  GroceryListViewController.swift
//  BAH_Application
//
//  Created by Hussain Bharmal on 11/24/18.
//  Copyright © 2018 BAH. All rights reserved.
//

import UIKit

class GroceryListViewController: UIViewController {
    
    var groceryList: GroceryList?
    var items: [Item] = []

    @IBOutlet weak var groceryTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        groceryTitleLabel.text = groceryList?.groceryListName
        groceryTitleLabel.baselineAdjustment = .alignCenters
        
        self.navigationController?.isToolbarHidden =  false 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // fetch items for GroceryList object
        if (groceryList?.items != nil) {
            items = groceryList!.items?.allObjects as! [Item]
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
