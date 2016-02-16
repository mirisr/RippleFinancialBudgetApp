//
//  CurrentActivity.swift
//  RippleFinancialBudgetApp
//
//  Created by Iris Rubi Seaman on 2/13/16.
//  Copyright © 2016 Ripple Financial. All rights reserved.
//

import UIKit

class CurrentActivityViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.whiteColor()
      
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryActivityViewCell", forIndexPath: indexPath) as! CurrentActivityViewCell
        
        //cell.backgroundColor = UIColor.lightGrayColor()
        //cell.categoryLabel.text = "Category"
        
        
        cell.budgetAmountRemaining.transform = CGAffineTransformMakeRotation((CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        
        cell.budgetAmountRemaining.layer.cornerRadius = 15
        
        cell.budgetAmountRemaining.clipsToBounds = true
        //cell.budgetAmountRemaining.
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Cell \(indexPath.row) selected")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
