//
//  ViewController.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/8/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Hack for the simulator
        viewCount++
        if viewCount == 1 {
            self.performSegueWithIdentifier("LoginView", sender: self)
        }

        if(!userLoggedIn()) {
            self.performSegueWithIdentifier("LoginView", sender: self)
        }
        else
        {
            self.performSegueWithIdentifier("TabBarView", sender: self)
        }

        
    }
    
    func userLoggedIn() -> Bool {
        return NSUserDefaults.standardUserDefaults().objectForKey("isUserLoggedIn")?.boolValue != nil
    }

    @IBAction func LogoutButtonTapped(sender: AnyObject) {
        
        // Log out offically
        
        // Return to Log in page again
        self.performSegueWithIdentifier("LoginView", sender: self)

    }

}

