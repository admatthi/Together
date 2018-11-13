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


var myprojectids = [String]()
var mydescriptions = [String:String]()
var myprogramnames = [String:String]()
var myprices = [String:String]()
var mytoppics = [String:UIImage]()
var mynames = [String:String]()
var myimages = [String:UIImage]()

class MyFamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var errorlabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference()
        
      

        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            
        tableView.alpha = 0
        errorlabel.alpha = 1
            
            
        } else {
            
            activityIndicator.alpha = 1
            activityIndicator.startAnimating()
            errorlabel.alpha = 0
            
            queryforids { () -> () in
                
                self.queryforinfo()
                
            }
            
        }
        
        // Do any additional setup after loading the view.
    }


    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        myprojectids.removeAll()
        mydescriptions.removeAll()
        mynames.removeAll()
        myprogramnames.removeAll()
        myprices.removeAll()
        mytoppics.removeAll()
        myimages.removeAll()
        
        tableView.alpha = 0
        errorlabel.alpha = 1
        activityIndicator.alpha = 0
        ref?.child("Users").child(uid).child("Purchased").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    myprojectids.append(ids)
                    self.tableView.alpha = 1
                    self.errorlabel.alpha = 0
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var subscribers = [String:String]()
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        for each in myprojectids {
            
            
            ref?.child("Influencers").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Subscribers"] as? String {
                    self.subscribers[each] = author2
                    
                } else {
                    
                    self.subscribers[each] = "0"

                }
                
                if var author2 = value?["Description"] as? String {
                    mydescriptions[each] = author2
                    
                } else {
                    mydescriptions[each] = "-"

                    
                }
                if var name = value?["Name"] as? String {
                    mynames[each] = name
                    
                } else {
                    
                    mynames[each] = "-"

                }
                
                if var views = value?["Price"] as? String {
                    myprices[each] = views
                    
                } else {
                    
                    myprices[each] = "0"

                }
                
                if var views = value?["ProgramName"] as? String {
                    myprogramnames[each] = views
                    
                } else {
                    
                    myprogramnames[each] = "-"

                }
                
                
                
                myimages[each] = UIImage(named: "\(each)")
                
                mytoppics[each] = UIImage(named: "\(each)pic")
                
                functioncounter += 1
                
                print(functioncounter)
                
                
                
                if functioncounter == myprojectids.count {
                    
                    self.activityIndicator.alpha = 0
                    self.activityIndicator.stopAnimating()
                    self.tableView.alpha = 1
                    self.tableView.reloadData()
                    
                }
                
                
            })
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedid = myprojectids[indexPath.row]
        selectedimage = myimages[myprojectids[indexPath.row]]!
        selectedname = mynames[myprojectids[indexPath.row]]!
        selectedpitch = mydescriptions[myprojectids[indexPath.row]]!
        selectedprice = myprices[myprojectids[indexPath.row]]!
        //        selectedprogrammynames = myprogramnames[myprojectids[indexPath.row]]!
        selectedsubs = subscribers[myprojectids[indexPath.row]]!
        selectedprogramname = myprogramnames[myprojectids[indexPath.row]]!
        
        self.performSegue(withIdentifier: "DiscoverToContent", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mynames.count > 0 {
            
            return mynames.count

        } else {
            
            return 0
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Explore", for: indexPath) as! ExploreTableViewCell
        
        cell.selectionStyle = .none
        if mynames.count > indexPath.row {
            
            //            cell.layer.borderWidth = 1.0
            //            cell.layer.borderColor = UIColor.lightGray.cgColor
            
            cell.layer.cornerRadius = 3.0
            cell.layer.masksToBounds = true
            cell.name.text = mynames[myprojectids[indexPath.row]]
            cell.descriptionlabel.text = mydescriptions[myprojectids[indexPath.row]]
            cell.programname.text = myprogramnames[myprojectids[indexPath.row]]
            cell.name.text = names[myprojectids[indexPath.row]]
            cell.profilepic.image = myimages[myprojectids[indexPath.row]]
            cell.subscribercount.text = "\(subscribers[myprojectids[indexPath.row]]!) subscribers"
            cell.toppic.image = mytoppics[myprojectids[indexPath.row]]
            cell.price.text = "$\(myprices[myprojectids[indexPath.row]]!)/mo"
            cell.subscriber.setTitle("See More", for: .normal)
            
            
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
