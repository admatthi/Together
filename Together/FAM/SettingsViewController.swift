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

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var tapsubscriptions: UIButton!
    @IBOutlet weak var tapabout: UIButton!
    @IBOutlet weak var tapbilling: UIButton!
    @IBOutlet weak var tapprivacy: UIButton!
    @IBOutlet weak var tapterms: UIButton!
    
    @IBAction func tapBilling(_ sender: Any) {
        
        if let url = NSURL(string: "https://938152110718650409.weebly.com/billing-terms.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBAction func tapAbout(_ sender: Any) {
        
        if let url = NSURL(string: "https://938152110718650409.weebly.com/"
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
        
        if let url = NSURL(string: "https://938152110718650409.weebly.com/terms.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func tapPrivacy(_ sender: Any) {
        
        if let url = NSURL(string: "https://938152110718650409.weebly.com//privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    var imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var HEADERLABEL: UILabel!
    @IBAction func tapEditProfile(_ sender: Any) {
    }
    @IBAction func tapRevenue(_ sender: Any) {
    }
    @IBAction func tapAdd(_ sender: Any) {
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        videoURL = info[UIImagePickerControllerMediaURL]as? NSURL
        print(videoURL!)
        do {
            //            let asset = AVURLAsset(url: videoURL as! URL , options: nil)
            //            let imgGenerator = AVAssetImageGenerator(asset: asset)
            //            imgGenerator.appliesPreferredTrackTransform = true
            //            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            //            let thumbnail = UIImage(cgImage: cgImage)
            //            imgView.image = thumbnail
            
            
            DispatchQueue.main.async {
                
                //                    purchased = true
                self.dismiss(animated: true, completion: nil)
                
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Upload") as UIViewController
                
                self.present(initialViewControlleripad, animated: true, completion: nil)
                
                
                
            }
            
            
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        HEADERLABEL.addCharacterSpacing()
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            loggedin = false
            taplog.setTitle("Log In", for: .normal)
            
        } else {
            
            loggedin = true
            taplog.setTitle("Log Out", for: .normal)
            
        }
    }
    
    @IBOutlet weak var tapeditprofile: UIButton!
    @IBOutlet weak var tapaddcontent: UIButton!
    @IBOutlet weak var tapseerevenue: UIButton!
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

