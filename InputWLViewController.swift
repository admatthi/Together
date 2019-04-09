//
//  InputWLViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 3/24/19.
//  Copyright © 2019 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class InputWLViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var weighttf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        weighttf.delegate = self
//        weighttf.becomeFirstResponder()
        // Do any additional setup after loading the view.
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
