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

    @IBOutlet weak var programname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        programname.text = selectedprogramname
//        tableView.rowHeight = UITableViewAutomaticDimension

//        cta.text = "Join \(firstname)'s FAM"
        
        ref = Database.database().reference()
        


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
        thumbnails.removeAll()
        
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
    
    var thumbnails = [String:UIImage]()

    func queryforinfo() {
        
        var functioncounter = 0
        
        for each in videoids {
            
            
            ref?.child("Influencers").child(selectedid).child("Plans").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["URL"] as? String {
                    videolinks[each] = author2
                    
//                    self.createThumbnailOfVideoFromRemoteUrl(url: author2)
                    
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
    @IBOutlet weak var tableView: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            
            thumbnails[url] = thumbnail
            
            return thumbnail
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return videolinks.count+1
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Plans", for: indexPath) as! PlansTableViewCell
        
        if videolinks.count > indexPath.row-1 {
            
            if indexPath.row == 0 {
                
                cell.daylabel.alpha = 0
                
                
                cell.profilepic.alpha = 1
                cell.pitch.alpha = 1
                cell.tapjoin.alpha = 1
                cell.subs.alpha = 1
                cell.dollers.alpha = 1
                cell.name.alpha = 1
                cell.sublabel.alpha = 1
                cell.monthlylabel.alpha = 1
                cell.profilepic.image = selectedimage
                cell.profilepic.layer.cornerRadius = 5.0
                cell.profilepic.layer.masksToBounds = true
                cell.pitch.text = selectedpitch
                cell.subs.text = selectedsubs
                cell.dollers.text = "$\(selectedprice)"
                cell.name.text = selectedname
                cell.playerView.alpha = 0
                cell.thumbnailpreview.alpha = 0
            } else {
                cell.playerView.alpha = 1
                cell.profilepic.alpha = 0
                cell.pitch.alpha = 0
                cell.tapjoin.alpha = 0
                cell.subs.alpha = 0
                cell.dollers.alpha = 0
                cell.name.alpha = 0
                cell.sublabel.alpha = 0
                cell.monthlylabel.alpha = 0
                cell.pitch.text = ""
//                cell.thumbnailpreview.alpha = 1
//                cell.thumbnailpreview.image = thumbnails[videolinks[videoids[indexPath.row-1]]!]
                
                cell.daylabel.alpha = 1
                
                cell.daylabel.text = "DAY \(indexPath.row)"
//                cell.descriptionlabel.text = videodescriptions[videoids[indexPath.row]]
//                cell.timelabel.text = videotimes[videoids[indexPath.row]]
                let videourl = URL(string: videolinks[videoids[indexPath.row-1]]!)
                
                let avPlayer = AVPlayer(url: videourl! as URL)
                
                cell.playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill
                
                cell.playerView.playerLayer.player = avPlayer
                cell.playerView.player?.play()
//                cell.playerView.player?.pause()

            }
        } else {
            

        }
        
        
        return cell
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            return UITableViewAutomaticDimension

        } else {
            
            return 425
        }
    }
    
    var buttonspressedup = [String:String]()
    
    @objc func tapPlay(sender: UIButton){
        
        let buttonTag = sender.tag
        
     
            tableView.reloadData()
    }
    
    @objc func tapDown(sender: UIButton){
        let buttonTag = sender.tag

            
            tableView.reloadData()
        }
        
    }

