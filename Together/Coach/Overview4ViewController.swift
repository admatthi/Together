//
//  Overview4ViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 4/9/19.
//  Copyright © 2019 AA Tech. All rights reserved.
//

import UIKit

class Overview4ViewController: UIViewController, UITextFieldDelegate {

    @IBAction func tapContinue(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    
    }
    
    
    @IBOutlet weak var tf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        tf.becomeFirstResponder()
        
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
