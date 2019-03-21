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
var wantdescriptions = [String:String]()
var wantusedprices = [String:String]()
var wantnewprices = [String:String]()
var wantbrandnames = [String:String]()

var wantk1 = [String:String]()
var wantv1 = [String:String]()
var wantk2 = [String:String]()
var wantv2 = [String:String]()
var wantk3 = [String:String]()
var wantv3 = [String:String]()
var wantk4 = [String:String]()
var wantv4 = [String:String]()
var wantk5 = [String:String]()
var wantv5 = [String:String]()
var wantk6 = [String:String]()
var wantv6 = [String:String]()
var wantk7 = [String:String]()
var wantv7 = [String:String]()

var fucked = true




class MyOwnViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return genres.count
    }
    var orderids = [String]()

    var ordertitles = [String:String]()
    var orderimages = [String:UIImage]()
    var orderdeets = [String:String]()

    var genres = [String]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var header: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        activityIndicator.color = myblue
        errorlabel.alpha = 0
        tableView.alpha = 0
        
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
        
        wantspressed = false
        
     
            queryforids { () -> () in
                
                self.queryforinfo()
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
        orderprices.removeAll()
        orderdeets.removeAll()
        ordertitles.removeAll()
        purchasedids.removeAll()
        purchaseddates.removeAll()
        tableView.reloadData()
 ref?.child("Jewelery").child("Users").child(uid).child("Purchased").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                self.errorlabel.alpha = 0
                self.activityIndicator.alpha = 1
                for each in snapDict {
                    
                    let ids = each.key
                    
                    self.orderids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            } else {
                
                self.errorlabel.alpha = 1
                self.activityIndicator.alpha = 0
        }
            
        })
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func querywantforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        wantdescriptions.removeAll()
        programnames.removeAll()
        wantbrandnames.removeAll()
        wantusedprices.removeAll()
        wantnewprices.removeAll()
        wantk1.removeAll()
        wantv1.removeAll()
        wantk2.removeAll()
        wantv2.removeAll()
        wantk3.removeAll()
        wantv3.removeAll()
        wantk4.removeAll()
        wantv4.removeAll()
        wantk5.removeAll()
        wantv5.removeAll()
        wantk6.removeAll()
        wantv6.removeAll()
        wantk7.removeAll()
        wantv7.removeAll()
        tableView.reloadData()
        wanttitles.removeAll()
        wantids.removeAll()
        wantimages.removeAll()
        wantdeets.removeAll()
        wanttitles.removeAll()
        tableView.reloadData()
        
 ref?.child("Jewelery").child("Users").child(uid).child("Want").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                self.errorlabel.alpha = 0
                self.activityIndicator.alpha = 1
                for each in snapDict {
                    
                    let ids = each.key
                    
                    self.wantids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            } else {
                
                self.errorlabel.alpha = 1
                self.activityIndicator.alpha = 0
    }
            
        })
    }
    
    var purchasedids = [String:String]()
    var purchaseddates = [String:String]()
    var orderprices = [String:String]()
    func queryforinfo() {
        
        var functioncounter = 0
        
        for each in orderids {
            ref?.child("Jewelery").child("Users").child(uid).child("Purchased").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Price"] as? String {
                    self.orderprices[each] = author2
                    
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
                    
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.color = myblue
                    self.activityIndicator.alpha = 0
                    self.tableView.alpha = 1
                    self.tableView.reloadData()
                }
                
                
            })
            
        }
    }
    
    func queryforwantinfo() {
        
        var functioncounter = 0
        
        
        for each in wantids {
            
            
            ref?.child("Products").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
           
                
                if var author2 = value?["Used Price"] as? Int {
                    
                    
                    var intviews = Double(author2)
                    var author3 = "$\(String(Int(intviews)))"
                    self.wantprices[each] = author3
                    wantusedprices[each] = author3
                }
                
                if var author2 = value?["New Price"] as? Int {
                    
                    
                    var intviews = Double(author2)
                    var author3 = "$\(String(Int(intviews)))"
                    wantnewprices[each] = author3
                }
                
                if var author2 = value?["Description"] as? String {
                    
                    wantdescriptions[each] = author2
                    
                }
                
                if var author2 = value?["Name"] as? String {
                    
                    self.wanttitles[each] = author2

                }
                
                
                
                if var profileUrl = value?["Image"] as? String {
                    // Create a storage reference from the URL
                    
                    
                    
                        let url = URL(string: profileUrl)
                        
                        if url != nil {
                            
                            if let data = try? Data(contentsOf: url!)
                                
                            {
                                if data != nil {
                                    
                                    if let selectedimage2 = UIImage(data: data) {
                                        
                                        self.wantimages[each] = selectedimage2

                                        functioncounter += 1
                                        
                                    }
                                    
                                } else {
                                    
                                    self.wantimages[each] = UIImage(named: "Watch-3")!

                                    functioncounter += 1
                                    
                                }
                                
                                
                            } else {
                                
                                self.wantimages[each] = UIImage(named: "Watch-3")

                                functioncounter += 1
                                
                            }
                            
                        }
                        
              
                }
                
                if var author2 = value?["Key 1"] as? String {
                    
                    wantk1[each] = author2
                    
                }
                
                if var author2 = value?["Value 1"] as? String {
                    
                    self.wantdeets[each] = author2
                    wantv1[each] = "\(author2)"
                } else {
                    
                    if var author2 = value?["Value 1"] as? Int {
                        
                        wantv1[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 1"] as? Double {
                            
                            wantv1[each] = "\(author2)"
                        }
                    }
                    
                }
                
                
                if var author2 = value?["Key 2"] as? String {
                    
                    wantk2[each] = author2
                    
                }
                
                if var author2 = value?["Value 2"] as? String {
                    
                    wantv2[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 2"] as? Int {
                        
                        wantv2[each] = "\(author2)"
                    } else {
                        
                        if var author2 = value?["Value 2"] as? Double {
                            
                            wantv2[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 3"] as? String {
                    
                    wantk3[each] = author2
                    
                }
                
                if var author2 = value?["Value 3"] as? String {
                    
                    wantv3[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 3"] as? Int {
                        
                        wantv3[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 3"] as? Double {
                            
                            wantv3[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 8"] as? String {
                    
                    wantk4[each] = author2
                    
                }
                
                if var author2 = value?["Value 8"] as? String {
                    
                    wantv4[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 8"] as? Int {
                        
                        v4[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 8"] as? Double {
                            
                            wantv4[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 5"] as? String {
                    
                    wantk5[each] = author2
                    
                }
                
                if var author2 = value?["Value 5"] as? String {
                    
                    wantv5[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 5"] as? Int {
                        
                        wantv5[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 5"] as? Double {
                            
                            v5[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 6"] as? String {
                    
                    wantk6[each] = author2
                    
                }
                
                if var author2 = value?["Value 6"] as? String {
                    
                    wantv6[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 6"] as? Int {
                        
                        wantv6[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 6"] as? Double {
                            
                            wantv6[each] = "\(author2)"
                        }
                    }
                    
                }
                
                if var author2 = value?["Key 7"] as? String {
                    
                    wantk7[each] = author2
                    
                }
                
                if var author2 = value?["Value 7"] as? String {
                    
                    wantv7[each] = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 7"] as? Int {
                        
                        wantv7[each] = "\(author2)"
                        
                    } else {
                        
                        if var author2 = value?["Value 7"] as? Double {
                            
                            wantv7[each] = "\(author2)"
                        }
                    }
                    
                }
                
                //                toppics[each] = UIImage(named: "\(each)pic")
                
                
                print(functioncounter)
                
                
                //                if functioncounter == projectids.count {
                
                if functioncounter == self.wantids.count  {
                    
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.color = myblue
                    self.activityIndicator.alpha = 0
                    self.tableView.alpha = 1
                    self.tableView.reloadData()
                }
                
                
            })
            
        }
    }
    
    var wanttitles = [String:String]()
    var wantids = [String]()
    var wantdeets = [String:String]()
    var wantprices = [String:String]()
    var deliverydate = [String:String]()
    var wantimages = [String:UIImage]()

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
            
        self.activityIndicator.startAnimating()
        self.activityIndicator.alpha = 1
        self.tableView.alpha = 0
        
            collectionView.reloadData()

        if indexPath.row == 0 {
            
            wantspressed = false
            
            if orderimages.count > 0 {
                
                tableView.alpha = 1
                activityIndicator.alpha = 0
                tableView.reloadData()
                
            } else {
                
            queryforids { () -> () in
                
                self.queryforinfo()
            }
            
            }
        
        } else {
            
            wantspressed = true
            
            if wantimages.count > 0 {
                tableView.alpha = 1
                activityIndicator.alpha = 0
                tableView.reloadData()
            } else {
            querywantforids { () -> () in
                
                self.queryforwantinfo()
            }
                
            }
        }
    }
    
    var wantspressed = Bool()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if wantspressed == false {
            
        selectedid = orderids[indexPath.row]
        
        
        self.performSegue(withIdentifier: "wantsToCompleted", sender: self)
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        
        if wantspressed {
            
            if wantimages.count > 0 {
                
                tableView.alpha = 1
                errorlabel.alpha = 0
                return wantimages.count
                
            } else {
                tableView.alpha = 0
                errorlabel.alpha = 1
                errorlabel.text = "You haven't liked any watches yet."

            }
            
        } else {
            
            if orderimages.count > 0 {
                
                tableView.alpha = 1
                errorlabel.alpha = 0
                return orderimages.count
                
            } else {
                tableView.alpha = 0
                errorlabel.alpha = 1
                errorlabel.text = "You haven't placed any orders yet."

            }
        }
      
            
        
            errorlabel.addCharacterSpacing()
            
            return 0

        }
        
    
    
    @IBOutlet weak var taphelp: UIButton!
    @objc func tapProduct(sender: UIButton){
        
        let buttonTag = sender.tag
        
        
        selectedid = wantids[buttonTag]
        selectedimage = wantimages[wantids[buttonTag]]!
        selectedname = wanttitles[wantids[buttonTag]]!

        selecteddescription = wantdescriptions[wantids[buttonTag]]!
        //        selectedpitch = wantdescriptions[projectids[indexPath.row]]!
        //        selectedprice = wantusedprices[projectids[indexPath.row]]!
        
        //        selectedprogramnames = programnames[projectids[indexPath.row]]!
        selectedusedprice = wantusedprices[wantids[buttonTag]]!
        selectednewprice = wantnewprices[wantids[buttonTag]]!
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
       
//        cell.price.layer.bwantWidth = 0.5
//        
//        cell.price.layer.bwantColor = UIColor.lightGray.cgColor
        if wantspressed {
            
            cell.tapsell.alpha = 0

            
            if wantimages.count > 0 {
                
                cell.mainimage.image = wantimages[wantids[indexPath.row]]
                cell.title.text = wanttitles[wantids[indexPath.row]]?.uppercased()
                cell.title.addCharacterSpacing()
                cell.price.text = wantprices[wantids[indexPath.row]]
                cell.details.text = "\(wantdeets[wantids[indexPath.row]]!.uppercased())"
                cell.details.addCharacterSpacing()
                cell.delivery.text = "LAST SALE  \([wantprices[wantids[indexPath.row]]!.uppercased())"
                cell.delivery.addCharacterSpacing()
                
                
                
            }
            
        } else {
            
            cell.tapsell.alpha = 1

            if orderimages.count > 0 {
                
             
                cell.mainimage.image = orderimages[orderids[indexPath.row]]
                cell.title.text = ordertitles[orderids[indexPath.row]]?.uppercased()
                cell.title.addCharacterSpacing()
                cell.price.text = "$\(orderprices[orderids[indexPath.row]]!)"
                cell.details.text = "\(purchaseddates[orderids[indexPath.row]]!.uppercased()) / \(orderdeets[orderids[indexPath.row]]!.uppercased())"
                cell.details.addCharacterSpacing()
                cell.delivery.text = deliverydate[orderids[indexPath.row]]?.uppercased()
                cell.delivery.addCharacterSpacing()
                
            }
        }
        
        return cell
    }
    

}
