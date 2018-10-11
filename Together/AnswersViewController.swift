//
//  AnswersViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 10/8/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var ids = [String]()
var names = [String:String]()
var photos = [String:UIImage]()
var numbahs = [String:String]()
var answers = [String:String]()
var verifications = [String:String]()

class AnswersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func tapUp2(_ sender: Any) {
    }
    @IBAction func tapDown2(_ sender: Any) {
    }
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func tapAnswer(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        question.text = selectedquestion
        number.text = selectednumber
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
        
        //        loaddictionary()
//        loaddummyanswers()
        queryforids { () -> () in
            
            self.queryforidvalues()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loaddummyanswers() {
        
        ref?.child("Responses").child(selectedid).childByAutoId().updateChildValues(["Name" : "Chris Bissell", "Votes" : "152", "Verification" : "Yes", "Text" : "Fuck Me" ])
    }
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        ids.removeAll()
        names.removeAll()
        photos.removeAll()
        numbahs.removeAll()
        answers.removeAll()

        ref?.child("Responses").child(selectedid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids2 = each.key
                    
                    ids.append(ids2)
                    
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
        
        for each in ids {
            
            ref?.child("Responses").child(selectedid).child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var activityvalue = value?["Name"] as? String {
                    
                    names[each] = activityvalue
                    
                }
                
    
                if var activityvalue = value?["Votes"] as? String {
                    
                    numbahs[each] = activityvalue
                    
                }
                
                if var activityvalue = value?["Text"] as? String {
                    
                    answers[each] = activityvalue
                    
                }
                
                if var activityvalue = value?["Verification"] as? String {
                    
                    verifications[each] = activityvalue
                    
                }
                
                photos[each] = UIImage(named: "Chris")
                
                self.buttonspressedup[each] = "Not Pressed"
                self.buttonspresseddown[each] = "Not Pressed"
                functioncounter += 1
                
                if functioncounter == ids.count {
                    
                    self.tableView.reloadData()
                }
                
            })
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if answers.count > 0 {
            
            return answers.count
            
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    var buttonspressedup = [String:String]()
    var buttonspresseddown = [String:String]()
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Answers", for: indexPath) as! AnswersTableViewCell
        
        
        cell.tapup.addTarget(self, action: #selector(tapUp(sender:)), for: .touchUpInside)
        cell.tapdown.addTarget(self, action: #selector(tapDown(sender:)), for: .touchUpInside)
        
        cell.tapup.tag = indexPath.row
        cell.tapdown.tag = indexPath.row
        
        cell.userprofile.layer.cornerRadius = 10.0
        cell.userprofile.layer.cornerRadius = cell.userprofile.frame.height/2
        cell.userprofile.layer.masksToBounds = true
        
        if answers.count > 0 {
            
            cell.answertext.text = answers[ids[indexPath.row]]
            cell.name.text = names[ids[indexPath.row]]
            cell.userprofile.image = photos[ids[indexPath.row]]
            cell.upvotetext.text = numbahs[ids[indexPath.row]]
            
            
            if verified[ids[indexPath.row]] == "Yes" {
                
                cell.v2.alpha = 1
                
            } else {
                
                cell.v2.alpha = 0
            }
            
        } else {

            
        }
        
        return cell
    }
    
    @objc func tapUp(sender: UIButton){
        
        let buttonTag = sender.tag
        
        if buttonspressedup[ids[buttonTag]] == "Pressed" as String? {
            
            
        } else {
            
            
            var originalnumber = numbahs[ids[buttonTag]]
            var newnumber = Int(originalnumber!)! + 1
            var stringnewnumber = String(newnumber)
            numbahs[ids[buttonTag]] = stringnewnumber
            ref?.child("Responses").child(selectedid).child(ids[buttonTag]).updateChildValues(["Votes" : stringnewnumber])
            buttonspressedup[ids[buttonTag]] = "Pressed"
            
            tableView.reloadData()
        }
    }
    
    @objc func tapDown(sender: UIButton){
        let buttonTag = sender.tag
        
        if buttonspresseddown[ids[buttonTag]] == "Pressed" as String? {
            
            
        } else {
            
            
            var originalnumber = numbahs[ids[buttonTag]]
            var newnumber = Int(originalnumber!)! - 1
            var stringnewnumber = String(newnumber)
            numbahs[ids[buttonTag]] = stringnewnumber
            ref?.child("Responses").child(selectedid).child(ids[buttonTag]).updateChildValues(["Votes" : stringnewnumber])
            buttonspresseddown[ids[buttonTag]] = "Pressed"
            
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
