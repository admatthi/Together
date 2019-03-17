//
//  FeedbackViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 3/17/19.
//  Copyright © 2019 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class FeedbackViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tapx: UIButton!
    @IBOutlet weak var ss: UIImageView!
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var tapb: UIButton!
    @IBOutlet weak var tf: UITextView!
    @IBAction func tapX(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
    }
    @IBAction func tapB(_ sender: Any) {
        
        activityIndicator.alpha = 1
        tapx.alpha = 0
        ss.alpha = 0
        tf.alpha = 0
        tapb.alpha = 0
        header.alpha = 0
        
        activityIndicator.startAnimating()
        
        self.view.endEditing(true)
        
        if tf.text != "" {
            
            
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            
            
            
            let metaData = StorageMetadata()
            
            metaData.contentType = "image/jpg"
            
            counter += 1
            
            let filePath = "\(counter)"
            
            
            
            var data = NSData()
            data = UIImageJPEGRepresentation(screenshot, 1.0)! as NSData
            
            metaData.contentType = "image/jpg"
            
            //        let filePath = "\(counter)"
            
            storageRef.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in

                if let error = error {
                    
                    print(error.localizedDescription)
                    
                    return
                    
                } else {
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        
                        if error != nil {
                            
                            print(error!.localizedDescription)
                            ref?.child("Feedback").childByAutoId().updateChildValues(["Text" : self.tf.text!])

                            return
                        }
                        
                        if let profileImageUrl = url?.absoluteString {
                            ref?.child("Feedback").childByAutoId().updateChildValues(["Text" : self.tf.text!, "Image" : profileImageUrl])
                            
                            self.dismiss(animated: true, completion: {
                                
                            })
                            
                        }
                        
                    })
                   
                 
                    
                    
                }
                
            }
            
            
            
            
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        activityIndicator.alpha = 0
        tf.delegate = self
        ss.image = screenshot
        tf.layer.cornerRadius = 2.0
        tf.layer.masksToBounds = true
        tf.text = "Please describe what went wrong"
        tf.textColor = UIColor.lightGray
        Auth.auth().signInAnonymously() { (authResult, error) in
            // ...
        }
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please describe what went wrong"
            textView.textColor = UIColor.lightGray
        }
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
