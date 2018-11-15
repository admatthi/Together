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
var mypink = UIColor(red:0.96, green:0.10, blue:0.47, alpha:1.0)


class MyFamViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {

    @IBOutlet weak var headerlabel: UILabel!
    @IBOutlet weak var errorlabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.color = mypink
        ref = Database.database().reference()
        
        headerlabel.addCharacterSpacing()


        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            
        collectionView.alpha = 0
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
        
        collectionView.alpha = 0
        errorlabel.alpha = 1
        activityIndicator.alpha = 0
        ref?.child("Users").child(uid).child("Purchased").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    myprojectids.append(ids)
                    self.collectionView.alpha = 1
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
                    self.collectionView.alpha = 1
                    self.collectionView.reloadData()
                    
                }
                
                
            })
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedid = projectids[indexPath.row]
        selectedimage = images[projectids[indexPath.row]]!
        selectedname = names[projectids[indexPath.row]]!
        selectedpitch = descriptions[projectids[indexPath.row]]!
        selectedprice = prices[projectids[indexPath.row]]!
        //        selectedprogramnames = programnames[projectids[indexPath.row]]!
        selectedsubs = subscribers[projectids[indexPath.row]]!
        selectedprogramname = programnames[projectids[indexPath.row]]!
        
        self.performSegue(withIdentifier: "DiscoverToContent", sender: self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if images.count > 0 {
            
            return images.count
            
        } else {
            
            return 0
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "People", for: indexPath) as! PeopleCollectionViewCell
        
        //        cell.subscriber.tag = indexPath.row
        
        if images.count > indexPath.row{
            
            
            //            cell.layer.borderWidth = 1.0
            //            cell.layer.borderColor = UIColor.lightGray.cgColor
            //            cell.subscriber.addTarget(self, action: #selector(tapJoin(sender:)), for: .touchUpInside)
            
            cell.thumbnail.layer.cornerRadius = 10.0
            cell.thumbnail.layer.masksToBounds = true
            cell.textlabel.text = names[projectids[indexPath.row]]
            
            cell.thumbnail.image = images[projectids[indexPath.row]]
            
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