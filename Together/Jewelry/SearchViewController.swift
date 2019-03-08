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

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        
        setTabBarVisible(visible: true, animated: true)

        if searched {
            
            
        } else {
            
            searchids.shuffle()
            collectionView.reloadData()
            collectionView.alpha = 1
        }
            
    }
    
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
        
      
        //            queryforalltheids()
        
//        queryforids { () -> () in
//
//            self.queryforinfo()
//
//        }
        
        
        // Do any additional setup after loading the view.
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        if searchBar.text == nil || searchBar.text == "" {
//
//
//        } else {
//
//
//
//        }
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searched = true
        self.view.endEditing(true)
        FBSDKAppEvents.logEvent("Searched")


        if searchBar.text != "" {
            
            FBSDKAppEvents.logEvent(querytext)

            
            collectionView.alpha = 0
            
            querytext = searchBar.text!
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
        
        ref?.child("Products").queryOrdered(byChild: "Brand").queryStarting(atValue: querytext).queryEnding(atValue: querytext+"\u{f8ff}").queryLimited(toFirst: 50).observeSingleEvent(of: .value, with: { (snapshot) in

            var value = snapshot.value as? NSDictionary
            
      
            
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                self.errorlabel.alpha = 0
                self.activityIndicator.alpha = 1
                self.activityIndicator.startAnimating()
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    searchids.append(ids)
                    
                    functioncounter += 1
                    
                    if snapDict.count > 14 {
                        
                        if functioncounter == 14 {
                            
                            self.beginnumber = 0
                            completed()
                            
                        }
                        
                    } else {
                        
                        if functioncounter == snapDict.count {
                            
                            self.beginnumber = 0
                            
                            completed()
                            
                        }
                        
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
        
        ref?.child("Products").queryOrdered(byChild: "Model").queryStarting(atValue: querytext).queryEnding(atValue: querytext+"\u{f8ff}").queryLimited(toFirst: 50).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            
            
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                self.errorlabel.alpha = 0
                self.activityIndicator.alpha = 1
                self.activityIndicator.startAnimating()
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    searchids.append(ids)
                    
                    functioncounter += 1
                    
                    if snapDict.count > 14 {
                        
                        if functioncounter == 14 {
                            
                            self.beginnumber = 0
                            completed()
                            
                        }
                        
                    } else {
                        
                        if functioncounter == snapDict.count {
                            
                            self.beginnumber = 0
                            
                            completed()
                            
                        }
                        
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
        
        searchids = Array(Set(searchids))
        slicedids = searchids.dropFirst(beginnumber)
        
        if slicedids.count == 0 {
            
            activityIndicator.alpha = 0

        }
        //        var slicedids = searchids
        
        //        slicedids.removeAll()
        
        //        self.collectionView.alpha = 0
        var functioncounter = 0
        
        querying = true
        
        for each in slicedids.prefix(14) {
            
            
            //        ref?.child("Products").child(each).updateChildValues(["Gender" : "Women"])
            
            
            ref?.child("Products").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Used Price"] as? Int {
                    
                    if author2 != 0 {
                        var intviews = Double(author2)
                        intviews = intviews * 1.3
                        var author3 = "$\(String(Int(intviews)))"
                        searchusedprices[each] = author3
                        
                    } else {
                        
                        if var author2 = value?["New Price"] as? String {
                            
                            var intviews = Double(Int(author2.dropFirst())!)
                            intviews = intviews * 1.3
                            author2 = "$\(String(Int(intviews)))"
                            searchusedprices[each] = author2
                            
                        }
                    }
                }
                
                if var author2 = value?["Description"] as? String {
                    searchdescriptions[each] = author2
                    
                }
                
                if var author2 = value?["Brand"] as? String {
                    
                    brandsearchnames[each] = author2
                    
                } else {
                    
                    brandsearchnames[each] = " "
                    
                }
                if var name = value?["Model"] as? String {
                    
                    
                    searchnames[each] = name
                    
                } else {
                    
                    if var name = value?["Model"] as? Int {
                        
                        
                        searchnames[each] = String(name)
                        
                    } else {
                        
                        searchnames[each] = " "
                        
                    }
                }
                
                
                
                if var views = value?["ProgramName"] as? String {
                    programsearchnames[each] = views
                    
                }
                
                if var profileUrl = value?["Image"] as? String {
                    // Create a storage reference from the URL
                    searchimageurls[each] = profileUrl
                    
                    let url = URL(string: profileUrl)
                    
                    do {
                        
                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch

                        if data != nil {
                            if let selectedimage2 = UIImage(data: data!) {
                                
                                searchimages[each] = selectedimage2
                                
                            }
                            
                        } else {
                            
                            selectedimage = UIImage(named: "Watch-3")!
                            
                        }
                        
                    } catch let error {
                        
                        searchimages[each] = UIImage(named: "Watch-3")
                    }
                    
                 
                    
                    functioncounter += 1
                    
                }
                
                
                //                searchtoppics[each] = UIImage(named: "\(each)pic")
                
                
                print(functioncounter)
                
                
                
                if functioncounter == searchids.count || functioncounter == 14 || functioncounter == self.slicedids.count {
            
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
        
        selectedbrand = brandsearchnames[searchids[indexPath.row]]!
        selectedid = searchids[indexPath.row]
        unlockedid = "0"
        selectedimage = searchimages[searchids[indexPath.row]]!
        selectedname = searchnames[searchids[indexPath.row]]!
        selectedimageurl = searchimageurls[searchids[indexPath.row]]!
        //        selectedpitch = searchdescriptions[searchids[indexPath.row]]!
        //        selectedprice = searchusedprices[searchids[indexPath.row]]!
        
        //        selectedprogramsearchnames = programsearchnames[searchids[indexPath.row]]!
        selectedsubs = searchusedprices[searchids[indexPath.row]]!
        //        selectedprogramname = programsearchnames[searchids[indexPath.row]]!
        
        self.performSegue(withIdentifier: "SearchToProduct", sender: self)
        }
    

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
  
    if slicedids.count > 0 {
        
        if searchimages.count > 0 {
            
            return searchimages.count
            
        } else {
            
            return 0
            
            }
    } else {
        
        return 0

    }
    
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tabBar = self.tabBarController?.tabBar
        
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
            
//            setTabBarVisible(visible: false, animated: true)
            
            
        }
            
        else{
            
            setTabBarVisible(visible: true, animated: true)
            
            
            //        }
            
        }
        
        
                let height = scrollView.frame.size.height
                let contentYoffset = scrollView.contentOffset.y
                let distanceFromBottom = scrollView.contentSize.height - contentYoffset
                if distanceFromBottom < height {
                    
                    if querying {
                        
                        
                        
                    } else {
                        
                        if searchids.count > beginnumber && searchids.count > 14 {

                        
                        if beginnumber == 0 {
                            
                            activityIndicator.alpha = 1
                            activityIndicator.startAnimating()
                            beginnumber = 14
                            queryforinfo()
                            querying = true
                            
                        } else {
                            
                            if beginnumber == 14 {
                                
                                activityIndicator.alpha = 1
                                activityIndicator.startAnimating()
                                beginnumber = 28
                                queryforinfo()
                                querying = true
                                
                            } else {
                                
                                if beginnumber == 28 {
                                    
                                    activityIndicator.alpha = 1
                                    activityIndicator.startAnimating()
                                    beginnumber = 42
                                    queryforinfo()
                                    querying = true
                                    
                                } else {
                                    
                                    if beginnumber == 42 {
                                        activityIndicator.alpha = 1
                                        activityIndicator.startAnimating()
                                        beginnumber = 56
                                        queryforinfo()
                                        querying = true
                                        
                                    } else {
                                        
                                        
                                        if beginnumber == 56 {
                                            activityIndicator.alpha = 1
                                            activityIndicator.startAnimating()
                                            beginnumber = 72
                                            queryforinfo()
                                            querying = true
                                        } else {
                                            
                                            if beginnumber == 72 {
                                                activityIndicator.alpha = 1
                                                activityIndicator.startAnimating()
                                                beginnumber = 42
                                                queryforinfo()
                                            }
                                        }
                                    }
                                
                                }
                            }
                            
                            }
 
                            
                        } else {
                            
                            activityIndicator.alpha = 0
                        }
                        
                    }
                    
            }
            
    }

func setTabBarVisible(visible:Bool, animated:Bool) {
    
    var isTabBarVisible: Bool {
        return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < self.view.frame.maxY
    }
    
    //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
    
    // bail if the current state matches the desired state
    if (isTabBarVisible == visible) { return }
    
    // get a frame calculation ready
    let frame = self.tabBarController?.tabBar.frame
    
    let height = frame?.size.height
    let offsetY = (visible ? -height! : height)
    
    // zero duration means no animation
    let duration:TimeInterval = (animated ? 0.3 : 0.0)
    
    //  animate the tabBar
    if frame != nil {
        UIView.animate(withDuration: duration) {
            self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
            return
        }
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
    
   
    if searchimages.count > indexPath.row  && brandsearchnames.count > indexPath.row && searchnames.count > indexPath.row && searchids.count > indexPath.row && slicedids.count > indexPath.row {
        
        cell.thumbnail.image = searchimages[searchids[indexPath.row]]
        cell.pricelabel.text = searchusedprices[searchids[indexPath.row]]?.uppercased()
        cell.pricelabel.addCharacterSpacing()
        
        print(searchids[indexPath.row])
        
        if let string2 = searchnames[searchids[indexPath.row]]?.uppercased() {
            
            cell.textlabel.text = "\(brandsearchnames[searchids[indexPath.row]]!.uppercased()) \(searchnames[searchids[indexPath.row]]!.uppercased())"
        } else {
            
            cell.textlabel.text = "\(brandsearchnames[searchids[indexPath.row]]!.uppercased()) \(searchnames[searchids[indexPath.row]]!)"
        }
        
        
        
        cell.textlabel.addCharacterSpacing()
        
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
