//
//  NutritionData.swift
//  BAH_Application
//
//  Created by Vadrevu, Anirudh S on 12/8/18.
//  Copyright © 2018 BAH. All rights reserved.
//
import UIKit
import Foundation

protocol NutritioDataProtocol {
    func responseDataHandler (data: NSDictionary)
    func responseError (message: String)
}

class NutritionData {
    private let urlSession = URLSession.shared
    private let urlPathBase = "https://api.edamam.com/api/nutrition-data?app_id=9e55fd5e&app_key=68ea629e8ec61c91c87db794927623fd&ingr=one"
    
    private var dataTask: URLSessionDataTask? = nil
    var delegate: NutritioDataProtocol? = nil
    
    var BoolFat: Bool = false
    var BoolCarbs: Bool = false
    var BoolProtein: Bool = false
    
    func getData (food: String) {
        var urlPath = self.urlPathBase
        urlPath = urlPath + " " + food
        print(urlPath)
        let url:NSURL? = NSURL (string: urlPath)
        
        let dataTask = self.urlSession.dataTask(with: url! as URL) { (data, response,
            error) -> Void in
            if error != nil {
                print("Food not valid!")
                print(urlPath)
            } else {
                do {
                    var jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    if jsonResult?.value(forKeyPath: "data.FAT") != nil {
                        var newResult = jsonResult?.value(forKeyPath: "data.FAT")!
                        var second_layer = newResult as! NSArray
                        var second_layer_dict = second_layer[0] as! NSDictionary
                        let Fat = second_layer_dict.value(forKeyPath: "quantity") as! String
                        self.BoolFat = true
                        print(Fat)
                    }

                    if jsonResult?.value(forKeyPath: "data.PROCNT") != nil {
                        var newResult = jsonResult?.value(forKeyPath: "data.PROCNT")!
                        var second_layer = newResult as! NSArray
                        var second_layer_dict = second_layer[0] as! NSDictionary
                        let Protein = second_layer_dict.value(forKeyPath: "quantity") as! String
                        self.BoolProtein = true
                        print(Protein)
                    }

                    if jsonResult?.value(forKeyPath: "data.CHOCDF") != nil {
                        var newResult = jsonResult?.value(forKeyPath: "data.CHOCDF")
                        var second_layer = newResult as! NSArray
                        var second_layer_dict = second_layer[0] as! NSDictionary
                        let Carbs = second_layer_dict.value(forKeyPath: "quantity") as! String
                        self.BoolCarbs = true
                        print(Carbs)
                    }
                    if self.BoolCarbs == true && self.BoolProtein == true && self.BoolFat == true {
                        self.delegate?.responseDataHandler(data: jsonResult!)
                    }
                    else{
                        self.delegate?.responseError(message: "Nurtional information not found!")
                        print("Nutritional information not found!")
                    }
                } catch {
                    // Catch and handle the exception
                }
        }
    }
        dataTask.resume()
}
}
