//
//  Category.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/10/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//


import Foundation

class Category: NSObject
{
    
    //variables
    
    var name: String?
    var budgetAmount: Double?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    init(categoryName: String, budgetAmount: Double)
    {
        self.name = categoryName
        self.budgetAmount = budgetAmount
    }
    
    override var description: String
        {
            return "Category Name: \(name) - Budget Amount: \(budgetAmount)"
    }
    
}
