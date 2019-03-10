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

var mygray = UIColor(red:0.45, green:0.43, blue:0.43, alpha:1.0)

var selectedusedprice = String()
var selectednewprice = String()
var selectedid = String()
var newprices = [String:String]()
var usedprices = [String:String]()
var brandnames = [String:String]()
var images = [String:UIImage]()
var names = [String:String]()
var prices = [String:String]()
var descriptions = [String:String]()
var programnames = [String:String]()
var projectids = [String]()
var selectedimage = UIImage()
var toppics = [String:UIImage]()
var imageurls = [String:String]()
var selectedbrand = String()
var selectedkey = String()

var k1 = [String:String]()
var v1 = [String:String]()
var k2 = [String:String]()
var v2 = [String:String]()
var k3 = [String:String]()
var v3 = [String:String]()
var k4 = [String:String]()
var v4 = [String:String]()
var k5 = [String:String]()
var v5 = [String:String]()
var k6 = [String:String]()
var v6 = [String:String]()
var k7 = [String:String]()
var v7 = [String:String]()

var minprice = Int()
class ExploreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    func load100products() {
        
        var i = 0
        
        while i < 75 {
            
ref!.child("Products2").childByAutoId().updateChildValues(["Brand" : "-","Category" : "-","Color" : "-","Description" : "-","Designer" : "-","Gemstone" : "-","Image" : "-","Name" : "-","New Link" : "-","New Price" : "-","Packaging" : "-","Purity" : "-","Size" : "-","Stone" : "-","Used Inventory" : "0","Used Link" : "-","Used Price" : 0, "Metal" : "-"])
            
            i += 1
        }
        
    }
    
    var genres = [String]()
    var viewableids = [String]()
    
    @IBOutlet weak var tapfilter: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

     
        activityIndicator.color = myblue
        tapfilter.addTextSpacing(2.0)
        ref = Database.database().reference()
        collectionView2.alpha = 1
        selectedindex = 0
        activityIndicator.startAnimating()
        collectionView.alpha = 1
        
        genres.removeAll()
        genres.append("Buy Now")
        genres.append("Best Sellers")
        genres.append("Trending")
        genres.append("Under Retail")
        genres.append("Latest")
        
            
        
        //            tapBack.alpha = 0

//        if projectids.count == 0 && selectedfilter != "" {
        
        
        collectionView.reloadData()

        if projectids.count == 0 {
        
        
                activityIndicator.alpha = 1
                activityIndicator.startAnimating()
                collectionView.alpha = 0
                tapfilter.alpha = 0
                
                projectids.removeAll()
                descriptions.removeAll()
                names.removeAll()
                programnames.removeAll()
                prices.removeAll()
                toppics.removeAll()
                images.removeAll()
                brandnames.removeAll()
                imageurls.removeAll()
            
            if selectedkey == "" {
             
                selectedfilter  = "Buy Now"
                selectedkey = "Tag1"
                
                queryforids { () -> () in
                    
                    self.queryforinfo()
                    
                }
                
            } else {
             
                
                queryforids { () -> () in
                    
                    self.queryforinfo()
                    
                }
                
            }
            
                
        } else {
            
            queryforids { () -> () in
                
                self.queryforinfo()
                
            }
        }        
            

        self.tabBarController?.tabBar.isHidden = false

        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        

    }
    
    @IBOutlet weak var tapBack: UIButton!
    @IBAction func tapback(_ sender: Any) {
    }
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        projectids.removeAll()
        descriptions.removeAll()
        names.removeAll()
        programnames.removeAll()
        prices.removeAll()
        toppics.removeAll()
        images.removeAll()
        brandnames.removeAll()
        imageurls.removeAll()
         k1.removeAll()
         v1.removeAll()
         k2.removeAll()
         v2.removeAll()
         k3.removeAll()
         v3.removeAll()
         k4.removeAll()
         v4.removeAll()
         k5.removeAll()
         v5.removeAll()
         k6.removeAll()
         v6.removeAll()
         k7.removeAll()
         v7.removeAll()
        
        collectionView.reloadData()
            
            
            if selectedkey == "Used Price" {
                
                var intselectedfilter = Int(selectedfilter)
                
                ref?.child("Products").queryOrdered(byChild: selectedkey).queryStarting(atValue: minprice).queryEnding(atValue: intselectedfilter).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    var value = snapshot.value as? NSDictionary
                    
                    if let snapDict = snapshot.value as? [String:AnyObject] {
                        
                        for each in snapDict {
                            
                            let ids = each.key
                            
                            projectids.append(ids)
                            
                            functioncounter += 1
                            
                            if snapDict.count > 14 {

                                if functioncounter == 14 {

                                    self.beginnumber = 0
                                    completed()

                                }

                            } else {
                            
                                if functioncounter == snapDict.count {
                                    
                                    self.returnednumber = snapDict.count
                                    
                                    completed()
                                    
                                }
                                
                            }
                           
                            
                           
                            
                            
                        }
                        
                    }
                    
                })
                
            } else {
                
            ref?.child("Products").queryOrdered(byChild: selectedkey).queryEqual(toValue: selectedfilter).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if let snapDict = snapshot.value as? [String:AnyObject] {
                    
                    for each in snapDict {
                        
                        let ids = each.key
                        
                        projectids.append(ids)
                        
                        functioncounter += 1
                        
                        if snapDict.count > 14 {
                            
                            if functioncounter == 14 {
                            
                                completed()
                                
                            }
                            
                        } else {
                            
                            if functioncounter == snapDict.count {
                                
                                completed()
                                
                            }
                            
                        }
                        
                        
                        
                        
                        
                    }
                    
                }
                
            })
        }
            
    }
    

    
    @IBOutlet weak var collectionView2: UICollectionView!

//    var slicedids = [String]()
    var beginnumber = Int()
    
    var slicedids : ArraySlice<String> = []

    func queryforinfo() {
        

//        slicedids = projectids
//
//        if slicedids.count == 0 {
//
//            activityIndicator.alpha = 0
//
//        }
        //        var slicedids = projectids
        
        //        slicedids.removeAll()
        
        //        self.collectionView.alpha = 0
        var functioncounter = 0
        
        querying = true
        
        for each in projectids {
//        for each in slicedids {

       
//        ref?.child("Products").child(each).updateChildValues(["Gender" : "Women"])

                
            ref?.child("Products").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Used Price"] as? Int {
                    

                    var intviews = Double(author2)
                    var author3 = "$\(String(Int(intviews)))"
                    usedprices[each] = author3
                        
                }
                
                if var author2 = value?["New Price"] as? Int {
                    
                    
                    var intviews = Double(author2)
                    var author3 = "$\(String(Int(intviews)))"
                    newprices[each] = author3
                    
                }
                
                if var author2 = value?["Description"] as? String {
                    
                        descriptions[each] = author2
                    
                }
                
                if var author2 = value?["Name"] as? String {
                    
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
                
                if var author2 = value?["Key 4"] as? String {
                    
                    k4[each] = author2

                }
                
                if var author2 = value?["Value 4"] as? String {
                    
                    v4[each] = "\(author2)"

                } else {
                    
                    if var author2 = value?["Value 4"] as? Int {
                        
                        v4[each] = "\(author2)"

                    } else {
                        
                        if var author2 = value?["Value 4"] as? Double {
                            
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

                if functioncounter == projectids.count || functioncounter == 14 {
                
                    self.activityIndicator.alpha = 0
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                    self.collectionView.alpha = 1
                    self.tapfilter.alpha = 1
                    self.querying = false
                }
                
                
            })
            
        }
    }
    
    var returnednumber = Int()
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//        if indexPath.row == projectids.count-1 {
//
////
//            queryformoreids { () -> () in
//
//
//                self.queryforinfo()
//
//            }
//        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerlabel: UILabel!
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 2 {

            let kWhateverHeightYouWant = 66
            return CGSize(width: 35, height: CGFloat(kWhateverHeightYouWant))
            
        } else {
            
        let kWhateverHeightYouWant = 82
        return CGSize(width: view.frame.width/2, height: CGFloat(kWhateverHeightYouWant))
            
        }
    }
    
    var selectedindex = Int()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 2 {
            
            beginnumber = 0
            collectionView.alpha = 0
            activityIndicator.alpha = 1
            activityIndicator.startAnimating()
            selectedindex = indexPath.row
            
        collectionView2.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.top, animated: true)


        collectionView2.reloadData()
        
            collectionView.alpha = 0
            
            if indexPath.row == 0 {
      
                if selectedkey == "" {
                    
                    selectedfilter = "Buy Now"
                    selectedkey = "Tag1"
                    
                    queryforids { () -> () in
                        
                        self.queryforinfo()
                        
                    }
                } else {
                    
                    queryforids { () -> () in
                        
                        self.queryforinfo()
                        
                    }
                    
                }
                
            }
            
            if indexPath.row == 1 {
                
                selectedfilter = "Best Sellers"
                selectedkey = "Tag1"
                
                queryforids { () -> () in
                    
                    self.queryforinfo()
                    
                }
                }
            if indexPath.row == 2 {
                
                
                selectedfilter = "Trending"
                selectedkey = "Tag1"
                queryforids { () -> () in
                    
                    self.queryforinfo()
                    
                }
            }
            
            if indexPath.row == 3 {
                
                selectedfilter = "Under Retail"
                selectedkey = "Tag1"
                queryforids { () -> () in
                    
                    self.queryforinfo()
                    
                }
            }
            
            if indexPath.row == 4 {
                
                selectedfilter = "Latest"
                selectedkey = "Tag1"
                queryforids { () -> () in
                    
                    self.queryforinfo()
                    
                }
                
            }
            
        } else {
            
        print(projectids[indexPath.row])
        selectedid = projectids[indexPath.row]
        unlockedid = "0"
        selectedimage = images[projectids[indexPath.row]]!
        selectedname = names[projectids[indexPath.row]]!
        selectedimageurl = imageurls[projectids[indexPath.row]]!
//        selectedpitch = descriptions[projectids[indexPath.row]]!
//        selectedprice = usedprices[projectids[indexPath.row]]!
        
        //        selectedprogramnames = programnames[projectids[indexPath.row]]!
        selectedusedprice = usedprices[projectids[indexPath.row]]!
        selectednewprice = newprices[projectids[indexPath.row]]!
//        selectedprogramname = programnames[projectids[indexPath.row]]!
        
        self.performSegue(withIdentifier: "ExploreToVideos", sender: self)
        }
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 2 {
            
            return genres.count
            
        } else {
            
        if images.count > 0 {
            
            return images.count
            
        } else {
            
            return 0
        }
     
        }
    }
    
    var querying = Bool()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tabBar = self.tabBarController?.tabBar
        
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            
//            setTabBarVisible(visible: false, animated: true)
            
            
        }
            
        else{
            
            setTabBarVisible(visible: true, animated: true)
            
            
            //        }
            
        }
        
        
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
//        if distanceFromBottom < height {
//
//            if querying {
//
//
//
//            } else {
//
//                if projectids.count > beginnumber && projectids.count > 14 {
//
//
//                    if beginnumber == 0 {
//
//                        activityIndicator.alpha = 1
//                        activityIndicator.startAnimating()
//                        beginnumber = 14
//                        queryforinfo()
//                        querying = true
//
//                    } else {
//
//                        if beginnumber == 14 {
//
//                            activityIndicator.alpha = 1
//                            activityIndicator.startAnimating()
//                            beginnumber = 28
//                            queryforinfo()
//                            querying = true
//
//                        } else {
//
//                            if beginnumber == 28 {
//                                activityIndicator.alpha = 1
//                                activityIndicator.startAnimating()
//                                beginnumber = 42
//                                queryforinfo()
//                                querying = true
//
//                            } else {
//
//                                if beginnumber == 42 {
//                                    activityIndicator.alpha = 1
//                                    activityIndicator.startAnimating()
//                                    beginnumber = 56
//                                    queryforinfo()
//                                    querying = true
//
//                                } else {
//
//
//                                    if beginnumber == 56 {
//                                        activityIndicator.alpha = 1
//                                        activityIndicator.startAnimating()
//                                        beginnumber = 72
//                                        queryforinfo()
//                                        querying = true
//                                    } else {
//
//                                        if beginnumber == 72 {
//                                            activityIndicator.alpha = 1
//                                            activityIndicator.startAnimating()
//                                            beginnumber = 42
//                                            queryforinfo()
//                                        }
//                                    }
//                                }
//
//                            }
//                        }
//
//                    }e
//
//
//                } else {
//
//                    activityIndicator.alpha = 0
//                }
//
//            }
//
//        }
        
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
    


  
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath) as! CategoriesCollectionViewCell
            
            
            cell.titlelabel.text = genres[indexPath.row].uppercased()
            cell.titlelabel.addCharacterSpacing()
            
            
            cell.selectedimage.layer.cornerRadius = 5.0
            cell.selectedimage.layer.masksToBounds = true
            collectionView2.alpha = 1
            
            if selectedindex == 0 {
                
      
                
                
                if indexPath.row == 0 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            } else {
                
                tapfilter.alpha = 0

            }
            
            if selectedindex == 1 {
                
    
                
                if indexPath.row == 1 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            }
            
            if selectedindex == 2 {
                
                if indexPath.row == 2 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            }
            
            if selectedindex == 3 {
                
                if indexPath.row == 3 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            }
            
            if selectedindex == 4 {
                
                if indexPath.row == 4 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            }
            
            if selectedindex == 5 {
                
                if indexPath.row == 5 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            }
            
            if selectedindex == 6 {
                
                if indexPath.row == 6 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            }
            
            if selectedindex == 7 {
                
                if indexPath.row == 7 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            }
            
            return cell

        } else {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "People", for: indexPath) as! PeopleCollectionViewCell
        
            if selectedindex > 0 {
                
                tapfilter.alpha = 0
            } else {
                
                tapfilter.alpha = 1

            }
//        cell.subscriber.tag = indexPath.row
        
//        cell.pricelabel.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.5)
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
//
//        cell.pricelabel.layer.cornerRadius = 5.0
//        cell.pricelabel.layer.masksToBounds = true
//        cell.layer.cornerRadius = 10.0
//        cell.layer.masksToBounds = true
        
        if images.count > indexPath.row && names.count > indexPath.row && projectids.count > indexPath.row {

            cell.thumbnail.image = images[projectids[indexPath.row]]
            cell.pricelabel.text = usedprices[projectids[indexPath.row]]?.uppercased()
            cell.pricelabel.addCharacterSpacing()
        
            print(projectids[indexPath.row])
            
            cell.textlabel.text = "\(names[projectids[indexPath.row]]!.uppercased())"

          
            
            
            cell.textlabel.addCharacterSpacing()

            }
            return cell

        }
        
        
    }
    
  
    
    @objc func tapJoin(sender: UIButton){
        
        let buttonTag = sender.tag
        
        selectedindex = buttonTag
        selectedimage = images[projectids[buttonTag]]!
        selectedname = names[projectids[buttonTag]]!
        selectedpitch = descriptions[projectids[buttonTag]]!
        selectedprice = newprices[projectids[buttonTag]]!
        //        selectedprogramnames = programnames[projectids[buttonTag]]!
        selectedsubs = usedprices[projectids[buttonTag]]!
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


