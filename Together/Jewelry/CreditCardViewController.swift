//
//  CreditCardViewController.swift
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

class CreditCardViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var apt: UITextField!
    @IBOutlet weak var streetaddress: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var billingname: UITextField!
    @IBOutlet weak var expdate: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var ccnumber: UITextField!
    @IBOutlet weak var fullnametf: UITextField!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    @IBAction func tapSave(_ sender: Any) {
        
        if fullnametf.text != "" && ccnumber.text != "" &&  cvv.text != "" &&  fullnametf.text != "" &&  expdate.text != "" &&  billingname.text != "" &&  phonenumber.text != "" &&  country.text != "" &&  zip.text != "" &&  streetaddress.text != "" &&  apt.text != "" &&  city.text != ""  {
        ref!.child("Jewelery").child("Users").child(uid).updateChildValues(["Credit Card Number" : ccnumber.text!])
        
        ref!.child("Jewelery").child("Users").child(uid).child("Payment").childByAutoId().updateChildValues(["Credit Card Number" : ccnumber.text!, "Full Name" : fullnametf.text!, "CVV" : cvv.text!, "Exp" : expdate.text!, "Billing Name" : billingname.text!, "Phone" : phonenumber.text!, "Country" : country.text!, "Zip" : zip.text!, "Street Address" : streetaddress.text!, "Apt" : apt.text!])
        
        
        if pressed {
            
            ref!.child("Jewelery").child("Users").child(uid).updateChildValues(["Street" : streetaddress.text!])
            ref!.child("Jewelery").child("Users").child(uid).child("Shipping").childByAutoId().updateChildValues(["Name" : billingname.text!, "Phone" : phonenumber.text!, "Country" : country.text!, "Zip" : zip.text!, "Street Address" : streetaddress.text!, "Apt" : apt.text!])

            
        }
            
        } else {
            
            errorlabel.alpha = 1
        }
    }
    @IBOutlet weak var errorlabel: UILabel!
    
    @IBAction func tapAddShipping(_ sender: Any) {
        
        if pressed {
            
            pressed = false
        } else {
            
            pressed = true
        }
    }
   
    
    var pressed = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
