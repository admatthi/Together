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

var noothervids = Bool()
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
    
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.mysnippetsapp.weebly.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    
    var purchasestring = String()
    
    override func viewDidDisappear(_ animated: Bool) {
        
        self.playerView.player?.pause()

    }
    func queryforinfo() {

        var functioncounter = 0


            ref?.child("Influencers").child(selectedid).observeSingleEvent(of: .value, with: { (snapshot) in

                var value = snapshot.value as? NSDictionary

                if var author2 = value?["Purchase"] as? String {
                    self.purchasestring = author2

                    //                    self.createThumbnailOfVideoFromRemoteUrl(url: author2)

                    let videourl = URL(string: self.purchasestring)

                    self.avPLayer = AVPlayer(url: videourl! as URL)
                    self.avPLayer.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)

                    self.playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill

                    self.playerView.playerLayer.player = self.avPLayer


                    self.playerView.player?.play()
                    self.loadingscreen.alpha = 0
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0


                }


            })

    }
    
    var avPLayer = AVPlayer()
    
    @IBOutlet weak var playerView: PlayerViewClass!
    @IBOutlet weak var tapterms: UIButton!
    @IBOutlet weak var tapbuy: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingscreen: UILabel!
    @IBOutlet weak var influencername: UILabel!

        @IBOutlet weak var videotitle: UILabel!
    @IBOutlet weak var profileimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingscreen.alpha = 1
        activityIndicator.color = mypink
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        ref = Database.database().reference()
        profileimage.layer.masksToBounds = true
        profileimage.layer.cornerRadius = 5.0
        influencername.text = lowercasename
        videotitle.text = selectedtitle
        profileimage.image = myselectedimage

        tapbuy.layer.cornerRadius = 22.0
        tapbuy.layer.masksToBounds = true
        
        
        
        tapterms.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        
        let buttonTitleStr = NSMutableAttributedString(string:"By continuing, you accept our Terms of Use & Privacy Policy", attributes:attrs)
        attributedString.append(buttonTitleStr)
        tapterms.setAttributedTitle(attributedString, for: .normal)
        tapterms.setTitleColor(.black, for: .normal)
        
        queryforinfo()
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

            
        } else {
            
            if uid == selectedid {
                
                tapbuy.layer.backgroundColor = UIColor.gray.cgColor
                tapbuy.isUserInteractionEnabled = false
            } else {
                tapbuy.isUserInteractionEnabled = true

                
            }
        }
        
        //        whitelabel.layer.cornerRadius = 10.0
        //        whitelabel.layer.masksToBounds = true
        
     
    
}
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "rate" {
            
            print(avPLayer.rate)
            
            if avPLayer.rate > 0.5 {
               
                
            }
        }
    }

}
