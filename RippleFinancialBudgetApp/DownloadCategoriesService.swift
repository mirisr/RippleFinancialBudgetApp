//
//  CategoryInfo.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/10/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//


import Foundation

protocol DownloadCategoriesServiceProtocal: class {
    func itemsDownloaded(items: Array<Category>)
}


class DownloadCategoriesService: NSObject, NSURLSessionDataDelegate {
    
    //properties
    
    weak var delegate: DownloadCategoriesServiceProtocal!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "http://ripple-financial.com/getCategories.php"
    
    
    func downloadCategories() {
        
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let userID = NSUserDefaults.standardUserDefaults().objectForKey("UserID")
        
        print("USER ID STORED FROM SESSION:\(userID)")
        
        let paramString = "UserID=\(userID!)"
        
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = session.downloadTaskWithRequest(request) {
            (let location, let response, let error) in
            guard let _:NSURL = location, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            // Get Result as a string
            let urlContents = try! NSString(contentsOfURL: location!, encoding: NSUTF8StringEncoding)
            
            guard let _:NSString = urlContents else {
                print("error")
                return
            }
            
            print("URL CONTENTS: \(urlContents)")
            
            // convert String to NSData
            let data: NSData = urlContents.dataUsingEncoding(NSUTF8StringEncoding)!
            
            do {
                
                let anyObj = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSMutableArray
                
                self.parseJson(anyObj)
                
            } catch {
                print("json error: \(error)")
            }
            
            
            
        }
        
        task.resume()
        
    }
    
    func parseJson(anyObj:AnyObject) {
        
        var allCategories:Array<Category> = []
        
        if  anyObj is Array<AnyObject> {
            
            
            
            for json in anyObj as! Array<AnyObject> {
                
                var category:Category = Category()
                
                category.name = (json["CategoryName"] as AnyObject? as? String) ?? "" // to get rid of null
                
                //print("category name: \(category.name!)")
                
                let budgetAmountStr = (json["BudgetAmount"] as AnyObject? as? String) ?? ""
                
                category.budgetAmount = Double(budgetAmountStr)!
                
                let categoryID = (json["CategoryID"] as AnyObject? as? String) ?? ""
                //print ("CATEGORY ID:\(categoryID)")
                
                category.setID(categoryID)
                //print("budget amount: \(category.budgetAmount!)")
                
                allCategories.append(category)
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            self.delegate.itemsDownloaded(allCategories)
            
        })
        
    }
    
}
