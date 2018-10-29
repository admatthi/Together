//
//  ProjectViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 10/26/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import UserNotifications
import StoreKit
import FBSDKCoreKit
import Purchases

var selectedprice = String()
var selectedtitle = String()
var selecteddescription = String()
var selectedprogress = String()

var selectedprojectid = String()

class ProjectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var purchases = RCPurchases(apiKey: "XJcTuaSXGKIWBwsRjWsKIUumwbSzBArQ")

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titlelabel: UILabel!
    var prices = [String]()
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var backers: UILabel!
    @IBOutlet weak var amountpledged: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var authorlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        productimage.image = selectedimage
        titlelabel.text = selectedtitle
        descriptionlabel.text = selecteddescription
        tapBuy.setTitle("$\(selectedprice)", for: .normal) 
        authorlabel.text = "by Alek Matthiessen"
        amountpledged.text = "$2,987"
        let progress = (Float(selectedprogress)!/100)
        self.progressView.setProgress(Float(progress), animated:true)
        screenshots.append(UIImage(named: "A")!)
        screenshots.append(UIImage(named: "B")!)
        screenshots.append(UIImage(named: "C")!)
        tapBuy.layer.cornerRadius = 10.0
        tapBuy.layer.masksToBounds = true
        
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        return 3
    }
    
    @IBOutlet weak var pricelabel: UILabel!
    
    @IBOutlet weak var tapshare: UIButton!
    @IBAction func tapShare(_ sender: Any) {
        
    }
    @IBOutlet weak var tapBuy: UIButton!
    
    @IBAction func tapbuy(_ sender: Any) {
        
        FBSDKAppEvents.logEvent("Lifetime Pressed")
        
        //        purchase(purchase: sevendayfreetrial)
        
        purchases.entitlements { entitlements in
            guard let pro = entitlements?["Projects"] else { return }
            
            
            guard let monthly = pro.offerings["\(selectedprojectid)"] else { return }
            
            
            guard let product = monthly.activeProduct else { return }
            
            
            self.purchases.makePurchase(product)
            
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Project", for: indexPath) as! ProjectCollectionViewCell
   
        cell.screenshot.image = screenshots[indexPath.row]
//        cell.price.text = "$\(prices[indexPath.row])"
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    var screenshots = [UIImage]()
}
