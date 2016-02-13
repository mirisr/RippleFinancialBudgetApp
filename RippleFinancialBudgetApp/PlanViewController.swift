//
//  PlanViewController.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/9/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate, CategoryInfoProtocal, AddCategoryProtocal  {
    
    //Properties
    
    var feedItems: Array<Category> = Array<Category>()
    //var selectedCateogry : Category = Category()
    
    @IBOutlet weak var listCategoriesView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listCategoriesView.delegate = self
        self.listCategoriesView.dataSource = self
        
        let categoryInfo = CategoryInfo()
        categoryInfo.delegate = self
        categoryInfo.downloadCategories()
        
    }
    
    func categoryAdded() {
        self.viewDidLoad()
    }
    
    func itemsDownloaded(items: Array<Category>) {
        
        feedItems = items
        self.listCategoriesView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        print("count: \(feedItems.count)")
        return feedItems.count + 1
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Expenses"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if ( indexPath.row != feedItems.count) {
            
            let myCell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CategoryCell")
            
            // Get the category to be shown
            let category: Category = feedItems[indexPath.row]
            
            print("Category::\(category.name!)")
            
            // Get references to labels of cell
            myCell.textLabel!.text = category.name!
            myCell.textLabel!.font = UIFont(name: "Helvetica Neue", size: 14.0)
            
            //Programmatically create label
            let newLabel = UILabel(frame: CGRectMake(290.0, 5.0, 70.0, 30.0))
            newLabel.tag = 1
            newLabel.font = UIFont(name: "Helvetica Neue", size: 14.0)
            newLabel.textColor = UIColor.darkGrayColor()
            newLabel.textAlignment = NSTextAlignment.Right
            
            myCell.addSubview(newLabel)
            
            let budgetAmountStr = String(format: "%.02f", category.budgetAmount!)
            newLabel.text = "$\(budgetAmountStr)"
            
            return myCell
            
        } else {
            
            let myCell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "AddCategoryCell")
            
            //Programmatically create label
            let newLabel = UILabel(frame: CGRectMake(210.0, 5.0, 120.0, 30.0))
            newLabel.tag = 1
            newLabel.font = UIFont(name: "Helvetica Neue", size: 14.0)
            newLabel.textColor = UIColor.darkGrayColor()
            newLabel.textAlignment = NSTextAlignment.Right
            newLabel.text = "Add New Cateogry"
            myCell.addSubview(newLabel)
            
            
            // Programmatically create an ADD button
            let button   = UIButton(type: UIButtonType.System) as UIButton
            button.frame = CGRectMake(335, 5, 30, 30)
            //button.backgroundColor = UIColor.greenColor()
            button.setTitle("+", forState: UIControlState.Normal)
            button.titleLabel!.font =  UIFont(name: "Helvetica Neue", size: 24)
            button.addTarget(self, action: "AddCategoryClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            myCell.addSubview(button)
            
            return myCell
            
        }
        
    }
    
    
    func AddCategoryClicked(sender: UIButton) {
        
        performSegueWithIdentifier("AddCategory", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AddCategory" {
            
            //categoryInfo.delegate = self

            let vc = segue.destinationViewController as! UIViewController
            
            let addCategoryObg = segue.destinationViewController as! AddCategoryViewController
            
            addCategoryObg.delegate = self
            
            let controller = vc.popoverPresentationController
            
            if controller != nil {
                
                controller?.delegate.self
                
            }
            vc.preferredContentSize = CGSizeMake(400, 250)
            controller?.permittedArrowDirections = UIPopoverArrowDirection()
            controller?.delegate = self
            controller?.sourceView = self.view
            controller?.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds) - 20, CGRectGetMidY(self.view.bounds), 0,0)
            
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
        
}