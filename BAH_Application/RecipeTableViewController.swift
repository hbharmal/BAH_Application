//
//  RecipeTableViewController.swift
//  BAH_Application
//
//  Created by Bharmal, Hussain A on 12/9/18.
//  Copyright © 2018 BAH. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController, NutritioDataProtocol {
    
    var titles: [String] = []
    var urls: [String] = []
    var nutritionData = NutritionData()
    var items: [Item] = []
    var count: Int32 = 0

    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nutritionData.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.nutritionData.getData(foods: self.items)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.myTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections'
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count 
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = urls[indexPath.row]

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: urls[indexPath.row]) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - API Functionality
    
    func responseDataHandler(data: NSDictionary) {
        titles.removeAll()
        urls.removeAll()
        self.count = (data.value(forKeyPath: "count")! as? Int32)!
        if self.count >= 5 {
            let newResult = data.value(forKeyPath: "recipes")!
            for i in 1...5 {
                let second_layer = newResult as! NSArray
                let second_layer_dict = second_layer[i-1] as! NSDictionary
                let name = second_layer_dict.value(forKeyPath: "title") as! String
                self.titles.append(name)
                let url = second_layer_dict.value(forKeyPath: "source_url") as! String
                self.urls.append(url)
            }
        }
        else if self.self.count > 0 {
            let newResult = data.value(forKeyPath: "recipes")!
            for i in 1...self.count {
                let second_layer = newResult as! NSArray
                let second_layer_dict = second_layer[Int(i)-1] as! NSDictionary
                let name = second_layer_dict.value(forKeyPath: "title") as! String
                self.titles.append(name)
                let url = second_layer_dict.value(forKeyPath: "source_url") as! String
                self.urls.append(url)
            }
        }
        else {
            self.titles.append("No recipes can be found.")
            self.urls.append("Please enter a different list of ingredients and try again, or feel free to make something of your own!")
        }
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
    }
    
    
    func responseError(message: String) {
        DispatchQueue.main.async {
            print("Error")
        }
    }


}
