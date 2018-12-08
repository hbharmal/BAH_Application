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
    let identifier = "itemCell"
    let cellSpacingHeight: CGFloat = 5

    @IBOutlet weak var groceryTitleLabel: UILabel!
    @IBOutlet weak var groceryItemsTableView: UITableView!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        groceryTitleLabel.text = (groceryList?.groceryListName)! + " List"
        groceryTitleLabel.baselineAdjustment = .alignCenters
        
        self.createNutritionLabels()
        
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
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.groceryItemsTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! GroceryItemTableViewCell
        
        // UI tweeks
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        cell.groceryItemLabel.text = items[indexPath.section].itemName
        cell.selectionStyle = .none
        cell.checkItemButton.isSelected = items[indexPath.section].isSelected
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
                    items[indexPath.section].isSelected = false
                }
            }
        } else {
            if let cell = sender.superview?.superview as? UITableViewCell {
                if let indexPath = self.groceryItemsTableView.indexPath(for: cell) {
                    items[indexPath.section].isSelected = true
                }
            }
            sender.isSelected = true
        }
    }
    
    // MARK: - Nutrition Labels
    func createNutritionLabels() {
        self.proteinLabel.backgroundColor = UIColor.blue
        self.carbsLabel.backgroundColor = UIColor.green
        self.fatLabel.backgroundColor = UIColor.red
        
        var carbs: Float = 0
        var fat: Float = 0
        var protein: Float = 0
        for item in items {
            carbs += item.gramsCarbs
            fat += item.gramsFat
            protein += item.gramsProtein
        }
        // first check if item list is empty
        if (items.count == 0 || items == nil) {
            self.proteinLabel.text =  " \(protein) G Protein"
            self.carbsLabel.text =  " \(carbs) G Carbs"
            self.fatLabel.text = " \(fat) G Fat"
        } else {
            self.proteinLabel.text =  " \(protein) G Protein"
            self.carbsLabel.text = " \(carbs) G Carbs"
            self.fatLabel.text = " \(fat) G Fat"
        }
        
    }

}
