//
//  MyOwnViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/30/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import UIKit
import IQKeyboardManager
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import StoreKit
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import UXCam
import YPImagePicker
import AVFoundation
import Purchases

class MyOwnViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        
        if Auth.auth().currentUser == nil {
            
            tableView.alpha = 0
            errorlabel.alpha = 1
            errorlabel.text = "Please sign in or register to view your orders."
            errorlabel.addCharacterSpacing()
            
        } else {
            
            queryforids { () -> () in
                
                self.queryforinfo()
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        tableView.reloadData()
        ordertitles.removeAll()
        orderids.removeAll()
        orderimages.removeAll()
        deliverydate.removeAll()
        orderdeets.removeAll()
        ordertitles.removeAll()

        ref?.child("Jewelery").child("Users").child(uid).child("Purchased").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    self.orderids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
    }
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        for each in orderids {
            ref?.child("Jewelery").child("Users").child(uid).child("Purchased").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Price"] as? String {
                    self.orderpices[each] = author2
                    
                }
                
                if var author2 = value?["Title"] as? String {
                    self.ordertitles[each] = author2
                    
                }
                
                if var author2 = value?["Details"] as? String {
                    
                    self.orderdeets[each] = author2
                    
                }
                if var name = value?["Delivery"] as? String {
                    self.deliverydate[each] = name
                    
                }

                
                if var profileUrl = value?["Image"] as? String {
                    // Create a storage reference from the URL
                    
                    let url = URL(string: profileUrl)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    selectedimage = UIImage(data: data!)!
                    
                    self.orderimages[each] = selectedimage
                    
                    functioncounter += 1
                    
                }
                
                
                //                toppics[each] = UIImage(named: "\(each)pic")
                
                
                print(functioncounter)
                
                
                
                if functioncounter == self.orderids.count {
                    
                    self.tableView.reloadData()
                }
                
                
            })
            
        }
    }
    
    var ordertitles = [String:String]()
    var orderids = [String]()
    var orderdeets = [String:String]()
    var orderpices = [String:String]()
    var deliverydate = [String:String]()
    var orderimages = [String:UIImage]()

    @IBOutlet weak var errorlabel: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if orderimages.count > 0 {
            
            tableView.alpha = 1
            errorlabel.alpha = 0 
            return orderimages.count
            
        } else {
            
            
            tableView.alpha = 0
            errorlabel.alpha = 1

            errorlabel.text = "You haven't placed any orders yet."
            errorlabel.addCharacterSpacing()
            
            return 0

        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Orders", for: indexPath) as! OrdersTableViewCell
        
        if orderimages.count > 0 {
        cell.mainimage.image = orderimages[orderids[indexPath.row]]
        cell.title.text = ordertitles[orderids[indexPath.row]]?.uppercased()
        cell.title.addCharacterSpacing()
        cell.price.text = orderpices[orderids[indexPath.row]]
        cell.details.text = orderdeets[orderids[indexPath.row]]?.uppercased()
        cell.details.addCharacterSpacing()
        cell.delivery.text = deliverydate[orderids[indexPath.row]]?.uppercased()
        cell.delivery.addCharacterSpacing()
        
        }
        
        return cell
    }
    

}
