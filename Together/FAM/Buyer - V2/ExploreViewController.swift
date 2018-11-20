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

class ExploreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.color = mypink
        headerlabel.addCharacterSpacing()
        
        ref = Database.database().reference()
        
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        collectionView.alpha = 0
        
        queryforids { () -> () in
            
            self.queryforinfo()
            
        }
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            self.tabBarController?.tabBar.isHidden = true

        } else {
            
            self.tabBarController?.tabBar.isHidden = false

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
        ref?.child("Influencers").queryOrdered(byChild: "Approved").queryEqual(toValue: "True").observeSingleEvent(of: .value, with: { (snapshot) in
            
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

                }
                
                if var views = value?["ProgramName"] as? String {
                    programnames[each] = views
                    
                }
                
                if var profileUrl = value?["ProPic"] as? String {
                    // Create a storage reference from the URL
                    
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
                }
                
                
            })
            
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerlabel: UILabel!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedid = projectids[indexPath.row]
        unlockedid = "0"
        myselectedimage = images[projectids[indexPath.row]]!
        selectedname = names[projectids[indexPath.row]]!
        
//        selectedpitch = descriptions[projectids[indexPath.row]]!
        selectedprice = prices[projectids[indexPath.row]]!
        //        selectedprogramnames = programnames[projectids[indexPath.row]]!
        selectedsubs = subscribers[projectids[indexPath.row]]!
//        selectedprogramname = programnames[projectids[indexPath.row]]!
        
        self.performSegue(withIdentifier: "ExploreToVideos", sender: self)
        
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if images.count > 0 {
            
            return images.count
            
        } else {
            
            return 0
        }
     
    }
    
  
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "People", for: indexPath) as! PeopleCollectionViewCell
        
//        cell.subscriber.tag = indexPath.row
        
        cell.pricelabel.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.5)
        cell.pricelabel.layer.cornerRadius = 5.0
        cell.pricelabel.layer.masksToBounds = true
        cell.layer.cornerRadius = 10.0
        cell.layer.masksToBounds = true
        
        if images.count > indexPath.row && names.count > indexPath.row {
            
            cell.pricelabel.text = "$\(prices[projectids[indexPath.row]]!)"

            //            cell.layer.borderWidth = 1.0
            //            cell.layer.borderColor = UIColor.lightGray.cgColor
//            cell.subscriber.addTarget(self, action: #selector(tapJoin(sender:)), for: .touchUpInside)
            
            cell.thumbnail.layer.cornerRadius = 10.0
            cell.thumbnail.layer.masksToBounds = true
            cell.textlabel.text = names[projectids[indexPath.row]]
     
            cell.thumbnail.image = images[projectids[indexPath.row]]
//            cell.subscribers.text = "\(subscribers[projectids[indexPath.row]]!) subscribers"
                        cell.subscribers.text = "\(subscribers[projectids[indexPath.row]]!)"

        } else {
            
            
        }
        
        
        return cell
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
