//
//  PlanViewController.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/9/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CategoryInfoProtocal  {
    
    //Properties
    
    var feedItems: Array<Category> = Array<Category>()
    //var selectedCateogry : Category = Category()
    
    @IBOutlet weak var listCategoriesView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates and initialize homeModel
        
        self.listCategoriesView.delegate = self
        self.listCategoriesView.dataSource = self
        
        let categoryInfo = CategoryInfo()
        categoryInfo.delegate = self
        categoryInfo.downloadCategories()
        
    }
    
    func itemsDownloaded(items: Array<Category>) {
        
        feedItems = items
        self.listCategoriesView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        print("count: \(feedItems.count)")
        return feedItems.count + 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "CategoryCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
        
        if ( indexPath.row != feedItems.count) {
            
            if(myCell.subviews.count > 0) {
                for view in myCell.subviews {
                    if view.isKindOfClass(UIButton) {
                        view.removeFromSuperview()
                    }
                    if view.isKindOfClass(UITextField) {
                        view.removeFromSuperview()
                    }
                }
            }
         
         
            // Get the category to be shown
            let category: Category = feedItems[indexPath.row]
            
            print("Category::\(category.name!)")
            
            // Get references to labels of cell
            myCell.textLabel!.text = category.name!
            myCell.textLabel!.font = UIFont(name: "Helvetica Neue", size: 14.0)
            // Add Budget Amount in a label 
            //Programmatically create label
            let newLabel = UILabel(frame: CGRectMake(290.0, 5.0, 70.0, 30.0))
            newLabel.tag = 1
            newLabel.font = UIFont(name: "Helvetica Neue", size: 14.0)
            newLabel.textColor = UIColor.darkGrayColor()
            newLabel.textAlignment = NSTextAlignment.Right
            
            myCell.addSubview(newLabel)
            
            let budgetAmountStr = String(format: "%.02f", category.budgetAmount!)
            newLabel.text = "$\(budgetAmountStr)"
            
        } else if (indexPath.row == feedItems.count) {
            
            //myCell.textLabel!.text = "Add New Category"
            
            // Programmatically create a text field
            
            /*
            let textField: UITextField = UITextField()
            textField.frame = CGRectMake(10, 5, 270, 30)
            //textField.backgroundColor = UIColor.lightGrayColor()
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.lightGrayColor().CGColor
            textField.layer.cornerRadius = 5
            textField.placeholder = " New Category"
            textField.font = UIFont(name: "Helvetica Neue", size: 14)
            textField.clearsOnBeginEditing = true
            textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
            myCell.addSubview(textField)
            */
            
            // Programmatically create an ADD button
            let button   = UIButton(type: UIButtonType.System) as UIButton
            button.frame = CGRectMake(335, 5, 30, 30)
            //button.backgroundColor = UIColor.greenColor()
            button.setTitle("+", forState: UIControlState.Normal)
            button.titleLabel!.font =  UIFont(name: "Helvetica Neue", size: 24)
            button.addTarget(self, action: "AddCategoryClicked", forControlEvents: UIControlEvents.TouchUpInside)
            myCell.addSubview(button)


        }
        
        return myCell
    }
    
    func AddCategoryClicked(sender:UIButton)
    {
        
        self.performSegueWithIdentifier("AddCategory", sender: self)
        /*for view in listCategoriesView.subviews {
            if view.isKindOfClass(UITextField) {
                let textfield : UITextField = view
                var newCategoryName
                
            }
        }*/

    }
    
        
}