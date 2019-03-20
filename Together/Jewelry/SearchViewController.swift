//
//  SearchViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 2/16/19.
//  Copyright © 2019 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var searched = Bool()
var searchids = [String]()

var searchdescriptions = [String:String]()
var searchnames = [String:String]()
var programsearchnames = [String:String]()
var searchusedprices = [String:String]()
var searchimages = [String:UIImage]()
var brandsearchnames = [String:String]()
var searchimageurls = [String:String]()
var searchtoppics = [String:String]()
var searchnewprices = [String:String]()
var searchinventory = [String:String]()

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        errorlabel.alpha = 0
        searched = false
        var screenSize = UIScreen.main.bounds
        var screenWidth = screenSize.width
        var screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        activityIndicator.alpha = 0
        activityIndicator.color = myblue

        collectionView.alpha = 0
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        FBSDKAppEvents.logEvent("Searched")


        if searchBar.text != "" {
            
            FBSDKAppEvents.logEvent(querytext)

            
            collectionView.alpha = 0
            
            querytext = searchBar.text!.lowercased()
            querytext = querytext.capitalized
            queryforids { () -> () in
                
                self.queryforinfo()
                
                }
            
            }
        }
    
    @IBOutlet weak var errorlabel: UILabel!
    var querytext = String()
 

    func queryforids(completed: @escaping (() -> ()) ) {

                                                           var functioncounter = 0
        
        searchids.removeAll()
        searchdescriptions.removeAll()
        searchnames.removeAll()
        programsearchnames.removeAll()
        searchusedprices.removeAll()
        searchtoppics.removeAll()
        searchimages.removeAll()
        brandsearchnames.removeAll()
        searchimageurls.removeAll()
        searchnewprices.removeAll()
        
        searchinventory.removeAll()
        ref?.child("Products").queryOrdered(byChild: "Name").queryStarting(atValue: querytext).queryEnding(atValue: querytext+"\u{f8ff}").queryLimited(toFirst: 25).observeSingleEvent(of: .value, with: { (snapshot) in

            var value = snapshot.value as? NSDictionary
            
      
            
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                self.errorlabel.alpha = 0
                self.activityIndicator.alpha = 1
                self.activityIndicator.startAnimating()
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    searchids.append(ids)
                    
                    functioncounter += 1
                    
                        
                        if functioncounter == snapDict.count {
                            
                            completed()
                            
                        }
                        
                    }
                
            } else {
                
                self.querymodel { () -> () in
                    
                    self.queryforinfo()
                    
                }
                
            }
            
        })
    }
    
    func querymodel(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        ref?.child("Products").queryOrdered(byChild: "Model").queryStarting(atValue: querytext).queryEnding(atValue: querytext+"\u{f8ff}").queryLimited(toFirst: 25).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            
            
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                self.errorlabel.alpha = 0
                self.activityIndicator.alpha = 1
                self.activityIndicator.startAnimating()
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    searchids.append(ids)
                    
                    functioncounter += 1
       
                    if functioncounter == snapDict.count {
                            
                        
                            completed()
                            
                        }
                    
                    
                    
                    
                    
                }
                
            } else {
                
                self.errorlabel.alpha = 1
                self.activityIndicator.alpha = 0
                self.activityIndicator.startAnimating()
            }
            
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    var beginnumber = Int()
    var querying = Bool()
    
    var slicedids : ArraySlice<String> = []
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        querying = true
        
        for each in searchids {
 
            ref?.child("Products").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["New Price"] as? Double {
                    
                    
                    ref!.child("Products").child(each).updateChildValues(["New Price" : Int(author2)])
                    
                    
                }
                
                if var author2 = value?["Used Price"] as? Int {
                    
                    
                    var intviews = Double(author2)
                    var author3 = "$\(String(Int(intviews)))"
                    searchusedprices[each] = author3
                    
                }
                
                if var author2 = value?["New Price"] as? Int {
                    
                    
                    var intviews = Double(author2)
                    var author3 = "$\(String(Int(intviews)))"
                    searchnewprices[each] = author3
                    
                }
                
                if var author2 = value?["Description"] as? String {
                    
                    searchdescriptions[each] = author2
                    
                }
                
                if var author2 = value?["Name"] as? String {
                    
                    searchnames[each] = author2
                    
                }
                
                
                if var author2 = value?["Inventory"] as? Int {
                    
                    
                    var intviews = Double(author2)
                    var author3 = "\(String(Int(intviews)))"
                    searchinventory[each] = author3
                    
                } else {
                    
                    searchinventory[each] = "-"
                    
                }
                
                
                
                if var profileUrl = value?["Image"] as? String {
                    // Create a storage reference from the URL
                    searchimageurls[each] = profileUrl
                    
                    let url = URL(string: profileUrl)
                    
                    if url != nil {
                        
                        if let data = try? Data(contentsOf: url!)
                            
                        {
                            if data != nil {
                                
                                if let selectedimage2 = UIImage(data: data) {
                                    
                                    searchimages[each] = selectedimage2
                                    functioncounter += 1
                                    
                                }
                                
                            } else {
                                
                                searchimages[each] = UIImage(named: "Watch-3")!
                                functioncounter += 1
                                
                            }
                            
                            
                        } else {
                            
                            searchimages[each] = UIImage(named: "Watch-3")
                            
                            functioncounter += 1
                            
                        }
                        
                    }
                    
                }
                
                if var author2 = value?["Key 1"] as? String {
                    
                    k1[each] = author2
                    
                }
                
                if var author2 = value?["Value 1"] as? String {
                    
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
                
                if functioncounter == searchids.count {
                    
                    self.activityIndicator.alpha = 0
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                    self.collectionView.alpha = 1
                    self.querying = false
                }
                
                
            })
            
        }
    }

       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedid = searchids[indexPath.row]
        unlockedid = "0"
        selectedimage = searchimages[searchids[indexPath.row]]!
        selectedname = searchnames[searchids[indexPath.row]]!
        selectedimageurl = searchimageurls[searchids[indexPath.row]]!
        selecteddescription = searchdescriptions[searchids[indexPath.row]]!

        //        selectedpitch = descriptions[projectids[indexPath.row]]!
        //        selectedprice = usedprices[projectids[indexPath.row]]!
        
        //        selectedprogramnames = programnames[projectids[indexPath.row]]!
        selectedusedprice = searchusedprices[searchids[indexPath.row]]!
        selectednewprice = searchnewprices[searchids[indexPath.row]]!
        //        selectedprogramname = programsearchnames[searchids[indexPath.row]]!
        
        leftlabel = searchinventory[searchids[indexPath.row]]!
        self.performSegue(withIdentifier: "SearchToProduct", sender: self)
        
    }
    

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
  
    
        if searchimages.count > 0 {
            
            return searchimages.count
            
        } else {
            
            return 0
            
    }
 
    
    }

 


func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "People", for: indexPath) as! PeopleCollectionViewCell
    
 
    //        cell.subscriber.tag = indexPath.row
    
    //        cell.pricelabel.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.5)
    cell.layer.borderColor = UIColor.gray.cgColor
    cell.layer.borderWidth = 0.5
    //
    //        cell.pricelabel.layer.cornerRadius = 5.0
    //        cell.pricelabel.layer.masksToBounds = true
    //        cell.layer.cornerRadius = 10.0
    //        cell.layer.masksToBounds = true
    
  
    
    if searchimages.count > indexPath.row && searchnames.count > indexPath.row{
        
  
        cell.textlabel.text = searchnames[searchids[indexPath.row]]?.uppercased()
        cell.thumbnail.image = searchimages[searchids[indexPath.row]]
        cell.pricelabel.text = searchusedprices[searchids[indexPath.row]]?.uppercased()
        cell.pricelabel.addCharacterSpacing()
        print(searchids[indexPath.row])
        
        
        cell.textlabel.addCharacterSpacing()
        
        return cell

    } else {
        
        return cell

    }
    
    
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
