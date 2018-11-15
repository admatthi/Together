//
//  EditProfileViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/12/18.
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

class EditProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var programname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedprogramname = selectedprogramname.uppercased()
        programname.addCharacterSpacing()
        programname.text = selectedprogramname
        
        //        tableView.rowHeight = UITableViewAutomaticDimension
        
        //        cta.text = "Join \(firstname)'s FAM"
        
        ref = Database.database().reference()
        
        queryforpersonalinfo()
        
        queryforids { () -> () in
            
            self.queryforinfo()
            
        }
        
        locked = false
       
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        queryforpersonalinfo()
        
        queryforids { () -> () in
            
            self.queryforinfo()
            
        }
        
    }
    
    func queryforpersonalinfo() {
        
        
        var functioncounter = 0
        
            ref?.child("Influencers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["Subscribers"] as? String {
                    
                    selectedsubs = author2
                    
                }
                
                if var author2 = value?["Description"] as? String {
                    selectedpitch = author2
                    
                }
                
                if var name = value?["Name"] as? String {
                        selectedname = name
                }
                
                if var views = value?["Price"] as? String {
                    selectedprice = views
                    
                }
                
                if var views = value?["Phone Number"] as? String {
                    selectednumber = views
                    
                }
                
                if var views = value?["Domain"] as? String {
                    selecteddomain = views
                    
                }
                
                if var views = value?["Email"] as? String {
                    selectedemail = views
                    
                }
                
                
                if var views = value?["ProgramName"] as? String {

                    selectedprogramname = views
//                    self.programname.text = selectedprogramname
                }
                
                
                if var profileUrl = value?["ProPic"] as? String {
                    // Create a storage reference from the URL
                    
                    let url = URL(string: profileUrl)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    selectedimage = UIImage(data: data!)!
                    
                    self.tableView.reloadData()

                }
                
                
     
                
        })
                
                
        
            
        }

    @IBOutlet weak var tableView: UITableView!
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        videoids.removeAll()
        videolinks.removeAll()
        videodescriptions.removeAll()
        videotitles.removeAll()
        thumbnails.removeAll()
        
        ref?.child("Influencers").child(uid).child("Plans").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
    var videotitles = [String:String]()
    func queryforinfo() {
        
        var functioncounter = 0
        
        for each in videoids {
            
            
            ref?.child("Influencers").child(uid).child("Plans").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
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
                
                if var author2 = value?["Title"] as? String {
                    self.videotitles[each] = author2
                    
                }
                
                if var profileUrl = value?["Thumbnail"] as? String {
                    // Create a storage reference from the URL
                    
                    let url = URL(string: profileUrl)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    self.thumbnails[each] = UIImage(data: data!)
                    
                    functioncounter += 1
                }
                
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
    
//    override func viewDidDisappear(_ animated: Bool) {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Plans", for: indexPath) as! PlansTableViewCell
//
//        cell.playerView.player?.pause()
//
////    }
//    func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
//        let asset = AVAsset(url: URL(string: url)!)
//        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
//        assetImgGenerate.appliesPreferredTrackTransform = true
//        //Can set this to improve performance if target size is known before hand
//        //assetImgGenerate.maximumSize = CGSize(width,height)
//        let time = CMTimeMakeWithSeconds(1.0, 600)
//        do {
//            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
//            let thumbnail = UIImage(cgImage: img)
//
//            thumbnails[url] = thumbnail
//
//            return thumbnail
//        } catch {
//            print(error.localizedDescription)
//            return nil
//        }
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if videolinks.count > 0 {
       
            return videolinks.count + 1
            
        } else {
            
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? PlansTableViewCell {
            
            if indexPath.row == 0 {
                
                
                
                
            } else {
                
            let videourl = URL(string: videolinks[videoids[indexPath.row-1]]!)
            
            let avPlayer = AVPlayer(url: videourl! as URL)
            
            cell.playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill
            
            cell.playerView.playerLayer.player = avPlayer
            
                
            if cell.playerView.player?.isPlaying == true {
                
                cell.playerView.player?.pause()
                cell.thumbnail.alpha = 1
                
            } else {
                cell.thumbnail.alpha = 0
                cell.playerView.player?.play()
                
            }
            
            }
        }
            
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Plans", for: indexPath) as! PlansTableViewCell
        cell.activityIndicator.alpha = 1
        cell.selectionStyle = .none
        cell.tapjoin.layer.borderColor = mypink.cgColor
        cell.tapjoin.layer.borderWidth = 0.5
        cell.tapjoin.addTarget(self, action: #selector(tapDown(sender:)), for: .touchUpInside)
        cell.tapcircle.addTarget(self, action: #selector(tapStory(sender:)), for: .touchUpInside)
        
        if indexPath.row == 0 {
            
            cell.activityIndicator.alpha = 0
            cell.daylabel.alpha = 0
            cell.minipic.alpha = 0
            cell.programn.alpha = 0
            cell.profilepic.alpha = 1
            cell.pitch.alpha = 1
            cell.tapjoin.alpha = 1
            cell.subs.alpha = 1
            cell.dollers.alpha = 1
            cell.name.alpha = 1
            cell.sublabel.alpha = 1
            cell.monthlylabel.alpha = 1
            cell.profilepic.image = selectedimage
            //                cell.profilepic.layer.cornerRadius = 5.0
            //                cell.profilepic.layer.masksToBounds = true
            cell.pitch.text = selectedpitch
            cell.subs.text = selectedsubs
            cell.dollers.text = "$\(selectedprice)"
            cell.name.text = selectedname
            cell.playerView.alpha = 0
            //                cell.thumbnailpreview.alpha = 0
            cell.descriptionlabel.text = ""
            cell.descriptionlabel.alpha = 0
            cell.thumbnail.alpha = 0
            cell.tapaddstory.alpha = 1
            cell.tapcircle.alpha = 1
        }
        
      
        
        if videolinks.count > indexPath.row-1 {
            
            if indexPath.row != 0 {
//                let rect : CGRect = CGRect(x: cell.thumbnail.bounds.minX, y: cell.thumbnail.bounds.minY, width: cell.thumbnail.bounds.width, height: cell.thumbnail.bounds.height)
                
    
                
                cell.thumbnail.alpha = 1
                cell.thumbnail.image = thumbnails[videoids[indexPath.row]]
                cell.minipic.alpha = 1
                cell.programn.alpha = 1
                cell.minipic.image = selectedimage
                cell.programn.text = selectedprogramname
                cell.playerView.alpha = 1
                cell.profilepic.alpha = 0
                cell.pitch.alpha = 0
                cell.pitch.text = ""
                cell.tapjoin.alpha = 0
                cell.subs.alpha = 0
                cell.dollers.alpha = 0
                cell.name.alpha = 0
                cell.sublabel.alpha = 0
                cell.monthlylabel.alpha = 0
                cell.pitch.text = ""
               cell.tapaddstory.alpha = 0
                cell.descriptionlabel.alpha = 1
                //                cell.thumbnailpreview.alpha = 1
                //                cell.thumbnailpreview.image = thumbnails[videolinks[videoids[indexPath.row-1]]!]
                
                cell.daylabel.alpha = 1
                
                cell.daylabel.text = videotitles[videoids[indexPath.row]]
                cell.descriptionlabel.text = videodescriptions[videoids[indexPath.row]]
                cell.activityIndicator.alpha = 0
                
                cell.playerView.player?.replaceCurrentItem(with: nil)

                //                cell.descriptionlabel.text = videodescriptions[videoids[indexPath.row]]
                //                cell.timelabel.text = videotimes[videoids[indexPath.row]]
                
                if locked {
                    
                    //                    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
                    //                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    //                    blurEffectView.frame = cell.playerView.bounds
                    //                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    //                    cell.playerView.addSubview(blurEffectView)
                    //                    cell.lockimage.alpha = 1
                    
                    //                    cell.isUserInteractionEnabled = false
                    
                } else {
                    cell.isUserInteractionEnabled = true
                    //                    cell.lockimage.alpha = 0
                    
                }
                //                cell.playerView.player!.replaceCurrentItem(with: nil)
                
                //                cell.playerView.player?.pause()
                //
                //                cell.playerView.player?.play()
                
                
                
            }
            
            
        } else {
            
            
        }
        
        
        return cell
    }
    
    @objc func tapDown(sender: UIButton){
        
      self.performSegue(withIdentifier: "EditToUpload", sender: self)
        
        
    }
    
    @objc func tapStory(sender: UIButton){
        
        selectedid = uid
        
        self.performSegue(withIdentifier: "InfluencerToPurchase", sender: self)
        
    }
    
  

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            return 220
            
        } else {
            
            //            return 425
            return UITableViewAutomaticDimension
            
        }
        
    }
    @IBAction func tapLogout(_ sender: Any) {
        
        try! Auth.auth().signOut()
        
        self.performSegue(withIdentifier: "LogoutFromProfile", sender: self)
    }
}
