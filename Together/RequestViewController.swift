//
//  RequestViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 12/22/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class RequestViewController: UIViewController, UITextViewDelegate {

    @IBAction func tapSubmit(_ sender: Any) {
        
        
        if Auth.auth().currentUser == nil {

            self.performSegue(withIdentifier: "ApplyToLogin", sender: self)
            
        } else {
            
            if bdaytf.text != "" && nametf.text != "" && addtf.text != "" {
           
            ref?.child("Sellers").childByAutoId().updateChildValues(["Full Name" : nametf.text!, "Birthday" : bdaytf.text!, "Address" : addtf.text!, "ID" : uid])
            
            addtf.alpha = 0
            bdaytf.alpha = 0
            nametf.alpha = 0
            tapsubmit.alpha = 0
            completelabel.alpha = 1
         
            headline2.alpha = 0
                
            }
        }
    }
    @IBOutlet weak var completelabel: UILabel!
    @IBOutlet weak var addtf: UITextField!
    @IBOutlet weak var bdaytf: UITextField!
    @IBOutlet weak var nametf: UITextField!
    @IBOutlet weak var tapsubmit: UIButton!
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var headline2: UILabel!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headline.addCharacterSpacing()
        ref = Database.database().reference()

        
        if Auth.auth().currentUser == nil {

            addtf.alpha = 0
            bdaytf.alpha = 0
            nametf.alpha = 0
            tapsubmit.alpha = 1
            completelabel.alpha = 1
            completelabel.text = "Only approved sellers can list on Bling. Please register or sign in to apply to sell."
            headline2.alpha = 0
            tapsubmit.setTitle("CONTINUE", for: .normal)
            tapsubmit.addTextSpacing(2.0)

            
        } else {
            
            addtf.alpha = 1
            bdaytf.alpha = 1
            nametf.alpha = 1
            tapsubmit.alpha = 1
            tapsubmit.setTitle("SUBMIT", for: .normal)
            completelabel.alpha = 0
            headline2.alpha = 1
            tapsubmit.addTextSpacing(2.0)

        }
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
