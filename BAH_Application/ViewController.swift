//
//  ViewController.swift
//  BAH_FinalProject_V1
//
//  Created by BAH on 11/16/18.
//  Copyright © 2018 Vadrevu, Anirudh S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let groceryItemButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapButton))
        self.navigationItem.leftBarButtonItem = groceryItemButton
        self.navigationItem.title = "Grocery List"
        // change font and size of title
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "CaviarDreams", size: 20)!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapButton() {
        print("Tapped!")
    }


}

