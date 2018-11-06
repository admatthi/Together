//
//  Discover2ViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 10/28/18.
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
var titles = [String:String]()
var prices = [String:String]()
var descriptions = [String:String]()
var progress = [String:String]()
var projectids = [String]()
var selectedimage = UIImage()

class Discover2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
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
        titles.removeAll()
        progress.removeAll()
        prices.removeAll()
        ref?.child("Projects").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
    
    var longdescriptions = [String:String]()
    func queryforinfo() {
        
        var functioncounter = 0
        
        for each in projectids {
            
            
            ref?.child("Projects").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["LongDescription"] as? String {
                    self.longdescriptions[each] = author2
                    
                }
                
                if var author2 = value?["Description"] as? String {
                    descriptions[each] = author2
                    
                }
                if var name = value?["Title"] as? String {
                    titles[each] = name
                    
                }
                
                if var views = value?["Price"] as? String {
                    prices[each] = views
                    
                }
                
                if var views = value?["Progress"] as? String {
                    progress[each] = views
                    
                }
                
                images[each] = UIImage(named: "\(each)")
                
  
                
                functioncounter += 1
           
                print(functioncounter)
                
                
                
                if functioncounter == projectids.count {
                    
                    self.tableView.reloadData()
                    
                }
                
                
            })
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedimage = images[projectids[indexPath.row]]!
        selectedtitle = titles[projectids[indexPath.row]]!
        selecteddescription = descriptions[projectids[indexPath.row]]!
        selectedprice = prices[projectids[indexPath.row]]!
        selectedprogress = progress[projectids[indexPath.row]]!
        selectedlongdescription = longdescriptions[projectids[indexPath.row]]!
        
        self.performSegue(withIdentifier: "DiscoverToProject", sender: self)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
       return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Discover", for: indexPath) as! DiscoverTableViewCell
        
        if titles.count > indexPath.row {
            
        
        cell.titlelabel.text = titles[projectids[indexPath.row]]
        cell.summarylabel.text = descriptions[projectids[indexPath.row]]
        cell.percent.text = "funded"
        cell.tapfun.setTitle("\(progress[projectids[indexPath.row]]!)%", for: .normal)
        cell.titlelabel.text = titles[projectids[indexPath.row]]
        cell.productimage.image = images[projectids[indexPath.row]]
        
            var floatprogress = Float(progress[projectids[indexPath.row]]!)!/100
        cell.progressView.setProgress(floatprogress, animated: true)
            

            
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
