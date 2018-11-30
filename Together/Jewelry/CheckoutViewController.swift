//
//  CheckoutViewController.swift
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

var selecteddetails = String()

class CheckoutViewController: UIViewController {
    @IBAction func tapShipping(_ sender: Any) {
    }
    
    @IBOutlet weak var totalprice: UIButton!
    @IBOutlet weak var tapshipping: UIButton!
    @IBOutlet weak var tapadd: UIButton!
    @IBAction func tapAddress(_ sender: Any) {
    }
    @IBOutlet weak var tapcc: UIButton!
    @IBAction func tapCreditCard(_ sender: Any) {
    }
    @IBAction func tapPolicy2(_ sender: Any) {
    }
    @IBOutlet weak var tappolicy2: UIButton!
    @IBOutlet weak var tappolicy1: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var detailslabel: UILabel!
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var mainimage: UIImageView!
    @IBAction func tapPolicy(_ sender: Any) {
    }
    @IBAction func tapBuy(_ sender: Any) {
    }
    @IBOutlet weak var header: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        header.addCharacterSpacing()
        price.text = selectedprice
        
        mainimage.image = selectedimage
        detailslabel.text = selecteddetails
        productname.text = selectedname
        totalprice.setTitle("$\(String(Int(selectedprice.dropFirst())!+10))", for: .normal)
        tapadd.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
           tapcc.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
           tapshipping.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
           totalprice.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        tappolicy1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center

        
        queryforuser()
        
        let buttonTitleStr = NSMutableAttributedString(string:"By proceeding, I confirm I have read and agree to the Purchases & Return Poilcy and my shipping address is correct.", attributes:attrs)
        attributedString.append(buttonTitleStr)
        tappolicy1.setAttributedTitle(attributedString, for: .normal)
        tappolicy1.setTitleColor(.black, for: .normal)
        
        
        let buttonTitleStr2 = NSMutableAttributedString(string:"This gift is final sale. View Purchases & Return Policy.", attributes:attrs2)
        attributedString2.append(buttonTitleStr2)
        tappolicy2.setAttributedTitle(attributedString2, for: .normal)
        tappolicy2.setTitleColor(.black, for: .normal)
        
        
        // Do any additional setup after loading the view.
    }
    
    var attrs = [
        NSAttributedStringKey.foregroundColor : UIColor.black,
        NSAttributedStringKey.underlineStyle : 1] as [NSAttributedStringKey : Any]
    
    var attrs2 = [NSAttributedStringKey.font : UIFont(name: "AvenirNext-Regular", size: 12.0),
                  NSAttributedStringKey.foregroundColor : UIColor.black] as [NSAttributedStringKey : Any]
    
    var attributedString = NSMutableAttributedString(string:"")
    var attributedString2 = NSMutableAttributedString(string:"")
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func queryforuser() {
        
            ref?.child("Jewelery").child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Credit Card Number"] as? String {
               
                    author2 = String(author2.suffix(4))

                    self.tapcc.setTitle("**** \(author2)", for: .normal)
                    
                }
                
                if var author2 = value?["Street"] as? String {
                    
                    self.tapadd.setTitle(author2, for: .normal)
                    
                }
                
            })
    }

}
