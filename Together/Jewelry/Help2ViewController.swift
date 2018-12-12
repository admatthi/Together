//
//  Help2ViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 12/11/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class Help2ViewController: UIViewController {

    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var question: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        question.text = squestion
        question.addCharacterSpacing()
        ref = Database.database().reference()
        
        queryforanswer()
        // Do any additional setup after loading the view.
    }
    
    func queryforanswer() {
        
        ref?.child("Help").child(squestion).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var author2 = value?["Text"] as? String {
                
                self.answer.text = author2
            }
            
        })
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
