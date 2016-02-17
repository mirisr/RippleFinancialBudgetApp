//
//  CurrentActivity.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/13/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//

import UIKit

class CurrentActivityViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, DownloadCategoriesServiceProtocal{
    
    var allCateogries: Array<Category> = Array<Category>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        let downloadCategoryService = DownloadCategoriesService()
        downloadCategoryService.delegate = self
        downloadCategoryService.downloadCategories()
      
    }
    
    func itemsDownloaded(items: Array<Category>) {
        
        allCateogries = items
        self.collectionView.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCateogries.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryActivityViewCell", forIndexPath: indexPath) as! CurrentActivityViewCell
        
        //cell.backgroundColor = UIColor.lightGrayColor()
        
        // Get the category to be shown
        let category: Category = allCateogries[indexPath.row]
        
        // Set the Label for the Category
        cell.categoryLabel.text = category.name!
        
        // Turn the Progress Bar vertical
        cell.budgetAmountRemaining.transform = CGAffineTransformMakeRotation((CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        
        // Make the Progress Bar Rounded
        cell.budgetAmountRemaining.layer.cornerRadius = 15
        cell.budgetAmountRemaining.clipsToBounds = true
        
        // Set the Progress to the Category (Amount Available)
        let amountAvailable = category.budgetAmount! - category.currentAmountSpent!
        let percentageAvailable = amountAvailable / category.budgetAmount!
        cell.budgetAmountRemaining.setProgress(Float(percentageAvailable), animated: false)
        
        cell.budgetAmountRemaining.progressTintColor = UIColorFromRGB(0x0099CC)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Cell \(indexPath.row) selected")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
