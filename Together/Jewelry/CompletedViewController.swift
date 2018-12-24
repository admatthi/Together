//
//  CompletedViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 12/12/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class CompletedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        topics.append("ORDER NUMBER")
        topics.append("PRICE")
        topics.append("NAME")
        topics.append("CONDITION")
        topics.append("POUCH")
        topics.append("TRACKING")
        topics.append("ORDERED ON")
        topics.append("SHIP TO")
        header.addCharacterSpacing()
        queryforinfo()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var header: UILabel!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Completed", for: indexPath) as! CompletedTableViewCell
        
        cell.selectionStyle = .none
        
        cell.category.text = topics[indexPath.row]
        cell.category.addCharacterSpacing()
        cell.cdescription.text = answers[topics[indexPath.row]]
    
        return cell
        
    }
    
    func queryforinfo() {
        
        var functioncounter = 0
        answers["ORDER NUMBER"] = selectedid
        answers["TRACKING"] = "Please Contact Us"
    ref?.child("Jewelery").child("Users").child(uid).child("Purchased").child(selectedid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Price"] as? String {
                    self.answers["PRICE"] = author2
                    
                }
                
                if var author2 = value?["Title"] as? String {
                    self.answers["NAME"] = author2
                    
                }
                
                if var author2 = value?["Condition"] as? String {
                    self.answers["CONDITION"] = author2
                    
                }
                
                if var author2 = value?["Pouch"] as? String {
                    self.answers["POUCH"] = author2
                    
                } else {
                    
                    self.answers["POUCH"] = "None"

                    }
                
                if var author2 = value?["Date"] as? String {
                    self.answers["ORDERED ON"] = "\(author2) 18"
                    
                }
                
                if var author2 = value?["Address"] as? String {
                    
                    self.answers["SHIP TO"] = author2
                    
                }
                
                self.tableView.reloadData()
                
                

            })
            
        }
    var topics = [String]()
    var answers = [String:String]()
    
    @IBAction func tapBack(_ sender: Any) {
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarBuyer : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Buyer") as! UITabBarController
        
        tabBarBuyer.selectedIndex = 1
        UIApplication.shared.keyWindow?.rootViewController = tabBarBuyer
        
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return topics.count
        
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
