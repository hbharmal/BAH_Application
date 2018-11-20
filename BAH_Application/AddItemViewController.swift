//
//  AddItemViewController.swift
//  BAH_Application
//
//  Created by Bharmal, Hussain A on 11/19/18.
//  Copyright © 2018 BAH. All rights reserved.
//

import UIKit
import Foundation

class AddItemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var images: [String] = []
    var cellIdentifier = "Cell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        
        print(images)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GroceryImagesCollectionViewCell
        let image = images[indexPath.row]
        cell.addImage(image: image)
        return cell 
    }

}
