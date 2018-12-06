//
//  ViewController.swift
//  BAH_FinalProject_V1
//
//  Created by BAH on 11/16/18.
//  Copyright © 2018 Vadrevu, Anirudh S. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var groceryLists =  [GroceryList]()
    var sugueList: GroceryList?

    @IBOutlet weak var groceryListTextField: UITextField!
    @IBOutlet weak var groceryListTableView: UITableView!
    
    @IBAction func addList(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        guard let entity = NSEntityDescription.entity(forEntityName: "GroceryList", in: managedObjectContext) else {
            fatalError("Could not load entity!")
        }
        
        let groceryList = GroceryList(entity: entity, insertInto: managedObjectContext)
        
        // add functionality to confirm text field isn't empty
        let message: String = "Please enter some text"
        if (self.groceryListTextField.text == "") {
            let alert = UIAlertController(title: "Try Again", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if self.groceryListTextField.text != "" {
            groceryList.groceryListName = groceryListTextField.text
        } else { return }
        
        do {
            try managedObjectContext.save()
            groceryLists.append(groceryList)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
//        self.groceryListTableView.beginUpdates()
//        self.groceryListTableView.insertRows(at: [IndexPath(row: 0, section: groceryLists.count - 1)], with: .automatic)
//        self.groceryListTableView.endUpdates()
        self.groceryListTableView.reloadData()
        self.groceryListTextField.text = ""
        view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "My Grocery Lists"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GroceryList")
        
        do {
            if let results = try managedObjectContext.fetch(fetchRequest) as? [GroceryList] { groceryLists = results }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? AddItemViewController {
            if let cell = sender as? UITableViewCell {
                if let indexPath = self.groceryListTableView.indexPath(for: cell) {
                    destinationViewController.groceryList = groceryLists[indexPath.section]
                }
            }
        }
        if let destinationViewController = segue.destination as? GroceryListViewController {
            if let cell = sender as? UITableViewCell {
                if let indexPath = self.groceryListTableView.indexPath(for: cell) {
                    destinationViewController.groceryList = groceryLists[indexPath.section]
                }
            }
        }
     }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groceryLists.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = groceryLists[indexPath.section].groceryListName
        
        // UI Tweaks
        cell.textLabel?.font = UIFont(name: "Gill Sans", size: 19.0)
//        cell.contentView.layer.cornerRadius = 4.0
//        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.clear.cgColor
//        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.selectionStyle = .none
        return cell
    }
    


}

