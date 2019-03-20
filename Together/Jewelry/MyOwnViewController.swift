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
import AVFoundation
import Purchases

var selectedcondition = String()

var fucked = true
class MyOwnViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return genres.count
    }
    
 var genres = [String]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var header: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        fucked = false
        genres.removeAll()
        genres.append("ORDERS")
        genres.append("WANT")
        ref = Database.database().reference()

        taphelp.layer.borderColor = UIColor.black.cgColor
        taphelp.addTextSpacing(2.0)
        taphelp.layer.borderWidth = 0.5
        
        header.addCharacterSpacing()
        selectedindex = 0
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        orderspressed = true
        
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
        purchasedids.removeAll()
        purchaseddates.removeAll()
        tableView.reloadData()
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
    
    @IBOutlet weak var collectionView: UICollectionView!
    func querywantforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        tableView.reloadData()
        ordertitles.removeAll()
        orderids.removeAll()
        orderimages.removeAll()
        deliverydate.removeAll()
        orderdeets.removeAll()
        ordertitles.removeAll()
        purchasedids.removeAll()
        purchaseddates.removeAll()
        tableView.reloadData()
 ref?.child("Jewelery").child("Users").child(uid).child("Want").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
    
    var purchasedids = [String:String]()
    var purchaseddates = [String:String]()
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
                
                if var name = value?["Product ID"] as? String {
                    self.purchasedids[each] = name
                    
                }
                
                if var name = value?["Date"] as? String {
                    self.purchaseddates[each] = name
                    
                }

                
                if var profileUrl = value?["Image"] as? String {
                    // Create a storage reference from the URL
                    
                    let url = URL(string: profileUrl)
                    do {
                        
                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        
                        if data != nil {
                        if let selectedimage2 = UIImage(data: data!) {
                            
                            selectedimage = selectedimage2
                            
                        }
                            
                        } else {
                            
                            selectedimage = UIImage(named: "Watch-3")!

                        }
                        
                    } catch let error {
                        
                        selectedimage = UIImage(named: "Watch-3")!
                    }
                    
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
    
    func queryforwantinfo() {
        
        var functioncounter = 0
        
        
        for each in orderids {
            
            
            ref?.child("Products").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
           
                
                if var author2 = value?["Used Price"] as? Int {
                    
                    
                    var intviews = Double(author2)
                    var author3 = "$\(String(Int(intviews)))"
                    self.orderpices[each] = author3
                    
                }
                
                if var author2 = value?["New Price"] as? Int {
                    
                    
                    var intviews = Double(author2)
                    var author3 = "$\(String(Int(intviews)))"
                    
                }
                
                if var author2 = value?["Description"] as? String {
                    
                    descriptions[each] = author2
                    
                }
                
                if var author2 = value?["Name"] as? String {
                    
                    self.ordertitles[each] = author2
                    names[each] = author2

                }
                
                
                
                if var profileUrl = value?["Image"] as? String {
                    // Create a storage reference from the URL
                    
                    
                        imageurls[each] = profileUrl
                        
                        let url = URL(string: profileUrl)
                        
                        if url != nil {
                            
                            if let data = try? Data(contentsOf: url!)
                                
                            {
                                if data != nil {
                                    
                                    if let selectedimage2 = UIImage(data: data) {
                                        
                                        images[each] = selectedimage2
                                        self.orderimages[each] = selectedimage2

                                        functioncounter += 1
                                        
                                    }
                                    
                                } else {
                                    
                                    images[each] = UIImage(named: "Watch-3")!
                                    functioncounter += 1
                                    
                                }
                                
                                
                            } else {
                                
                                images[each] = UIImage(named: "Watch-3")
                                
                                functioncounter += 1
                                
                            }
                            
                        }
                        
              
                }
                
                if var author2 = value?["Key 1"] as? String {
                    
                    k1[each] = author2
                    
                }
                
                if var author2 = value?["Value 1"] as? String {
                    
                    self.orderdeets[each] = author2
                    v1[each] = "\(author2)"
                } else {
                    
                    if var author2 = value?["Value 1"] as? Int {
                        
                        v1[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 1"] as? Double {
                            
                            v1[each] = "\(author2)"
                        }
                    }
                    
                }
                
                
                if var author2 = value?["Key 2"] as? String {
                    
                    k2[each] = author2
                    
                }
                
                if var author2 = value?["Value 2"] as? String {
                    
                    v2[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 2"] as? Int {
                        
                        v2[each] = "\(author2)"
                    } else {
                        
                        if var author2 = value?["Value 2"] as? Double {
                            
                            v2[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 3"] as? String {
                    
                    k3[each] = author2
                    
                }
                
                if var author2 = value?["Value 3"] as? String {
                    
                    v3[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 3"] as? Int {
                        
                        v3[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 3"] as? Double {
                            
                            v3[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 8"] as? String {
                    
                    k4[each] = author2
                    
                }
                
                if var author2 = value?["Value 8"] as? String {
                    
                    v4[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 8"] as? Int {
                        
                        v4[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 8"] as? Double {
                            
                            v4[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 5"] as? String {
                    
                    k5[each] = author2
                    
                }
                
                if var author2 = value?["Value 5"] as? String {
                    
                    v5[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 5"] as? Int {
                        
                        v5[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 5"] as? Double {
                            
                            v5[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 6"] as? String {
                    
                    k6[each] = author2
                    
                }
                
                if var author2 = value?["Value 6"] as? String {
                    
                    v6[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 6"] as? Int {
                        
                        v6[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 6"] as? Double {
                            
                            v6[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 7"] as? String {
                    
                    k7[each] = author2
                    
                }
                
                if var author2 = value?["Value 7"] as? String {
                    
                    v7[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 7"] as? Int {
                        
                        v7[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 7"] as? Double {
                            
                            v7[each] = "\(author2)"
                        }
                    }
                    
                }
                
                //                toppics[each] = UIImage(named: "\(each)pic")
                
                
                print(functioncounter)
                
                
                //                if functioncounter == projectids.count {
                
                if functioncounter == self.orderids.count  {
                    
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
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath) as! CategoriesCollectionViewCell
            
            
            cell.titlelabel.text = genres[indexPath.row].uppercased()
            cell.titlelabel.addCharacterSpacing()
            
            
            cell.selectedimage.layer.cornerRadius = 5.0
            cell.selectedimage.layer.masksToBounds = true
            
            if selectedindex == 0 {
                
                if indexPath.row == 0 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            } else {
                
                if indexPath.row == 1 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
            }
            
            return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            selectedindex = indexPath.row
            
            collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            
        
            collectionView.reloadData()

        if indexPath.row == 0 {
            
            orderspressed = true
            queryforids { () -> () in
                
                self.queryforinfo()
            }
            
        
        } else {
            
            orderspressed = false
            querywantforids { () -> () in
                
                self.queryforwantinfo()
            }
        }
    }
    
    var orderspressed = Bool()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if orderspressed {
        selectedid = orderids[indexPath.row]
        
        
        self.performSegue(withIdentifier: "OrdersToCompleted", sender: self)
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if orderimages.count > 0 {
            
            tableView.alpha = 1
            errorlabel.alpha = 0 
            return orderimages.count
            
        } else {
            
            
            tableView.alpha = 0
            errorlabel.alpha = 1

            if orderspressed {
                
                errorlabel.text = "You haven't placed any orders yet."

            } else {
                
                errorlabel.text = "You haven't liked any watches yet."

            }
            errorlabel.addCharacterSpacing()
            
            return 0

        }
        
    }
    
    @IBOutlet weak var taphelp: UIButton!
    @objc func tapProduct(sender: UIButton){
        
        let buttonTag = sender.tag
        
        
        selectedid = orderids[buttonTag]
        selectedimage = orderimages[orderids[buttonTag]]!
        selectedname = ordertitles[orderids[buttonTag]]!

        selectedimage = images[orderids[buttonTag]]!
        selectedname = names[orderids[buttonTag]]!
        selectedimageurl = imageurls[orderids[buttonTag]]!
        selecteddescription = descriptions[orderids[buttonTag]]!
        //        selectedpitch = descriptions[projectids[indexPath.row]]!
        //        selectedprice = usedprices[projectids[indexPath.row]]!
        
        //        selectedprogramnames = programnames[projectids[indexPath.row]]!
        selectedusedprice = usedprices[orderids[buttonTag]]!
        selectednewprice = newprices[orderids[buttonTag]]!
        fucked = true
        self.performSegue(withIdentifier: "WantToProduct", sender: self)
        
        fucked = true
    }
    
    @objc func tapSell(sender: UIButton){
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarBuyer : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Buyer") as! UITabBarController
        
        tabBarBuyer.selectedIndex = 2
        UIApplication.shared.keyWindow?.rootViewController = tabBarBuyer
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Orders", for: indexPath) as! OrdersTableViewCell
        
        cell.tapproduct.addTarget(self, action: #selector(MyOwnViewController.tapProduct(sender:)), for: .allTouchEvents)
        cell.selectionStyle = .none

        cell.tapproduct.tag = indexPath.row
        cell.tapsell.addTarget(self, action: #selector(MyOwnViewController.tapSell(sender:)), for: .allTouchEvents)
        cell.isUserInteractionEnabled = true
       
//        cell.price.layer.borderWidth = 0.5
//        
//        cell.price.layer.borderColor = UIColor.lightGray.cgColor
        if orderspressed {
            
            cell.tapsell.alpha = 1
            
            if orderimages.count > 0 {
                cell.mainimage.image = orderimages[orderids[indexPath.row]]
                cell.title.text = ordertitles[orderids[indexPath.row]]?.uppercased()
                cell.title.addCharacterSpacing()
                cell.price.text = "$\(orderpices[orderids[indexPath.row]]!)"
                cell.details.text = "\(purchaseddates[orderids[indexPath.row]]!.uppercased()) / \(orderdeets[orderids[indexPath.row]]!.uppercased())"
                cell.details.addCharacterSpacing()
                cell.delivery.text = deliverydate[orderids[indexPath.row]]?.uppercased()
                cell.delivery.addCharacterSpacing()
                
                
            }
            
        } else {
            
            cell.tapsell.alpha = 0
            
            if orderimages.count > 0 {
                
                cell.mainimage.image = orderimages[orderids[indexPath.row]]
                cell.title.text = ordertitles[orderids[indexPath.row]]?.uppercased()
                cell.title.addCharacterSpacing()
                cell.price.text = orderpices[orderids[indexPath.row]]
                cell.details.text = "\(orderdeets[orderids[indexPath.row]]!.uppercased())"
                cell.details.addCharacterSpacing()
                cell.delivery.text = "LAST SALE  \([orderpices[orderids[indexPath.row]]!.uppercased())"
                cell.delivery.addCharacterSpacing()
                
            }
        }
        
        return cell
    }
    

}
