//
//  ShakeToReportViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 10/13/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

var counter = Int()
var logodownloadurl = String()
var screenshot = UIImage()
class ShakeToReportViewController: UIViewController, UITextViewDelegate {

    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
    }
    @IBOutlet weak var tapx: UIButton!
    @IBOutlet weak var ss: UIImageView!
    
    @IBOutlet weak var tf: UITextView!
    @IBAction func tapX(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
    }
    @IBAction func tapB(_ sender: Any) {
        
        if tf.text != "" {
            
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            
            
            
            let metaData = StorageMetadata()
            
            metaData.contentType = "image/jpg"
            
            counter += 1
            
            let filePath = "\(counter)"
            
            //        let filePath = "\(counter)"
            
            var data = NSData()
            data = UIImageJPEGRepresentation(screenshot, 1.0)! as NSData

            metaData.contentType = "image/jpg"
            storageRef.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }else{
                    //store downloadURL
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        
                        if error != nil {
                            
                            print(error!.localizedDescription)
                            
                            return
                        }
                        if let profileImageUrl = url?.absoluteString {
                        ref?.child("Feedback").childByAutoId().updateChildValues(["Text" : self.tf.text!, "Image" : profileImageUrl])
                            
                            self.dismiss(animated: true, completion: {
                                
                            })
                            
                        }
                        
                    })
                        
                        
                    //store downloadURL at database
                    
                }
                
            }
            

            
            
         
            
            
            
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            tf.text = nil
            tf.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            tf.text = "Please describe what went wrong"
            tf.textColor = UIColor.lightGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ref = Database.database().reference()
        
        tf.delegate = self
        ss.image = screenshot
        
        self.becomeFirstResponder() // To get shake gesture

        Auth.auth().signInAnonymously() { (authResult, error) in
            // ...
        }
        tf.text = "Please describe what went wrong"
        tf.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}


}
