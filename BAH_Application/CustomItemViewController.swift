//
//  CustomItemViewController.swift
//  BAH_Application
//
//  Created by Hussain Bharmal on 11/22/18.
//  Copyright © 2018 BAH. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CustomItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var groceryList: GroceryList?
    var selectedCatagory: String?
    var categories = Globals.categories
    var shouldPerform: Bool = false
    
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addCustomItemButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBAction func addItemAction(_ sender: Any) {
        let message: String = "Please enter some text"
        if (self.nameTextField.text == "") {
            let alert = UIAlertController(title: "Try Again", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            shouldPerform = true
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext
            guard let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedObjectContext) else {
                fatalError("Could not load entity!")
            }
            
            // make new item object
            let item = Item(entity: entity, insertInto: managedObjectContext)
            item.itemCategory = self.selectedCatagory
            item.itemName = self.nameTextField.text
            item.list = self.groceryList
            item.isSelected = false
            
            groceryList?.addToItems(item)
            
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.categoriesPickerView.layer.borderColor = UIColor.black.cgColor
        self.categoriesPickerView.layer.borderWidth = 2
        self.categoriesPickerView.layer.cornerRadius = 15
        
        self.nameTextField.layer.borderColor = UIColor.black.cgColor
        self.nameTextField.layer.borderWidth = 2
        self.nameTextField.layer.cornerRadius = 15
        
        self.categoryLabel.layer.cornerRadius = 15
        self.nameLabel.layer.cornerRadius = 15
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destinationViewController = segue.destination as? AddItemViewController {
//            destinationViewController.groceryList = self.groceryList
//        }
        print("YES")
    }

    
    // MARK: - UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.view(forRow: row, forComponent: component)?.backgroundColor = UIColor.lightGray
        selectedCatagory = categories[row]
    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.rowSize(forComponent: component).width, height: pickerView.rowSize(forComponent: component).height))
//        label.textAlignment = .center
//        label.text = categories[row]
//        view.addSubview(label)
//        return view
//    }

}
