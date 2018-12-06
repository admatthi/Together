//
//  ShippingViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/29/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

class ShippingViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var billinglabel: UILabel!
    
    @IBOutlet weak var billingname: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var streetaddress: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var apt: UITextField!
    @IBOutlet weak var city: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        billinglabel.addCharacterSpacing()
        header.addCharacterSpacing()
        billingname.becomeFirstResponder()
        
        queryforuser()
        
        self.addLineToView(view: city, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        self.addLineToView(view: streetaddress, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        
        self.addLineToView(view: zip, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        
        self.addLineToView(view: country, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        
        self.addLineToView(view: billingname, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        
        self.addLineToView(view: phonenumber, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        self.addLineToView(view: apt, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var errorlabel: UILabel!
    @IBAction func tapSave(_ sender: Any) {
        
       
        if billingname.text != "" && phonenumber.text != "" &&  country.text != "" &&  zip.text != "" &&  streetaddress.text != "" &&  city.text != ""  {
            ref!.child("Jewelery").child("Users").child(uid).updateChildValues(["Street" : streetaddress.text!])
        ref!.child("Jewelery").child("Users").child(uid).child("Shipping").child("ShippingMain").updateChildValues(["Name" : billingname.text!, "Phone" : phonenumber.text!, "Country" : country.text!, "Zip" : zip.text!, "Street Address" : streetaddress.text!, "Apt" : apt.text!, "City" : city.text!])
            
            self.performSegue(withIdentifier: "ShippingToCheckout", sender: self)
            
        } else {
            
            errorlabel.alpha = 1
        }
        
        
    }
    
    @IBOutlet weak var header: UILabel!
    func queryforuser() {
        
        ref?.child("Jewelery").child("Users").child(uid).child("Shipping").child("ShippingMain").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var author2 = value?["Name"] as? String {
                
                self.billingname.text! = author2
                
            }
            
            if var author2 = value?["Phone"] as? String {
                
                self.phonenumber.text! = author2
                
            }
            
            
            if var author2 = value?["Country"] as? String {
                
                self.country.text! = author2
                
            }
            
            
            if var author2 = value?["Zip"] as? String {
                
                self.zip.text! = author2
                
            }
            
            
            if var author2 = value?["Street Address"] as? String {
                
                self.streetaddress.text! = author2
                
            }
            
            
            if var author2 = value?["Apt"] as? String {
                
                self.apt.text! = author2
                
            }
            
            
            if var author2 = value?["City"] as? String {
                
                self.city.text! = author2
                
            }
            
            
        })
        
    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
