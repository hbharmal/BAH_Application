//
//  NutritionData.swift
//  BAH_Application
//
//  Created by Vadrevu, Anirudh S on 12/8/18.
//  Copyright © 2018 BAH. All rights reserved.
//
import Foundation

protocol NutritioDataProtocol {
    func responseDataHandler (data: NSDictionary)
    func responseError (message: String)
}

class NutritionData {
    private let urlSession = URLSession.shared
    private let urlPathBase = "https://www.food2fork.com/api/search?key=c3a7eca4aba7737ced391e4956685bfd&q="
    
    private var dataTask: URLSessionDataTask? = nil
    var delegate: NutritioDataProtocol? = nil

    
    func getData (foods: [Item]) {
        var urlPath = self.urlPathBase
        var list: [String] = []
        //let split = food.components(separatedBy: " ")
        // have to put all items in the grocery list into a list, then for each of those items, split them based on " ", and for the length of that list, create variables, and then put them into the url
        for item in foods {
            list.append(item.itemName!)
        }
        for thing in list {
            let split = thing.components(separatedBy: " ")
            for things in split {
                urlPath = urlPath + things + "%20"
            }
        }
        print(urlPath)
        
        var count: Int32 = 0
        let url:NSURL? = NSURL(string: urlPath)
        
        print("about to try this")
        let dataTask = self.urlSession.dataTask(with: url! as URL) { (data, response,
            error) -> Void in
            //print("DATA: ")
            //print(data)
            //print("RESPONSE:")
            //print(response)
            //print("ERROR: ")
            //print(error)
            if error != nil {
                print(error)
                print("Food not valid!")
                //print(urlPath)
            } else {
                do {
                    var jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    //print(jsonResult)
                    if jsonResult?.value(forKeyPath: "count") != nil {
                        count = (jsonResult?.value(forKeyPath: "count")! as? Int32)!
                        //print(count)
                        if count >= 5 {
                            var newResult = jsonResult?.value(forKeyPath: "recipes")!
                            for i in 1...5 {
                                var second_layer = newResult as! NSArray
                                var second_layer_dict = second_layer[i-1] as! NSDictionary
                                let name = second_layer_dict.value(forKeyPath: "title") as! String
                                //print(name)
                                let url = second_layer_dict.value(forKeyPath: "source_url") as! String
                                //print(url)
                            }
                            print("About to do this now")
                            self.delegate?.responseDataHandler(data: jsonResult!)
                        }
                        else if count > 0 {
                            var newResult = jsonResult?.value(forKeyPath: "recipes")!
                            for i in 1...count {
                                var second_layer = newResult as! NSArray
                                var second_layer_dict = second_layer[Int(i)-1] as! NSDictionary
                                let name = second_layer_dict.value(forKeyPath: "title") as! String
                                //print(name)
                                let url = second_layer_dict.value(forKeyPath: "source_url") as! String
                                //print(url)
                            }
                           self.delegate?.responseDataHandler(data: jsonResult!)
                        }
                        else {
                                print("No recipes found")
                                self.delegate?.responseDataHandler(data: jsonResult!)
                            }
                        }
                    else{
                        self.delegate?.responseError(message: "No recipes found!")
                        print("No recipes found!")
                    }
                } catch {
                    // Catch and handle the exception
                }
        }
    }
    dataTask.resume()
}
}
