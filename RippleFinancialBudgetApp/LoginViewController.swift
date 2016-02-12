//
//  LoginViewController.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/9/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBAction func SignInButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        
        // Check if the info is empty
        
        if(userEmail!.isEmpty || userPassword!.isEmpty ){
            DisplayAlertMessage("All fields are required")
            return
        }
        
        let url = NSURL(string:"http://ripple-financial.com/userLogin.php")
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = "email=\(userEmail!)&password=\(userPassword!)"
        
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
            var userID: Int = 0
            
            // convert String to NSData
            let data: NSData = urlContents.dataUsingEncoding(NSUTF8StringEncoding)!
            //var error: NSError?
            
            // convert NSData to 'AnyObject'
            do {
                let anyObj = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
                
                status = (anyObj["status"] as AnyObject? as? String) ?? "" // to get rid of null
                message = (anyObj["message"] as AnyObject? as? String) ?? "" // to get rid of null
                
                if status == ("Success") {
                    let userIDstr = (anyObj["userID"] as AnyObject? as? String) ?? ""
                    userID = Int(userIDstr)!
                    print("userID: \(userID)")
                    NSUserDefaults.standardUserDefaults().setInteger(userID, forKey: "UserID")
                }
                
                print(status)
                
                
            } catch {
                print("json error: \(error)")
            }
            
            // If User not found, display alert message
            dispatch_async(dispatch_get_main_queue(), {
                if status != ("Success") {
                    
                    self.DisplayAlertMessage(message)
                    
                    
                }
                else {
                    // If User Found -> Login
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                    
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
