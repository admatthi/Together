//
//  PurchaseViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/9/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import Purchases
import AVFoundation

class PurchaseViewController: UIViewController {
    var attrs = [
        NSAttributedStringKey.foregroundColor : UIColor.lightGray,
        NSAttributedStringKey.underlineStyle : 1] as [NSAttributedStringKey : Any]
    
    var attrs2 = [NSAttributedStringKey.font : UIFont(name: "AvenirNext-Bold", size: 17.0),
                  NSAttributedStringKey.foregroundColor : UIColor.black] as [NSAttributedStringKey : Any]
    
    var attributedString = NSMutableAttributedString(string:"")
    var attributedString2 = NSMutableAttributedString(string:"")
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var purchases = RCPurchases(apiKey: "RDlbQdhQOSZKZUtWvzWnfocZNPLbDFfw")
    
    @IBAction func tapLogin(_ sender: Any) {
    }
    @IBAction func tapBuy(_ sender: Any) {
        
        FBSDKAppEvents.logEvent("Trial Pressed")

        purchases.entitlements { entitlements in
            guard let pro = entitlements?["Subscriptions"] else { return }
            guard let monthly = pro.offerings["Weekly"] else { return }
            guard let product = monthly.activeProduct else { return }
            self.purchases.makePurchase(product)
            
            
        }
    }
    
    
    
    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.mysnippetsapp.weebly.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    
    var purchasestring = String()
    func queryforinfo() {
        
        var functioncounter = 0
        
            
            ref?.child("Influencers").child(selectedid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Purchase"] as? String {
                    self.purchasestring = author2
                    
                    //                    self.createThumbnailOfVideoFromRemoteUrl(url: author2)
                    
                    let videourl = URL(string: self.purchasestring)
                    
                    let avPlayer = AVPlayer(url: videourl! as URL)
                    
                    self.playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill
                    
                    self.playerView.playerLayer.player = avPlayer
                    self.playerView.player?.play()
                    
                }
                
                
            })
            
    }
    
    @IBOutlet weak var playerView: PlayerViewClass!
    @IBOutlet weak var tapterms: UIButton!
    @IBOutlet weak var tapbuy: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        tapbuy.layer.cornerRadius = 22.0
        tapbuy.layer.masksToBounds = true
        
        tapterms.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        
        let buttonTitleStr = NSMutableAttributedString(string:"By continuing, you accept our Terms of Use & Privacy Policy", attributes:attrs)
        attributedString.append(buttonTitleStr)
        tapterms.setAttributedTitle(attributedString, for: .normal)
        tapterms.setTitleColor(.black, for: .normal)
        
        queryforinfo()
        
        
        //        whitelabel.layer.cornerRadius = 10.0
        //        whitelabel.layer.masksToBounds = true
        
        
    
}

}
