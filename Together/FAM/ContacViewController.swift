//
//  ContacViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/17/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit


class ContacViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var tapBack: UIButton!
    
    @IBOutlet weak var tv: UITextView!
    @IBAction func tapback(_ sender: Any) {
        
                self.dismiss(animated: true, completion: {
        
                })
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == mygray {
            textView.text = ""
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Your message here..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBOutlet weak var requestlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        requestlabel.addCharacterSpacing()
        ref = Database.database().reference()
        
        tv.text = "What would you like to create?"
        tv.textColor = mygray
        
        tv.layer.borderColor = mygray.cgColor
        tv.layer.borderWidth = 0.5
        
        tv.delegate = self

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapSubmit(_ sender: Any) {
        
        if tv.text != "" {
    ref?.child("Feedback").childByAutoId().updateChildValues(["Text" : "\(tv.text!)"])
            
        }

        self.dismiss(animated: true, completion: {
            
        })

        
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
