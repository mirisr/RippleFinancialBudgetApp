//
//  EditCategoriesService.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/13/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//


import Foundation

protocol EditCategoriesProtocal: class {
    func editedCategories()
}


class EditCategoriesService: NSObject, NSURLSessionDataDelegate {
    
    //properties
    
    weak var delegate: EditCategoriesProtocal!
    
    var data : NSMutableData = NSMutableData()
    
    let updateUrlPath: String = "http://ripple-financial.com/updateCategory.php"
    let deleteUrlPath: String = "http://ripple-financial.com/deleteCategory.php"
    
    func DeleteCategory(categoryID: String) {
        
        let url = NSURL(string: deleteUrlPath)
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let userID = NSUserDefaults.standardUserDefaults().objectForKey("UserID")
        
        let paramString = "userID=\(userID!)&categoryID=\(categoryID)"
        
        print("Params String:\(paramString)")
        
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
            
            print("Deleting Category -- URL CONTENTS: \(urlContents)")
            
            // convert String to NSData
            let data: NSData = urlContents.dataUsingEncoding(NSUTF8StringEncoding)!
            
            do {
                
                let anyObj = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
                let status = (anyObj["status"] as AnyObject? as? String) ?? "" // to get rid of null

                //let message = (anyObj["message"] as AnyObject? as? String) ?? "" // to get rid of null
               
                
                print(status)

                
            } catch {
                print("json error: \(error)")
            }
            
            
            
        }
        
        task.resume()
        
    }
    
    
        
    
        
    
    
}
