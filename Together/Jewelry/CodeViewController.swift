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
        
            if codetf.text?.uppercased() == "BIGGIESMALLS" {
                
                if used == false {
                var doublefinalprice = Double(Int(finalprice.dropFirst())!) * 0.80
                
                finalprice = "$\(String(Int(doublefinalprice)))"
                errorlabel.text = "Enjoy 20% off on your purchase : )"
                used = true
                    
                } else {
                    
                    errorlabel.text = "This code is no longer valid"

                    
                }
            } else {
                
               
                errorlabel.text = "The code you entered isn't valid."
                
            }
//            self.performSegue(withIdentifier: "BackToCheckout", sender: self)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
