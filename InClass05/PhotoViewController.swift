//
//  PhotoViewController.swift
//  InClass05
//
//  Created by Ayyanchira, Akshay Murari on 10/5/17.
//  Copyright © 2017 Ayyanchira, Akshay Murari. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    public var photoCount:Int?
    public var category:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Photo view view did called with category \(category!) and its count as \(photoCount!)")
        self.title = category
        // Do any additional setup after loading the view.
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

}
