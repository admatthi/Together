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

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var question: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        header.addCharacterSpacing()
        question.text = squestion
        question.addCharacterSpacing()
        ref = Database.database().reference()
        
        queryforanswer()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapCancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    func queryforanswer() {
        
        ref?.child("Help").child(squestion).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var author2 = value?["Text"] as? String {
                
                let attributedString = NSMutableAttributedString(string: author2)
                
                // *** Create instance of `NSMutableParagraphStyle`
                let paragraphStyle = NSMutableParagraphStyle()
                
                // *** set LineSpacing property in points ***
                paragraphStyle.lineSpacing = 10 // Whatever line spacing you want in points
                
                // *** Apply attribute to string ***
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
                
                self.answer.attributedText = attributedString
                self.answer.sizeToFit()

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
