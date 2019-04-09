//
//  Overview5ViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 4/9/19.
//  Copyright © 2019 AA Tech. All rights reserved.
//

import UIKit

class Overview5ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tf2: UITextField!
    
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf1: UITextField!
    
    @IBAction func tapContinue(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tf1.becomeFirstResponder()
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
