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
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
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
        
        if fullnametf.text != "" && ccnumber.text != "" &&  cvv.text != "" &&  fullnametf.text != "" &&  expdate.text != "" &&  billingname.text != "" &&  phonenumber.text != "" &&  country.text != "" &&  zip.text != "" &&  streetaddress.text != "" &&  city.text != ""  {
        ref!.child("Jewelery").child("Users").child(uid).updateChildValues(["Credit Card Number" : ccnumber.text!])
        
            var apttext = String()
            if apt.text == "" {
                
                apttext = " "
            } else {
                
                apttext = apt.text!
            }
            ref!.child("Jewelery").child("Users").child(uid).child("Payment").child("MainPayment").updateChildValues(["Credit Card Number" : ccnumber.text!, "Full Name" : fullnametf.text!, "CVV" : cvv.text!, "Exp" : expdate.text!, "Billing Name" : billingname.text!, "Phone" : phonenumber.text!, "Country" : country.text!, "Zip" : zip.text!, "Street Address" : streetaddress.text!, "Apt" : apttext, "City" : city.text!])
        
        
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
            
            tapadd.setTitleColor(myblue, for: .normal)

            pressed = true
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        
//            var newstring = customStringFormatting(of: ccnumber.text!)
//            
//            ccnumber.text = newstring
        
    }
   
    
    @IBOutlet weak var header: UILabel!
    var pressed = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()

        pressed = false
        ccnumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        fullnametf.becomeFirstResponder()
        header.addCharacterSpacing()
        queryforuser()
        cardlabel.addCharacterSpacing()
        billinglabel.addCharacterSpacing()
        
          self.addLineToView(view: fullnametf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        self.addLineToView(view: ccnumber, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        self.addLineToView(view: streetaddress, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        self.addLineToView(view: cvv, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        self.addLineToView(view: expdate, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        self.addLineToView(view: billingname, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        self.addLineToView(view: country, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        self.addLineToView(view: zip, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        self.addLineToView(view: apt, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

        self.addLineToView(view: city, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        self.addLineToView(view: phonenumber, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)



        
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
    
    func customStringFormatting(of str: String) -> String {
        return str.characters.chunk(n: 4)
            .map{ String($0) }.joined(separator: " ")
    }

}
extension Collection {
    public func chunk(n: IndexDistance) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
