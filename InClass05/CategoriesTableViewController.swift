//
//  CategoriesTableViewController.swift
//  InClass05
//
//  Created by Ayyanchira, Akshay Murari on 10/5/17.
//  Copyright © 2017 Ayyanchira, Akshay Murari. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    var categories:[String:String] = ["Animals":"animals",
    "News":"news",
    "Entertainment":"entertainment",
    "Food and Drink":"food",
    "Cars":"car"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        var keyValues = [String](categories.keys)
        cell.textLabel?.text = keyValues[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath),
            let categoryKey = cell.textLabel?.text{
            let category = categories[categoryKey]
            getImageCountFor(category: category!)
        }

    }
    
    //network call method
    func getImageCountFor(category:String) -> Int {
        var count = 0
        //Implementing URLSession
       
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "5a1fb91b-9f81-6513-c96c-600945c11525"
        ]
        
        var request = NSMutableURLRequest(url: NSURL(string: "http://dev.theappsdr.com/lectures/inclass_http/photos.php?count=get&category=\(category)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
                print(datastring)
                
                //calling main thread
                DispatchQueue.main.async {
                    self.loadPhotoView(withCategory: category, andCount:Int(datastring.intValue))
                }
                
            }
        })
        
        dataTask.resume()
        
        //End implementing URLSession
        return count
    }
    
    func loadPhotoView(withCategory category:String, andCount:Int){
        var titleNextPage = findKeyForValue(value: category, dictionary: categories)
        
        var catergoryDict = ["category":titleNextPage,
                             "count":andCount] as [String : Any]
        performSegue(withIdentifier: "photoView", sender: catergoryDict)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare for segue called")
        var catergoryDict = sender as! [String : Any]
        let photoVieController = segue.destination as! PhotoViewController
        photoVieController.category = catergoryDict["category"] as? String
        photoVieController.photoCount = catergoryDict["count"] as? Int
    }
    
    func findKeyForValue(value: String, dictionary: [String: String]) ->String?
    {
        for (key, array) in dictionary
        {
            if (array.contains(value))
            {
                return key
            }
        }
        
        return nil
    }
}


