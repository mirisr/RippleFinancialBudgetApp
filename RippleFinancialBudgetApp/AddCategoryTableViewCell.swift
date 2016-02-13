//
//  ShowCategoryTableViewCell.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/12/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//

import UIKit


class AddCategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var addButton: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}


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

/*
// Programmatically create an ADD button
let button   = UIButton(type: UIButtonType.System) as UIButton
button.frame = CGRectMake(335, 5, 30, 30)
//button.backgroundColor = UIColor.greenColor()
button.setTitle("+", forState: UIControlState.Normal)
button.titleLabel!.font =  UIFont(name: "Helvetica Neue", size: 24)
button.addTarget(self, action: "AddCategoryClicked", forControlEvents: UIControlEvents.TouchUpInside)
myCell.addSubview(button)
*/
