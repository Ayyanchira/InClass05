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
    public var parameterDictionary:[String:String]?
    var pid = 0;
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Photo view view did called with category \(category!) and its count as \(photoCount!)")
        self.title = category
        category = parameterDictionary?[category!]
        fetchPhoto(category: category!, pid: pid)
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBAction func nextPhotoPressed(_ sender: UIButton) {
       //previous
        if sender.tag == 1 {
            pid -= 1;
            changeButtonStatus()
        }
            
        //next
        else if sender.tag == 2{
            pid += 1
            changeButtonStatus()
        }
        
        fetchPhoto(category: category!, pid: pid)
    }
    
    func changeButtonStatus() {
        nextButton.isEnabled = true
        previousButton.isEnabled = true
        if pid>=photoCount!-1 {
            nextButton.isEnabled = false
        }
        if pid<=0{
            previousButton.isEnabled = false
        }
    }
    
    func fetchPhoto(category:String, pid:Int) -> Void {
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "19fa90a2-3bdc-3ca6-7f94-9849a9361462"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://dev.theappsdr.com/lectures/inclass_http/photos.php?category=\(category)&pid=\(pid)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
           
            if (error != nil) {
                print(error!)
            } else {
                //calling main thread
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.view.isUserInteractionEnabled = true
                    let image = UIImage(data: data!)
                    self.photoImageView.image = image
                }
            }
        })
        
        dataTask.resume()
    }

}
