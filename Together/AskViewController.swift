//
//  AskViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 10/8/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

class AskViewController: UIViewController, UITextViewDelegate {

    
    @IBAction func tapSubmit(_ sender: Any) {
        
        
        if tf.text != "" {
            
            var descrip = tf.text!
            ref?.child("TopQuestions").childByAutoId().updateChildValues(["Responses" : "0", "Verified" : "No", "Votes" : "0", "Text" : descrip])
            
            self.performSegue(withIdentifier: "AskToHome", sender: self)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    @IBOutlet weak var tf: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        tf.text = "What do you need help with?"
        //        tf.becomeFirstResponder()
        
        tf.textColor = UIColor.lightGray
        
        // Do any additional setup after loading the view.
    }

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

}
