//
//  MyFamViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/8/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

class MyFamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference()
        
        queryforids { () -> () in
            
            self.queryforinfo()
            
        }

        // Do any additional setup after loading the view.
    }
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        projectids.removeAll()
        descriptions.removeAll()
        names.removeAll()
        programnames.removeAll()
        prices.removeAll()
        toppics.removeAll()
        ref?.child("Influencers").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    projectids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
    }
    
    var subscribers = [String:String]()
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        for each in projectids {
            
            
            ref?.child("Influencers").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Subscribers"] as? String {
                    self.subscribers[each] = author2
                    
                } else {
                    
                    self.subscribers[each] = "0"

                }
                
                if var author2 = value?["Description"] as? String {
                    descriptions[each] = author2
                    
                } else {
                    descriptions[each] = "-"

                    
                }
                if var name = value?["Name"] as? String {
                    names[each] = name
                    
                } else {
                    
                    names[each] = "-"

                }
                
                if var views = value?["Price"] as? String {
                    prices[each] = views
                    
                } else {
                    
                    prices[each] = "0"

                }
                
                if var views = value?["ProgramName"] as? String {
                    programnames[each] = views
                    
                } else {
                    
                    programnames[each] = "-"

                }
                
                
                
                images[each] = UIImage(named: "\(each)")
                
                toppics[each] = UIImage(named: "\(each)pic")
                
                functioncounter += 1
                
                print(functioncounter)
                
                
                
                if functioncounter == projectids.count {
                    
                    self.tableView.reloadData()
                    
                }
                
                
            })
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedid = projectids[indexPath.row]
        selectedimage = images[projectids[indexPath.row]]!
        selectedname = names[projectids[indexPath.row]]!
        selectedpitch = descriptions[projectids[indexPath.row]]!
        selectedprice = prices[projectids[indexPath.row]]!
        //        selectedprogramnames = programnames[projectids[indexPath.row]]!
        selectedsubs = subscribers[projectids[indexPath.row]]!
        selectedprogramname = programnames[projectids[indexPath.row]]!
        
        self.performSegue(withIdentifier: "DiscoverToContent", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return names.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Explore", for: indexPath) as! ExploreTableViewCell
        
        if names.count > indexPath.row {
            
            //            cell.layer.borderWidth = 1.0
            //            cell.layer.borderColor = UIColor.lightGray.cgColor
            
            cell.layer.cornerRadius = 3.0
            cell.layer.masksToBounds = true
            cell.name.text = names[projectids[indexPath.row]]
            cell.descriptionlabel.text = descriptions[projectids[indexPath.row]]
            cell.programname.text = programnames[projectids[indexPath.row]]
            cell.name.text = names[projectids[indexPath.row]]
            cell.profilepic.image = images[projectids[indexPath.row]]
            cell.subscribercount.text = "\(subscribers[projectids[indexPath.row]]!) subscribers"
            cell.toppic.image = toppics[projectids[indexPath.row]]
            cell.price.text = "$\(prices[projectids[indexPath.row]]!)/mo"
            
            
            
        } else {
            
            
        }
        
        
        return cell
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
