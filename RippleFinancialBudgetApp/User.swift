//
//  User.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/9/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//

import Foundation

class User: NSObject
{
    
    //variables
    
    var email: String?
    var password: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    init(email: String, password: String)
    {
        self.email = email
        self.password = password
    }
    
    override var description: String
    {
        return "Email: \(email)"
    }
    
    
}