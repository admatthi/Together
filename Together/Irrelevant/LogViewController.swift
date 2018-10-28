//
//  LogViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 10/3/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var habits = [String:String]()
var numbers = [String:String]()
var selectedquestion = String()
var selectednumber = String()
var verified = [String:String]()
var responses = [String:String]()
var questionids = [String]()
var selectedid = String()

class LogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
        
//        loaddictionary()
        
        queryforids { () -> () in
            
            self.queryforidvalues()
            
        }
        

        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loaddictionary() {
        
    
        
        ref?.child("TopQuestions").childByAutoId().updateChildValues(["Text" : "What are the best exercises to reduce double chin?", "Responses" : "15", "Verified" : "Yes", "Votes" : "142"])
        
        ref?.child("TopQuestions").childByAutoId().updateChildValues(["Text" : "Are there any side effects of drinking too much lemon water?", "Responses" : "25", "Verified" : "Yes", "Votes" : "123"])
        
        ref?.child("TopQuestions").childByAutoId().updateChildValues(["Text" : "What are some snacks that are OK to eat at night?", "Responses" : "35", "Verified" : "No", "Votes" : "322"])
        
        ref?.child("TopQuestions").childByAutoId().updateChildValues(["Text" : "What are the best exercises to reduce double chin?", "Responses" : "45", "Verified" : "No", "Votes" : "441"])
        
        ref?.child("TopQuestions").childByAutoId().updateChildValues(["Text" : "Are there any side effects of drinking too much lemon water?", "Responses" : "7", "Verified" : "No", "Votes" : "12"])
        
        ref?.child("TopQuestions").childByAutoId().updateChildValues(["Text" : "What are some snacks that are OK to eat at night?", "Responses" : "8", "Verified" : "No", "Votes" : "326"])
        
        ref?.child("TopQuestions").childByAutoId().updateChildValues(["Text" : "What are the worst foods to eat for breakfast?", "Responses" : "3", "Verified" : "No", "Votes" : "432"])
        
        ref?.child("TopQuestions").childByAutoId().updateChildValues(["Text" : "Is Alkaline Water Extra Healthy or a Hoax?", "Responses" : "22", "Verified" : "No", "Votes" : "123"])
        
        ref?.child("TopQuestions").childByAutoId().updateChildValues(["Text" : "I hate doing sit ups. Is there anyway to still get a six pack?", "Responses" : "41", "Verified" : "Yes", "Votes" : "642"])
        
        ref?.child("TopQuestions").childByAutoId().updateChildValues(["Text" : "Is Alkaline Water Extra Healthy or a Hoax?", "Responses" : "32", "Verified" : "No", "Votes" : "123"])
        
        ref?.child("TopQuestions").childByAutoId().updateChildValues(["Text" : "Is it true that it's not a good idea to do the same exercises?", "Responses" : "18", "Verified" : "No", "Votes" : "52"])
        

 
        
        tableView.reloadData()
    }
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        habits.removeAll()
        numbers.removeAll()
        responses.removeAll()
        verified.removeAll()
        
        ref?.child("TopQuestions").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    questionids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
    }
    
    func queryforidvalues() {
        
        var functioncounter = 0
        
        for each in questionids {
            
            ref?.child("TopQuestions").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var activityvalue = value?["Text"] as? String {
                    
                    habits[each] = activityvalue
                    
                }
                
                
                if var activityvalue = value?["Responses"] as? String {
                    
                    responses[each] = activityvalue
                    
                }
                
                if var activityvalue = value?["Verified"] as? String {
                    
                    verified[each] = activityvalue
                    
                }
                
                if var activityvalue = value?["Votes"] as? String {
                    
                    numbers[each] = activityvalue
                    
                }
                
                self.buttonspressedup[each] = "Not Pressed"
                self.buttonspresseddown[each] = "Not Pressed"

                functioncounter += 1
                
                if functioncounter == questionids.count {
                    
                    self.tableView.reloadData()
                }
                
            })
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if habits.count > 0 {
            
            return habits.count
            
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedquestion = habits[questionids[indexPath.row]]!
        selectednumber = numbers[questionids[indexPath.row]]!
        selectedid = questionids[indexPath.row]
        
        self.performSegue(withIdentifier: "QuestionToAnswer", sender: self)
        
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Log", for: indexPath) as! LogTableViewCell
        
        cell.tapup.addTarget(self, action: #selector(tapUp(sender:)), for: .touchUpInside)
        cell.tapdown.addTarget(self, action: #selector(tapDown(sender:)), for: .touchUpInside)

        cell.tapup.tag = indexPath.row
        cell.tapdown.tag = indexPath.row
        
        if habits.count > 0 {
            
            cell.habit.text = habits[questionids[indexPath.row]]
            cell.number.text = numbers[questionids[indexPath.row]]
            
            cell.responses.text = "\(responses[questionids[indexPath.row]]!) responses"
            
            if verified[questionids[indexPath.row]] == "Yes" {
                
                cell.verified.alpha = 1
                
            } else {
                
                cell.verified.alpha = 0
            }
        } else {
            
            cell.habit.text = ""
            cell.number.text = ""
            
        }
     
        return cell
    }
    
    var buttonspressedup = [String:String]()
    var buttonspresseddown = [String:String]()

    @objc func tapUp(sender: UIButton){
        
        let buttonTag = sender.tag

        if buttonspressedup[questionids[buttonTag]] == "Pressed" as String? {
            
            
        } else {
            
            
            var originalnumber = numbers[questionids[buttonTag]]
            var newnumber = Int(originalnumber!)! + 1
            var stringnewnumber = String(newnumber)
            numbers[questionids[buttonTag]] = stringnewnumber
            ref?.child("TopQuestions").child(questionids[buttonTag]).updateChildValues(["Votes" : stringnewnumber])
            buttonspressedup[questionids[buttonTag]] = "Pressed"
            
            tableView.reloadData()
        }
    }
    
    @objc func tapDown(sender: UIButton){
        let buttonTag = sender.tag
        
        if buttonspresseddown[questionids[buttonTag]] == "Pressed" as String? {
            
            
        } else {
            
            
            var originalnumber = numbers[questionids[buttonTag]]
            var newnumber = Int(originalnumber!)! - 1
            var stringnewnumber = String(newnumber)
            numbers[questionids[buttonTag]] = stringnewnumber
            ref?.child("TopQuestions").child(questionids[buttonTag]).updateChildValues(["Votes" : stringnewnumber])
            buttonspresseddown[questionids[buttonTag]] = "Pressed"

            tableView.reloadData()
        }
    
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
