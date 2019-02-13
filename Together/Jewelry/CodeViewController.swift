//
//  CodeViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 12/16/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var used = Bool()

class CodeViewController: UIViewController {
    @IBOutlet weak var codetf: UITextField!
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    @IBOutlet weak var errorlabel: UILabel!
    @IBAction func tapSubmit(_ sender: Any) {
        
        if codetf.text != "" {
        errorlabel.alpha = 1
        
            if codes.contains(codetf.text!) {
                
                if used == false {
                var doublefinalprice = Double(Int(finalprice.dropFirst())!) * 0.80
                
                finalprice = "$\(String(Int(doublefinalprice)))"
                errorlabel.text = "Enjoy 20% off on your purchase : )"
                used = true
                    self.view.endEditing(true)

                    tapsubmit.alpha = 0
                    codetf.alpha = 0
                } else {
                    
                    errorlabel.text = "This code is no longer valid"

                    
                }
                
            } else {
                
               
                errorlabel.text = "The code you entered isn't valid."
                
            }
//            self.performSegue(withIdentifier: "BackToCheckout", sender: self)
        }
        
    }
    
    var codes = [String]()
    
    func queryforcodes() {
        
        codes.removeAll()
        
        ref?.child("Codes").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var author4 = value?["Code1"] as? String {
                
                self.codes.append(author4)
                
            }
            
            if var author4 = value?["Code2"] as? String {
                
                self.codes.append(author4)
                
            }
            
            if var author4 = value?["Code3"] as? String {
                
                self.codes.append(author4)
                
            }
            
            if var author4 = value?["Code4"] as? String {
                
                self.codes.append(author4)
                
            }
            
            if var author4 = value?["Code5"] as? String {
                
                self.codes.append(author4)
                
            }
            
            if var author4 = value?["Code6"] as? String {
                
                self.codes.append(author4)
                
            }
            
        })
    }
    @IBOutlet weak var tapsubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        queryforcodes()
        errorlabel.alpha = 0
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
