//
//  InfluencerCreateViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/12/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

class InfluencerCreateViewController: UIViewController, UITextFieldDelegate {

    var email = String()
    var password = String()
    var inputname = String()
    var domainz = String()
    var inputdescription = String()
    var inputprice = String()
    var inputprogramname = String()
    var phonenumber = String()
    
    
    @IBOutlet weak var tapsign: UIButton!
    
    @IBAction func tapSignUp(_ sender: Any) {
        
    
        email = "\(emailtf.text!)"
        password = "\(passwordtf.text!)"
        inputname = "\(nametf.text!)"
        domainz = "\(domaintf.text!)"
        inputdescription = "\(pdtf.text!)"
        inputprice = "\(pricetf.text!)"
        inputprogramname = "\(pn2tf.text!)"
        phonenumber = "\(pntf.text!)"
        errorlabel.alpha = 0
        domainz = domainz.replacingOccurrences(of: " ", with: "-")
//        if email != "" && password != "" && name != "" && domainz != "" {
        
            if Auth.auth().currentUser == nil {
                // Do smth if user is not logged in

                signup()

                
            } else {
                
//
                ref?.child("Influencers").child(uid).updateChildValues(["Description" : inputdescription, "Price" : inputprice, "Phone Number" : phonenumber, "ProgramName" : inputprogramname, "Subscribers" : "0", "Approved" : "False", "Name" : inputname, "ProPic" : "https://firebasestorage.googleapis.com/v0/b/deploy-141ca.appspot.com/o/Placeholder.png?alt=media&token=d8e17ae6-6b59-4865-9f2b-bab8c08db233", "Email" : email, "Password" : password, "Domain" : domainz, "Purchase" : "https://firebasestorage.googleapis.com/v0/b/deploy-141ca.appspot.com/o/y2mate.com%20-%20mvmt_social_ad_vertical_video_bjH6DShpolY_1080p.mp4?alt=media&token=6fd2dd4e-5890-4ba4-98b1-393c962dc053"])

                thankyou.alpha = 1
                passwordtf.alpha = 0
                domaintf.alpha = 0
                emailtf.alpha = 0
                nametf.alpha = 0
                tapsign.alpha = 0
                pdtf.alpha = 0
                pn2tf.alpha = 0
                pdtf.alpha = 0
                pntf.alpha = 0
                pricetf.alpha = 0
            }


        
//        }
        
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        //        self.dismiss(animated: true, completion: {
        //
        //        })
    }
    
    @IBOutlet weak var domaintf: UITextField!
    
    @IBOutlet weak var pricetf: UITextField!
    @IBOutlet weak var pdtf: UITextField!
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
                
                //                self.addstaticbooks()
                ref?.child("Influencers").child(uid).updateChildValues(["Description" : self.inputdescription, "Price" : self.inputprice, "Phone Number" : self.phonenumber, "ProgramName" : self.inputprogramname, "Subscribers" : "0", "Approved" : "False", "Name" : self.inputname, "ProPic" : "https://firebasestorage.googleapis.com/v0/b/deploy-141ca.appspot.com/o/Placeholder.png?alt=media&token=d8e17ae6-6b59-4865-9f2b-bab8c08db233", "Email" : self.email, "Password" : self.password, "Domain" : self.domainz, "Purchase" : "https://firebasestorage.googleapis.com/v0/b/deploy-141ca.appspot.com/o/y2mate.com%20-%20mvmt_social_ad_vertical_video_bjH6DShpolY_1080p.mp4?alt=media&token=6fd2dd4e-5890-4ba4-98b1-393c962dc053"])
                
                ref?.child("Users").child(uid).updateChildValues(["Approved" : "False"])

                self.thankyou.alpha = 1
                self.passwordtf.alpha = 0
                self.domaintf.alpha = 0
                self.emailtf.alpha = 0
                self.nametf.alpha = 0
                self.tapsign.alpha = 0
                self.pdtf.alpha = 0
                self.pn2tf.alpha = 0
                self.pdtf.alpha = 0
               self.pntf.alpha = 0
                self.pricetf.alpha = 0
                self.demo.alpha = 0
            }
            
        }
        
    }
    
    @IBOutlet weak var demo: UILabel!
    @IBOutlet weak var tapcreate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        requestlabel.addCharacterSpacing()
        thankyou.alpha = 0
        ref = Database.database().reference()
        
        emailtf.delegate = self
        passwordtf.delegate = self
        nametf.delegate = self
        domaintf.delegate = self
//        emailtf.becomeFirstResponder()
        
        tapcreate.layer.cornerRadius = 22.0
        tapcreate.layer.masksToBounds = true
        
        errorlabel.alpha = 0
        FBSDKAppEvents.logEvent("LoginScreen")
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

            
            
        } else {
            
            emailtf.alpha = 0
            passwordtf.alpha = 0
            
            
            
        }
        
        self.addLineToView(view: passwordtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: pntf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: pdtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: pn2tf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: pdtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: nametf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: emailtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                self.addLineToView(view: domaintf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
                        self.addLineToView(view: pricetf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        
    }
    
    @IBOutlet weak var requestlabel: UILabel!
    @IBOutlet weak var errorlabel: UILabel!
    
    
    
    
    
    
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

extension UILabel {
    func addCharacterSpacing(kernValue: Double = 2.0) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
