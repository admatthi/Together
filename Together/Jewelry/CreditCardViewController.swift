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
    
    @IBOutlet weak var billinglabel: UILabel!
    @IBOutlet weak var cardlabel: UILabel!
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
        
            ref!.child("Jewelery").child("Users").child(uid).child("Payment").child("MainPayment").updateChildValues(["Credit Card Number" : ccnumber.text!, "Full Name" : fullnametf.text!, "CVV" : cvv.text!, "Exp" : expdate.text!, "Billing Name" : billingname.text!, "Phone" : phonenumber.text!, "Country" : country.text!, "Zip" : zip.text!, "Street Address" : streetaddress.text!, "Apt" : apt.text!, "City" : city.text!])
        
        
        if pressed {
            
            ref!.child("Jewelery").child("Users").child(uid).updateChildValues(["Street" : streetaddress.text!])
            ref!.child("Jewelery").child("Users").child(uid).child("Shipping").child("ShippingMain").updateChildValues(["Name" : billingname.text!, "Phone" : phonenumber.text!, "Country" : country.text!, "Zip" : zip.text!, "Street Address" : streetaddress.text!, "Apt" : apt.text!, "City" : city.text!])

            self.performSegue(withIdentifier: "CardToCheckout", sender: self)

        } else {
            
            self.performSegue(withIdentifier: "CardToCheckout", sender: self)

            }
            
        } else {
            
            errorlabel.alpha = 1
        }
    }
    @IBOutlet weak var errorlabel: UILabel!
    
    @IBOutlet weak var tapadd: UIButton!
    @IBAction func tapAddShipping(_ sender: Any) {
        
        if pressed {
            
            tapadd.setTitleColor(UIColor.black, for: .normal)
            pressed = false
        } else {
            
            tapadd.setTitleColor(UIColor.blue, for: .normal)

            pressed = true
        }
    }
   
    
    @IBOutlet weak var header: UILabel!
    var pressed = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()

        pressed = false
        
        fullnametf.becomeFirstResponder()
        header.addCharacterSpacing()
        queryforuser()
        cardlabel.addCharacterSpacing()
        billinglabel.addCharacterSpacing()
        // Do any additional setup after loading the view.
    }
    
    func queryforuser() {
        
        ref?.child("Jewelery").child("Users").child(uid).child("Payment").child("MainPayment").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var author2 = value?["Credit Card Number"] as? String {
                
                self.ccnumber.text! = author2
                
            }
            
            if var author2 = value?["Full Name"] as? String {
                
                self.fullnametf.text = author2
            }
            
            if var author2 = value?["CVV"] as? String {
                
                self.cvv.text = author2
            }
            
            if var author2 = value?["Exp"] as? String {
                
                self.expdate.text = author2
            }
            
            if var author2 = value?["Billing Name"] as? String {
                
                self.billingname.text = author2
            }
            
            if var author2 = value?["Phone"] as? String {
                
                self.phonenumber.text = author2
            }
            
            if var author2 = value?["City"] as? String {
                
                self.city.text = author2
            }
            
            if var author2 = value?["Country"] as? String {
                
                self.country.text = author2
            }
            
            if var author2 = value?["Zip"] as? String {
                
                self.zip.text = author2
            }
            
            if var author2 = value?["Street Address"] as? String {
                
                self.streetaddress.text = author2
            }
            
            if var author2 = value?["Apt"] as? String {
                
                self.apt.text = author2
            }
            
            
        })
        
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
