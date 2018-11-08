//
//  PlansViewController.swift
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
import AVFoundation

var videoids = [String]()
var videolinks = [String:String]()
var videodescriptions = [String:String]()
var videotimes = [String:String]()

var firstname = String()
var selectedname = String()
class PlansViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var profilepic: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cta: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        cta.text = "Join \(firstname)'s FAM"
        
        cta.text = "Join FAM"

        price.text = "$\(selectedprice)/mo"
        name.text = selectedname
        profilepic.image = selectedimage
        ref = Database.database().reference()
        

        profilepic.layer.masksToBounds = false
        profilepic.layer.cornerRadius = profilepic.frame.height/2
        profilepic.clipsToBounds = true

        queryforids { () -> () in
            
            self.queryforinfo()
            
        }
        // Do any additional setup after loading the view.
    }
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        videoids.removeAll()
        videolinks.removeAll()
        videodescriptions.removeAll()
 
        
        ref?.child("Influencers").child(selectedid).child("Plans").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    videoids.append(ids)
                    
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
        
        for each in videoids {
            
            
            ref?.child("Influencers").child(selectedid).child("Plans").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["URL"] as? String {
                    videolinks[each] = author2
                    
                }
                
                if var author2 = value?["Description"] as? String {
                    videodescriptions[each] = author2
                    
                }
                
                if var author2 = value?["Times"] as? String {
                    videotimes[each] = author2
                    
                }
                
            
     
                
                
                
                functioncounter += 1
                
                print(functioncounter)
                
                
                
                if functioncounter == videoids.count {
                    
                    self.tableView.reloadData()
                    
                }
                
                
            })
            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return videolinks.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Plans", for: indexPath) as! PlansTableViewCell
        
        if videolinks.count > indexPath.row {
            
            cell.daylabel.text = "DAY \(indexPath.row+1)"
            cell.descriptionlabel.text = videodescriptions[videoids[indexPath.row]]
            cell.timelabel.text = videotimes[videoids[indexPath.row]]
            let videourl = URL(string: videolinks[videoids[indexPath.row]]!)
            
            let avPlayer = AVPlayer(url: videourl! as URL)

            cell.playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill

            cell.playerView.playerLayer.player = avPlayer
            
            
            cell.playerView.player!.play()

        } else {
            
            
        }
        
        
        return cell
    }

}
