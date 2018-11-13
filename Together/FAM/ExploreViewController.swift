//
//  ExploreViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/7/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var images = [String:UIImage]()
var names = [String:String]()
var prices = [String:String]()
var descriptions = [String:String]()
var programnames = [String:String]()
var projectids = [String]()
var selectedimage = UIImage()
var toppics = [String:UIImage]()

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
                    
                }
                
                if var author2 = value?["Description"] as? String {
                    descriptions[each] = author2
                    
                }
                if var name = value?["Name"] as? String {
                    names[each] = name
                    
                }
                
                if var views = value?["Price"] as? String {
                    prices[each] = views
                    functioncounter += 1

                }
                
                if var views = value?["ProgramName"] as? String {
                    programnames[each] = views
                    
                }
                
                
                
                images[each] = UIImage(named: "\(each)")
                
                toppics[each] = UIImage(named: "\(each)pic")
                
                
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
        
        if subscribers.count > 0 {
            
            return subscribers.count

        } else {
            
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Explore", for: indexPath) as! ExploreTableViewCell
        
        if names.count > indexPath.row && subscribers.count > indexPath.row {
            
//            cell.layer.borderWidth = 1.0
//            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.subscriber.addTarget(self, action: #selector(tapJoin(sender:)), for: .touchUpInside)

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            //            return 425
            return UITableViewAutomaticDimension
            
    }
    
    @objc func tapJoin(sender: UIButton){
        
        let buttonTag = sender.tag
        
        selectedid = projectids[buttonTag]
        selectedimage = images[projectids[buttonTag]]!
        selectedname = names[projectids[buttonTag]]!
        selectedpitch = descriptions[projectids[buttonTag]]!
        selectedprice = prices[projectids[buttonTag]]!
        //        selectedprogramnames = programnames[projectids[buttonTag]]!
        selectedsubs = subscribers[projectids[buttonTag]]!
        selectedprogramname = programnames[projectids[buttonTag]]!
        
        self.performSegue(withIdentifier: "DiscoverToContent", sender: self)
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

var selectedprogramname = String()
