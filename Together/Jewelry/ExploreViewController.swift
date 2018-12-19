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

var selectedid = String()

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
class ExploreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    func load100products() {
        
        var i = 0
        
        while i < 75 {
            
            ref!.child("Products2").childByAutoId().updateChildValues(["Brand" : "-","Category" : "-","Color" : "-","Description" : "-","Designer" : "-","Gemstone" : "-","Image" : "-","Name" : "-","New Link" : "-","New Price" : "-","Packaging" : "-","Purity" : "-","Size" : "-","Stone" : "-","Used Inventory" : "0","Used Link" : "-","Used Price" : "-", "Metal" : "-"])
            
            i += 1
        }
        
    }
    
    var genres = [String]()
    var viewableids = [String]()
    
    @IBOutlet weak var tapfilter: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        allids.removeAll()
        
        if allids.count == 0 {
            
            queryformoreids()

        }
        activityIndicator.color = myblue
        tapfilter.addTextSpacing(2.0)
        ref = Database.database().reference()
        genres.removeAll()
        genres.append("Buy Now")
        genres.append("Under Retail")
        genres.append("Trending")
        genres.append("Best Sellers")
        collectionView2.alpha = 1
        selectedindex = 0
        //            tapBack.alpha = 0

//        if projectids.count == 0 && selectedfilter != "" {
        
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
        queryformoreids()
        queryforids { () -> () in
            
            self.queryforinfo()
            
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
        
        
//        if Auth.auth().currentUser == nil {
//            // Do smth if user is not logged in
//
//        } else {
//
//            self.tabBarController?.tabBar.isHidden = false
//            tapBack.alpha = 0
//        }
      
        // Do any additional setup after loading the view.
        
//        load100products()
    }
    @IBOutlet weak var tapBack: UIButton!
    @IBAction func tapback(_ sender: Any) {
    }
    
  
    func queryfornumberedids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        

        ref?.child("Products").observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
            
                if let snapDict = snapshot.value as? [String:AnyObject] {
                    
                    for each in snapDict {
                        
                        let ids = each.key
                        
                        if projectids.contains(ids) {
                            
                            functioncounter += 1

                        } else {
                            
                            projectids.append(ids)
                            functioncounter += 1

                        }
                        
                        
                        if functioncounter == snapDict.count {
                            
                            completed()
                            
                        }
                        
                        
                    }
                    
                }
                
            })
        
    }
    
    var allids = [String]()
    
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
        
        if selectedfilter == "" {
            
        ref?.child("Products").queryLimited(toFirst: 10).observeSingleEvent(of: .value, with: { (snapshot) in
            
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
            
        } else {
            
            ref?.child("Products").queryOrdered(byChild: selectedkey).queryEqual(toValue: selectedfilter).observeSingleEvent(of: .value, with: { (snapshot) in
                
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
    }
    
    func queryformoreids() {
        
        
        var functioncounter = 0
        
            ref?.child("Products").observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if let snapDict = snapshot.value as? [String:AnyObject] {
                    
                    for each in snapDict {
                        
                        let ids = each.key
                        
                        self.allids.append(ids)
                        
                        functioncounter += 1
                        
                      
                        
                    }
                    
                }
                
            })
            
        
//            ref?.child("Products").queryOrdered(byChild: "Category").queryEqual(toValue: selectedfilter).observeSingleEvent(of: .value, with: { (snapshot) in
//
//                var value = snapshot.value as? NSDictionary
//
//                if let snapDict = snapshot.value as? [String:AnyObject] {
//
//                    for each in snapDict {
//
//                        let ids = each.key
//
//                        projectids.append(ids)
//
//                        functioncounter += 1
//
//                        if functioncounter == snapDict.count {
//
//                            completed()
//
//                        }
//
//
//                    }
//
//                }
//
//            })
    }
    
    @IBOutlet weak var collectionView2: UICollectionView!
    var usedprices = [String:String]()
    var brandnames = [String:String]()
    
    func queryforinfo() {
        self.collectionView.alpha = 0
        var functioncounter = 0
        
        for each in projectids {
            
        ref?.child("Products").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Used Price"] as? String {
                    
                    if author2 != "-" {
                    var intviews = Double(Int(author2.dropFirst())!)
                    intviews = intviews * 1.1
                    author2 = "$\(String(Int(intviews)))"
                    self.usedprices[each] = author2
                        
                    } else {
                        
                        if var author2 = value?["New Price"] as? String {

                            var intviews = Double(Int(author2.dropFirst())!)
                            intviews = intviews * 1.1
                            author2 = "$\(String(Int(intviews)))"
                            self.usedprices[each] = author2

                        }
                    }
                }
                
                if var author2 = value?["Description"] as? String {
                    descriptions[each] = author2
                    
                }
            
            if var author2 = value?["Brand"] as? String {
                
                self.brandnames[each] = author2
                
            } else {
                
                self.brandnames[each] = " "

            }
                if var name = value?["Name"] as? String {
                    names[each] = name
                    
                }
                
           
                
                if var views = value?["ProgramName"] as? String {
                    programnames[each] = views
                    
                }
                
                if var profileUrl = value?["Image"] as? String {
                    // Create a storage reference from the URL
                    imageurls[each] = profileUrl
                    
                    let url = URL(string: profileUrl)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    selectedimage = UIImage(data: data!)!
                    
                    images[each] = selectedimage

                    functioncounter += 1

                }
                
                
//                toppics[each] = UIImage(named: "\(each)pic")
                
                
                print(functioncounter)
                
                
                
                if functioncounter == projectids.count {
                    
                    self.activityIndicator.alpha = 0
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                    self.collectionView.alpha = 1
                    self.tapfilter.alpha = 1
                }
                
                
            })
            
        }
    }
    
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
            return CGSize(width: 141, height: CGFloat(kWhateverHeightYouWant))
            
        } else {
        let kWhateverHeightYouWant = 82
        return CGSize(width: view.frame.width/2, height: CGFloat(kWhateverHeightYouWant))
            
        }
    }
    
    var selectedindex = Int()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 2 {
            
        selectedindex = indexPath.row
            
        collectionView2.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)

            
            collectionView2.reloadData()
            
            if indexPath.row == 0 {
                selectedfilter = ""
                selectedkey = ""
                projectids.removeAll()
                projectids.append(allids[0])
                projectids.append(allids[1])
                projectids.append(allids[2])
                projectids.append(allids[3])
                projectids.append(allids[4])
                projectids.append(allids[5])
                projectids.append(allids[6])
                projectids.append(allids[7])
                projectids.append(allids[8])
                projectids.append(allids[9])
                descriptions.removeAll()
                names.removeAll()
                programnames.removeAll()
                prices.removeAll()
                toppics.removeAll()
                images.removeAll()
                brandnames.removeAll()
                imageurls.removeAll()
                activityIndicator.alpha = 1
                activityIndicator.startAnimating()
                collectionView.alpha = 0
                tapfilter.alpha = 0
                queryforinfo()
            }
            
            if indexPath.row == 1 {
                
                projectids.removeAll()
                projectids.append(allids[10])
                projectids.append(allids[11])
                projectids.append(allids[12])
                projectids.append(allids[13])
                projectids.append(allids[14])
                projectids.append(allids[15])
                projectids.append(allids[16])
                projectids.append(allids[17])
                projectids.append(allids[18])
                projectids.append(allids[19])
                descriptions.removeAll()
                names.removeAll()
                programnames.removeAll()
                prices.removeAll()
                toppics.removeAll()
                images.removeAll()
                brandnames.removeAll()
                imageurls.removeAll()
                activityIndicator.alpha = 1
                activityIndicator.startAnimating()
                collectionView.alpha = 0
                tapfilter.alpha = 0
                queryforinfo()

                }
            if indexPath.row == 2 {
                
                projectids.removeAll()
                projectids.append(allids[20])
                projectids.append(allids[21])
                projectids.append(allids[22])
                projectids.append(allids[23])
                projectids.append(allids[24])
                projectids.append(allids[25])
                projectids.append(allids[26])
                projectids.append(allids[27])
                projectids.append(allids[28])
                projectids.append(allids[29])
                descriptions.removeAll()
                names.removeAll()
                programnames.removeAll()
                prices.removeAll()
                toppics.removeAll()
                images.removeAll()
                brandnames.removeAll()
                imageurls.removeAll()
                activityIndicator.alpha = 1
                activityIndicator.startAnimating()
                collectionView.alpha = 0
                tapfilter.alpha = 0
                queryforinfo()

            }
            
            if indexPath.row == 3 {
                
                projectids.removeAll()
                projectids.append(allids[30])
                projectids.append(allids[31])
                projectids.append(allids[32])
                projectids.append(allids[33])
                projectids.append(allids[34])
                projectids.append(allids[35])
                projectids.append(allids[36])
                projectids.append(allids[37])
                projectids.append(allids[38])
                projectids.append(allids[19])
                descriptions.removeAll()
                names.removeAll()
                programnames.removeAll()
                prices.removeAll()
                toppics.removeAll()
                images.removeAll()
                brandnames.removeAll()
                imageurls.removeAll()
                activityIndicator.alpha = 1
                activityIndicator.startAnimating()
                collectionView.alpha = 0
                tapfilter.alpha = 0
                queryforinfo()

            }
            
        } else {
            
        selectedbrand = brandnames[projectids[indexPath.row]]!
        selectedid = projectids[indexPath.row]
        unlockedid = "0"
        selectedimage = images[projectids[indexPath.row]]!
        selectedname = names[projectids[indexPath.row]]!
        selectedimageurl = imageurls[projectids[indexPath.row]]!
//        selectedpitch = descriptions[projectids[indexPath.row]]!
//        selectedprice = prices[projectids[indexPath.row]]!
        //        selectedprogramnames = programnames[projectids[indexPath.row]]!
        selectedsubs = usedprices[projectids[indexPath.row]]!
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    let tabBar = self.tabBarController?.tabBar
        
    if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
            
//            changeTabBar(hidden: true, animated: true)
        
        tabBar?.isHidden = true
        
        }
        
        else{
        
        tabBar?.isHidden = false
//        self.view.addSubview(tabBar!)
//                    changeTabBar(hidden: false, animated: true)
        
        }
    }
    
    func changeTabBar(hidden:Bool, animated: Bool){
        guard let tabBar = self.tabBarController?.tabBar else { return; }
        if tabBar.isHidden == hidden{ return }
        let frame = tabBar.frame
        let offset = hidden ? frame.size.height : -frame.size.height
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
        }, completion: { (true) in
            tabBar.isHidden = hidden
        })
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
        
        if images.count > indexPath.row  && brandnames.count > indexPath.row && names.count > indexPath.row {

            cell.thumbnail.image = images[projectids[indexPath.row]]
            cell.pricelabel.text = usedprices[projectids[indexPath.row]]?.uppercased()
            cell.pricelabel.addCharacterSpacing()
            cell.textlabel.text = "\(brandnames[projectids[indexPath.row]]!.uppercased()) \(names[projectids[indexPath.row]]!.uppercased())"
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
        selectedprice = prices[projectids[buttonTag]]!
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
