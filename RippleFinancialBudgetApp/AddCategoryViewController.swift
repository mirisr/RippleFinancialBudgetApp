//
//  AddCategoryViewController.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/12/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//

import UIKit

protocol AddCategoryProtocal: class {
    func categoryAdded()
}

class AddCategoryViewController: UIViewController, NSURLSessionDataDelegate {
    
    weak var delegate: AddCategoryProtocal!
    
    @IBOutlet weak var CategoryNameTextField: UITextField!
    @IBOutlet weak var BudgetAmountTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func AddButtonPressed(sender: AnyObject) {
        
        let name = CategoryNameTextField.text!
        let amount = (BudgetAmountTextField.text!)
        
        if (name.isEmpty || amount.isEmpty)
        {
            DisplayAlertMessage("All fields are required")
        }
        
        let userID = NSUserDefaults.standardUserDefaults().objectForKey("UserID")!
        
        let url = NSURL(string:"http://ripple-financial.com/addCategory.php")
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = "userID=\(userID)&categoryName=\(name)&budgetAmount=\(amount)"
        
        print (paramString)
        
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
            
            print(urlContents)
            var message: String = ""
            var status: String = ""
            
            // convert String to NSData
            let data: NSData = urlContents.dataUsingEncoding(NSUTF8StringEncoding)!
            //var error: NSError?
            
            // convert NSData to 'AnyObject'
            do {
                let anyObj = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
                
                status = (anyObj["status"] as AnyObject? as? String) ?? "" // to get rid of null
                message = (anyObj["message"] as AnyObject? as? String) ?? "" // to get rid of null
                
                print(status)
                
                
            } catch {
                print("json error: \(error)")
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                // reload the list of categories
                if (self.delegate == nil) {
                    print ("delegate is nil")
                }
                self.delegate.categoryAdded()
                
            })
            
            // If User not found, display alert message
            dispatch_async(dispatch_get_main_queue(), {
                if status != ("success") {
                    
                    self.DisplayAlertMessage(message)
                    
                    
                }
                else {
                    
                    
                    
                    // if successful then take off
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                    
                    
                }
            })
            
            
        }
        
        task.resume()
        
        
        
    }
    
    func DisplayAlertMessage(userMessage: String){
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler:nil)
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
}