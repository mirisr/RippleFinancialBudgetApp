//
//  CreateAccountViewController.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/8/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//
import UIKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBAction func SignUpButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let userPassword = passwordTextField.text
        let repeatPassword = repeatPasswordTextField.text
        
        
        
        // Check if the info is empty
        
        if(userEmail!.isEmpty || userPassword!.isEmpty || repeatPassword!.isEmpty){
            DisplayAlertMessage("All fields are required")
            return
        }
        
        // Check if passwords Match
        if (userPassword != repeatPassword){
            DisplayAlertMessage("Passwords do NOT match")
            return
        }
        
        let url = NSURL(string:"http://ripple-financial.com/userRegister.php")
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = "email=\(userEmail!)&password=\(userPassword!)"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = session.downloadTaskWithRequest(request) {
            (
            let location, let response, let error) in
            
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
            
            //print(urlContents)
            var message: String = ""
            
            // convert String to NSData
            let data: NSData = urlContents.dataUsingEncoding(NSUTF8StringEncoding)!
            //var error: NSError?
            
            // convert NSData to 'AnyObject'
            do {
                let anyObj = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
                
                message = self.parseJson(anyObj)
                print(message)

                
                
            } catch {
                print("json error: \(error)")
            }
            
            dispatch_async(dispatch_get_main_queue(), {

                // Display Alert with confirmation
                if (message != "Success") {
                    
                    self.DisplayAlertMessage(message)
                    
                }
                else {
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                
            })
            
        }
        
        task.resume()

       
    }
    
    func parseJson(anyObj:AnyObject) -> String{
        
        
        let message = (anyObj["status"] as AnyObject? as? String) ?? "" // to get rid of null
        
        return message
        
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
