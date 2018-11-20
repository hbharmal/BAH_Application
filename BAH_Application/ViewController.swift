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
        self.navigationItem.title = "My Grocery Lists"
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapButton() {
        print("Tapped!")
    }


}

