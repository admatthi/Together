//
//  CreateAPlanViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/19/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import FirebaseDynamicLinks

class CreateAPlanViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var email = String()
    var password = String()
    var inputname = String()
    var domainz = String()
    var inputdescription = String()
    var inputprice = String()
    var inputprogramname = String()
    var phonenumber = String()
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == mygray {
            textView.text = ""
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What would you like to create?"
            textView.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var tapsign: UIButton!
    
    @IBAction func tapSignUp(_ sender: Any) {
        
        
        self.view.endEditing(true)
        
        //        pn2tf.text = " "
        //        pricetf.text = " "
        //        pdtf.text = " "
        //        domaintf.text = " "
        //
        email = "\(emailtf.text!)"
        password = "\(passwordtf.text!)"
        inputname = "\(nametf.text!)"
        
        signup()
        //        domainz = domainz.replacingOccurrences(of: " ", with: "-")
        //        if email != "" && password != "" && name != "" && domainz != "" {
        
  
        
        
        
        //        }
        
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        //        self.dismiss(animated: true, completion: {
        //
        //        })
    }
    
    @IBOutlet weak var domaintf: UITextField!
    
    @IBOutlet weak var pdtf: UITextView!
    @IBOutlet weak var pricetf: UITextField!
    @IBOutlet weak var pntf: UITextField!
    @IBOutlet weak var pn2tf: UITextField!
    
    @IBOutlet weak var nametf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    
    
    @IBOutlet weak var thankyou: UILabel!
    //    func signup() {
    //
    //        var email = "\(emailtf.text!)"
    //        var password = "\(passwordtf.text!)"
    //        var name = "\(nametf.text!)"
    //        var domain = "\(domaintf.text!)"
    //
    //        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
    //
    //            if let error = error {
    //
    //                self.errorlabel.alpha = 1
    //                self.errorlabel.text = error.localizedDescription
    //
    //                return
    //
    //            } else {
    //
    //                uid = (Auth.auth().currentUser?.uid)!
    //
    //                //                ref!.child("Users").child(uid).child("Purchased").child(selectedid).updateChildValues(["Title": "x"])
    //
    //                let date = Date()
    //                let calendar = Calendar.current
    //                let dateFormatter = DateFormatter()
    //                dateFormatter.dateFormat = "MM-dd-yy"
    //                var todaysdate =  dateFormatter.string(from: date)
    //                let thirtyDaysAfterToday = Calendar.current.date(byAdding: .day, value: +30, to: date)!
    //                let thirty = dateFormatter.string(from: thirtyDaysAfterToday)
    //
    //                //                self.addstaticbooks()
    //                ref?.child("Users").child(uid).updateChildValues(["Email" : email, "Influencer" : "True", "Password": password, "Name" : name, "Domain" : domain, "Approved" : "False"])
    //
    //
    //
    //
    //                DispatchQueue.main.async {
    //
    //                    //                    purchased = true
    //
    //                    self.performSegue(withIdentifier: "InfluencerToThankYou", sender: self)
    //                }
    //            }
    //
    //        }
    //
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    @IBOutlet weak var errorlabel: UILabel!
    func signup() {
        
        
        var email = "\(emailtf.text!)"
        var password = "\(passwordtf.text!)"
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                
                self.errorlabel.alpha = 1
                self.errorlabel.text = error.localizedDescription
                
                //                self.thankyou.alpha = 1
                //                self.passwordtf.alpha = 1
                //                self.domaintf.alpha = 1
                //                self.emailtf.alpha = 1
                //                self.nametf.alpha = 1
                //                self.tapsign.alpha = 1
                //                self.pdtf.alpha = 1
                //                self.pn2tf.alpha = 1
                //                self.pdtf.alpha = 1
                //                self.pntf.alpha = 1
                //                self.pricetf.alpha = 1
                
                return
                
            } else {
                
                uid = (Auth.auth().currentUser?.uid)!
                
                //                ref!.child("Users").child(uid).child("Purchased").child(selectedid).updateChildValues(["Title": "x"])
                
                let date = Date()
                let calendar = Calendar.current
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yy"
                var todaysdate =  dateFormatter.string(from: date)
                let thirtyDaysAfterToday = Calendar.current.date(byAdding: .day, value: +30, to: date)!
                let thirty = dateFormatter.string(from: thirtyDaysAfterToday)
                
                guard let link = URL(string: "https://www.joinmyfam.com/\(uid)") else { return }
                let dynamicLinksDomain = "joinmyfam.page.link"
                let linkBuilder = DynamicLinkComponents(link: link, domain: dynamicLinksDomain)
                linkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.aatech.Fam")
                linkBuilder.androidParameters = DynamicLinkAndroidParameters(packageName: "com.example.android")
                
                
                    ref?.child("Users").child(uid).updateChildValues(["Approved" : "True"])
                
                
                
                
                linkBuilder.iOSParameters?.fallbackURL = URL(string: "https://www.joinmyfam.com/\(uid)")
                
                var myurl = String()
                
                guard let longDynamicLink = linkBuilder.url else { return }
                

                
                linkBuilder.shorten { (shortURL, warnings, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    print("The short URL is: \(shortURL)")
                    
                    ref?.child("Influencers").child(uid).updateChildValues(["Subscribers" : "0", "Approved" : "True", "Name" : self.inputname, "ProPic" : "https://firebasestorage.googleapis.com/v0/b/deploy-141ca.appspot.com/o/Placeholder.png?alt=media&token=d8e17ae6-6b59-4865-9f2b-bab8c08db233", "Email" : self.email, "Password" : self.password, "Domain" : shortURL!.absoluteString, "Purchase" : "-", "Price" : "20"])

                    selectedshareurl = (shortURL?.absoluteString)!
                    self.performSegue(withIdentifier: "CreateToYourChannel", sender: self)

                    // TODO: Handle shortURL.
                }
                

//                print("The long URL is: \(longDynamicLink)")
//                myurl = url.absoluteString
//
//                linkBuilder.shorten() { url, warnings, error in
//                    guard let url = url, error != nil else {
//
//                        print(error)
//
//
//
////
//                        return
//
//                    }
//
//
//                }
                //                self.addstaticbooks()
                
        
                

                
            }
            
        }
        
    }
    
    @IBOutlet weak var demo: UILabel!
    @IBOutlet weak var tapcreate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        

        requestlabel.addCharacterSpacing()
        ref = Database.database().reference()
        tapcreate.addTextSpacing(2.0)
        emailtf.delegate = self
        passwordtf.delegate = self
        nametf.delegate = self
        domaintf.delegate = self
        //        emailtf.becomeFirstResponder()
        
//        tapcreate.layer.cornerRadius = 22.0
//        tapcreate.layer.masksToBounds = true
        
        FBSDKAppEvents.logEvent("LoginScreen")
        
        
        self.addLineToView(view: passwordtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        self.addLineToView(view: nametf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        self.addLineToView(view: emailtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        self.addLineToView(view: domaintf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        mychannelname = ""
        mypaypal = ""
        myintrovideo = ""
        mychannelprice = ""
    }
    
    @IBOutlet weak var requestlabel: UILabel!
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    enum LINE_POSITION {
        case LINE_POSITION_TOP
        case LINE_POSITION_BOTTOM
    }
    
    func addLineToView(view : UIView, position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        view.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        default:
            break
        }
    }
}

