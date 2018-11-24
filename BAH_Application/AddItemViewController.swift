//
//  AddItemViewController.swift
//  BAH_Application
//
//  Created by Bharmal, Hussain A on 11/19/18.
//  Copyright © 2018 BAH. All rights reserved.
//

import UIKit
import Foundation

class AddItemViewController: UIViewController, UICollectionViewDelegate ,UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groceryTitleLabel: UILabel!
    
    var images: [String] = []
    var groceryList: GroceryList?
    var collectionCellIdentifier = "Cell"
    
    var items: [Item] = []
    var tableCellIdentifier = "TableCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // add title to main screen
        groceryTitleLabel.text = groceryList?.groceryListName
        
        // fetch list of grocery images names and add to images array
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent("GroceryImages.bundle")
        let contents = try! fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
        
        for item in contents {
            let imageNamePre: String = item.lastPathComponent
            let imageName = imageNamePre.prefix(imageNamePre.count - 4)
            images.append(String(imageName))
        }
        
        // style the button
        customButton.layer.borderWidth = 1
        customButton.layer.borderColor = UIColor.black.cgColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // fetch items for GroceryList object
        if (groceryList?.items != nil) {
            items = groceryList!.items?.allObjects as! [Item]
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? CustomItemViewController {
            destinationViewController.groceryList = self.groceryList
        }
    }
    
    // MARK: - CollectionView Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as! GroceryImagesCollectionViewCell
        let image = images[indexPath.row]
        cell.addImage(image: image)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 10
        cell.isSelected = false
        return cell 
    }
    
    // add spacing between cells in collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath)
        cell.textLabel?.text = items[indexPath.row].itemName
        return cell
    }
    
    // header on the table view with current items on list 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        label.backgroundColor = UIColor.lightGray
        label.textAlignment = .center
        label.text = "Items in List"
        view.addSubview(label)
        label.center = view.center
        return view
    }

}
