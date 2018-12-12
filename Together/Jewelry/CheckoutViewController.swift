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
var selectedimageurl = String()


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
        
       
        
        if let url = NSURL(string: "http://www.joinmyfam.com/purchases"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBOutlet weak var errorlabel: UILabel!
    @IBOutlet weak var tappolicy2: UIButton!
    @IBOutlet weak var tappolicy1: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var detailslabel: UILabel!
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var mainimage: UIImageView!
    @IBAction func tapPolicy(_ sender: Any) {
        
        if let url = NSURL(string: "http://www.joinmyfam.com/purchases"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    var earlydate = String()
    var latedate = String()
    @IBAction func tapBuy(_ sender: Any) {
        
        if streetaddress != "" && finalcreditcard != "" {
            
        ref!.child("Jewelery").child("Purchases").childByAutoId().child(uid).updateChildValues(["Product ID" : selectedid, "Credit Card" : finalcreditcard, "Shipping" : streetaddress, "Date" : thisdate])
            
ref!.child("Jewelery").child("Users").child(uid).child("Purchased").childByAutoId().updateChildValues(["Product ID" : selectedid, "Price" : finalprice, "Title" : selectedname, "Details" : selecteddetails, "Delivery" : "Arriving \(earlydate) - \(latedate)", "Image" : selectedimageurl, "Date" : thisdate, "Condition" : selectedcondition, "Pouch" : selectedpackaging, "Address" : streetaddress])

            
            self.performSegue(withIdentifier: "Thank You", sender: self)

        } else {
            
            errorlabel.alpha = 1
            
        }
        
        
    }
    
    @IBOutlet weak var taptochangecc: UILabel!
    var finalprice = String()
    
    @IBOutlet weak var taptochangeshipping: UILabel!
    @IBAction func tapHelp(_ sender: Any) {
        
        self.performSegue(withIdentifier: "CheckoutToHelp", sender: self)
        
    }
    @IBOutlet weak var taphelp: UIButton!
    @IBOutlet weak var tapbuy: UIButton!
    @IBOutlet weak var header: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        taphelp.layer.borderColor = UIColor.black.cgColor
        taphelp.addTextSpacing(2.0)
        taphelp.layer.borderWidth = 0.5
        tlabel.addCharacterSpacing()
        slabel.addCharacterSpacing()
        shlabel.addCharacterSpacing()
        plabel.addCharacterSpacing()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM dd"
        thisdate = dateFormatter.string(from: date)
        let calendar = Calendar.current

        let earlyD = calendar.date(byAdding: .weekday, value: 7, to: date)
        let lateD = calendar.date(byAdding: .weekday, value: 9, to: date)

        earlydate = dateFormatter.string(from: earlyD!)
        latedate = dateFormatter.string(from: lateD!)
        
        tapbuy.addTextSpacing(2.0)
        
        if selectedcondition == "New" {
            
            finalprice = "$\(String(Int(selectedprice.dropFirst())!))"

            tappolicy2.setTitle("All shipping and returns are complimentary on this order.", for: .normal)
            tappolicy2.isUserInteractionEnabled = false
            
        tappolicy2.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            tapshipping.setTitle("Complimentary ($0)", for: .normal)
            tappolicy1.titleLabel?.textAlignment = NSTextAlignment.center
            tappolicy2.titleLabel?.textAlignment = NSTextAlignment.center
            totalprice.setTitle(finalprice, for: .normal)

        } else {
            
            finalprice = "$\(String(Int(selectedprice.dropFirst())!+10))"

            let buttonTitleStr2 = NSMutableAttributedString(string:"View Purchases & Return Policy", attributes:attrs2)
            attributedString2.append(buttonTitleStr2)
            tappolicy2.setAttributedTitle(attributedString2, for: .normal)
            tappolicy2.setTitleColor(.black, for: .normal)
            tappolicy2.titleLabel?.textAlignment = NSTextAlignment.center
            tappolicy1.titleLabel?.textAlignment = NSTextAlignment.center
            totalprice.setTitle(finalprice, for: .normal)


        }
        
        
        header.addCharacterSpacing()
        price.text = selectedprice
        
        mainimage.image = selectedimage
        detailslabel.text = "\(selecteddetails.uppercased()) / \(selectedprice)"
        productname.text = "\(selectedbrand.uppercased()) \(selectedname.uppercased())"
        detailslabel.addCharacterSpacing()
        productname.addCharacterSpacing()
        
        tapadd.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
           tapcc.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
           tapshipping.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
           totalprice.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        tappolicy1.titleLabel?.textAlignment = NSTextAlignment.center

        
        queryforuser()
        
        let buttonTitleStr = NSMutableAttributedString(string:"By proceeding, I confirm I have read and agree to the Purchases & Return Policy and my shipping address is correct.", attributes:attrs)
        attributedString.append(buttonTitleStr)
//        tappolicy1.setAttributedTitle(attributedString, for: .normal)
//        tappolicy1.setTitleColor(.black, for: .normal)
        
        detailslabel.addCharacterSpacing()
        productname.addCharacterSpacing()
   
        tapadd.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        tapcc.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        tapshipping.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        totalprice.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        tappolicy1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        tappolicy2.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center

        
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
    
    var finalcreditcard = String()
    @IBOutlet weak var plabel: UILabel!
    
    @IBOutlet weak var shlabel: UILabel!
    @IBOutlet weak var slabel: UILabel!
    @IBOutlet weak var tlabel: UILabel!
    func queryforuser() {
            ref?.child("Jewelery").child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Credit Card Number"] as? String {
               
                    self.finalcreditcard = author2

                    author2 = String(author2.suffix(4))

                    self.tapcc.setTitle("**** \(author2)", for: .normal)
                    self.taptochangecc.alpha = 1
                } else {
                    
                    self.finalcreditcard = ""
                    self.taptochangecc.alpha = 0
                }
                
                if var author2 = value?["Street"] as? String {
                    
                    self.streetaddress = author2
                    self.tapadd.setTitle(author2, for: .normal)
                    self.taptochangeshipping.alpha = 1
                } else {
                    
                    self.streetaddress = ""
                    self.taptochangeshipping.alpha = 0
                }
                
            })
    }
    
    var streetaddress = String()
    
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
  
    // Note: this delegate method is optional. If you do not need to collect a
    // shipping method from your user, you should not implement this method


}
