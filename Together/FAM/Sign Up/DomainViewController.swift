//
//  DomainViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/13/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//
import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit


class DomainViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func tapNext(_ sender: Any) {
        
        if tf.text != "" {
            
            mypassword = tf.text!
            
            self.performSegue(withIdentifier: "Next3", sender: self)
            
        }
        
    }
    @IBOutlet weak var tapnext: UIButton!
    @IBOutlet weak var tf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        tf.delegate = self
        
        
        tapnext.layer.cornerRadius = 22.0
        tapnext.layer.masksToBounds = true
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
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
