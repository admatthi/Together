//
//  SettingsViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/8/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import UserNotifications

var loggedin = Bool()

class SettingsViewController: UIViewController {
    @IBOutlet weak var tapsubscriptions: UIButton!
    @IBOutlet weak var tapabout: UIButton!
    @IBOutlet weak var tapbilling: UIButton!
    @IBOutlet weak var tapprivacy: UIButton!
    @IBOutlet weak var tapterms: UIButton!
    
    @IBAction func tapBilling(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.mysnippetsapp.weebly.com/billing-terms.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBAction func tapAbout(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.mysnippetsapp.weebly.com"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func tapLogout(_ sender: Any) {
        
        try! Auth.auth().signOut()
        
        self.performSegue(withIdentifier: "SettingsToLogin", sender: self)
    }
    @IBAction func tapSubscription(_ sender: Any) {
        
        //        if let url = NSURL(string: "https://www.tryeatfree.com/subscription.html"
        //            ) {
        //            UIApplication.shared.openURL(url as URL)
        //        }
    }
    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.mysnippetsapp.weebly.com/terms.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func tapPrivacy(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.mysnippetsapp.weebly.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            loggedin = false
            taplog.setTitle("Log In", for: .normal)
            
        } else {
            
            loggedin = true
            taplog.setTitle("Log Out", for: .normal)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapsubscriptions.layer.cornerRadius = 25.0
        tapsubscriptions.layer.masksToBounds = true
        tapprivacy.layer.cornerRadius = 25.0
        tapprivacy.layer.masksToBounds = true
        tapterms.layer.cornerRadius = 25.0
        tapterms.layer.masksToBounds = true
        tapabout.layer.cornerRadius = 25.0
        tapabout.layer.masksToBounds = true
        tapbilling.layer.cornerRadius = 25.0
        tapbilling.layer.masksToBounds = true

        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            loggedin = false
            taplog.setTitle("Log In", for: .normal)
            
        } else {
            
            loggedin = true
            taplog.setTitle("Log Out", for: .normal)

        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func taplog(_ sender: Any) {
        
       
    }
    
    @IBOutlet weak var taplog: UIButton!
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
