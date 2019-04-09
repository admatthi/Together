//
//  AddWeightViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 4/9/19.
//  Copyright © 2019 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class AddWeightViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tf: UITextField!
    
    @IBOutlet weak var d1: UIButton!
    @IBOutlet weak var d2: UIButton!
    @IBOutlet weak var d3: UIButton!
    @IBOutlet weak var d4: UIButton!
    @IBOutlet weak var d5: UIButton!
    @IBOutlet weak var d6: UIButton!
    @IBOutlet weak var d7: UIButton!
    
    var startdate = String()
    var enddate = String()
    @IBOutlet weak var datelabel: UILabel!
    
    func loadrelevantday() {
        
        
    }
    
    var dayInWeek = String()
    var selectedday = String()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
        if tf.text != "" {
            
            ref!.child("Users").child(uid).child(selecteddate).updateChildValues(["Weight": "\(String(tf.text!))"])
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if tf.text != "" {
            
            ref!.child("Users").child(uid).child(selecteddate).updateChildValues(["Weight": "\(String(tf.text!))"])
            
            return true
        }
        
        return true
    }
    
    func queryforweight() {
        
        ref?.child("Users").child(uid).child(selecteddate).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if var value = snapshot.value as? NSDictionary {
            
                if var profileUrl = value["Weight"] as? String {
                // Create a storage reference from the URL
            
                self.tf.text = profileUrl
                
            }
            
            } else {
                
                self.tf.text = ""

            }
        })
            
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        tf.becomeFirstResponder()
        
        let date = Date()
        todaysdate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        dayInWeek = formatter.string(from: date)
        
        var dateFormat1 = DateFormatter()
        dateFormat1.dateFormat = "MMM d"
        
        selecteddate = dateFormat1.string(from: date)
        
        queryforweight()
        
        let startWeek = Date().startOfWeek
        let endWeek = Date().endOfWeek

        var startWeek2 = dateFormat1.string(from: startWeek!)
        var dateFormat12 = DateFormatter()
        dateFormat12.dateFormat = "MMM d"
        var endWeek2 = dateFormat12.string(from: endWeek!)
        print(startWeek2)
        print(endWeek2)
        startdate = startWeek2
        enddate = endWeek2
//        datelabel.text = "\(startdate) - \(enddate)"
        
        datelabel.text = selecteddate
        tapforward.alpha = 0

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    var todaysdate = Date()
    
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }

    @IBAction func tapBack(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        counter -= 1
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        var this2 = selecteddate
        let this3 = formatter.date(from: this2)
 
        if this3 == todaysdate {
            
            tapforward.alpha = 0
            
        } else {
            
            tapforward.alpha = 1

        }
        
        var nextdate = Calendar.current.date(byAdding: .day, value: -1, to: this3!)!
        
        selecteddate = formatter.string(from: nextdate)
        
        datelabel.text = selecteddate
        
        queryforweight()
        
        
    }


    @IBOutlet weak var tapforward: UIButton!
    
@IBAction func tapForward(_ sender: Any) {
    
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    generator.impactOccurred()
    
    counter += 1
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    var this2 = selecteddate
    let this3 = formatter.date(from: this2)
    
    var nextdate = Calendar.current.date(byAdding: .day, value: +1, to: this3!)!
    
    selecteddate = formatter.string(from: nextdate)
    
    datelabel.text = selecteddate
    
    queryforweight()
    
    }

}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
}

