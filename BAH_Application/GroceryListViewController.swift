//
//  GroceryListViewController.swift
//  BAH_Application
//
//  Created by Hussain Bharmal on 11/24/18.
//  Copyright © 2018 BAH. All rights reserved.
//

import UIKit

class GroceryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var groceryList: GroceryList?
    var items: [Item] = []
    var identifier = "itemCell"

    @IBOutlet weak var groceryTitleLabel: UILabel!
    @IBOutlet weak var groceryItemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        groceryTitleLabel.text = (groceryList?.groceryListName)! + " List"
        groceryTitleLabel.baselineAdjustment = .alignCenters
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear triggered")
        // fetch items for GroceryList object
        if (groceryList?.items != nil) {
            items = groceryList!.items?.allObjects as! [Item]
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.groceryItemsTableView.reloadData()
        for item in items {
            print(item.isSelected)
        }
    }
    
    // MARK: - Scroll View
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if (velocity.y > 0) {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.setToolbarHidden(true, animated: true)
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.navigationController?.setToolbarHidden(false, animated: true)
            }, completion: nil)
        }
    }
    

     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? AddItemViewController {
            destinationController.groceryList = self.groceryList
        }
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.groceryItemsTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! GroceryItemTableViewCell
        cell.groceryItemLabel.text = items[indexPath.row].itemName
        cell.selectionStyle = .none
        cell.checkItemButton.isSelected = items[indexPath.row].isSelected
        cell.checkItemButton.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    
    
    // MARK: - Objc function
    @objc func checkMarkButtonClicked(sender: UIButton) {
        if (sender.isSelected) {
            sender.isSelected = false
            if let cell = sender.superview?.superview as? UITableViewCell {
                if let indexPath = self.groceryItemsTableView.indexPath(for: cell) {
                    items[indexPath.row].isSelected = false
                }
            }
        } else {
            if let cell = sender.superview?.superview as? UITableViewCell {
                if let indexPath = self.groceryItemsTableView.indexPath(for: cell) {
                    items[indexPath.row].isSelected = true
                }
            }
            sender.isSelected = true
        }
    }

}
