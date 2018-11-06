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

class ProjectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource  {

    var purchases = RCPurchases(apiKey: "XJcTuaSXGKIWBwsRjWsKIUumwbSzBArQ")

    
    @IBOutlet weak var titlelabel: UILabel!
    var prices = [String]()
    
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var backers: UILabel!
    @IBOutlet weak var amountpledged: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var authorlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        screenshots.append(UIImage(named: "A")!)
        screenshots.append(UIImage(named: "B")!)
        screenshots.append(UIImage(named: "C")!)

        tableVIew.reloadData()
//        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        return 5
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
   
        cell.screenshot.image = UIImage(named: "A")
//        cell.price.text = "$\(prices[indexPath.row])"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Project", for: indexPath) as! ProjectTableViewCell
        
        
            
        cell.projectimage.image = selectedimage
            cell.projectname.text = selectedtitle
        
            cell.projectdescription.text = selecteddescription
        cell.authorlabel.text = "by Alek Matthiessen"
        cell.longdescription.text = selectedlongdescription
            var floatprogress = Float(selectedprogress)!/100
        
            cell.progressView.setProgress(floatprogress, animated: true)
            
            
    
        
        
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

var selectedauthor = String()
var selectedlongdescription = String()
