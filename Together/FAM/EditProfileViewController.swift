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

var thumbnailurls = [String:String]()
var selectedthumbnailurl = String()
var selectedvideourl = String()
class EditProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate   {

    @IBOutlet weak var programname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lowercasename = selectedname
        selectedid = uid

        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        
        dateFormatter.dateFormat = "MMM dd"
        
        thisdate = dateFormatter.string(from: date)
        
        
//        locked = true
        
        if uid == selectedid {
            
            locked = false
        }
        selectedprogramname = selectedprogramname.uppercased()
        
        programname.text = selectedname.uppercased()
        programname.addCharacterSpacing()
        
        
        //        tableView.rowHeight = UITableViewAutomaticDimension
        
        //        cta.text = "Join \(firstname)'s FAM"
        
        ref = Database.database().reference()
        
//        queryforpersonalinfo()
//
//        queryforids { () -> () in
//
//            self.queryforinfo()
//
//        }
        
        locked = false
       
        
        
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        
        ref = Database.database().reference()

        if thumbnails.count >  0 {
            
            collectionView.alpha = 1
            activityIndicator.alpha = 0
            collectionView.reloadData()
            
        } else {
            
            collectionView.alpha = 0
            activityIndicator.alpha = 1
            activityIndicator.color = mypink
            activityIndicator.startAnimating()
            
            queryforhighlevelinfo()
            
            queryforids { () -> () in
                
                self.queryforinfo()
                
            }
            
        }
        
      
        
    }
    
    
    func queryforhighlevelinfo() {
        
        var functioncounter = 0
        
        ref?.child("Influencers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            
           
            if var profileUrl = value?["ProPic"] as? String {
                // Create a storage reference from the URL
                
                let url = URL(string: profileUrl)
                thumbnailurls["0"] = profileUrl
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                self.thumbnails["0"] = UIImage(data: data!)
                
            }
            
            
            if var author2 = value?["Purchase"] as? String {
                videolinks["0"] = author2
                
                
            }
            
            self.collectionView.reloadData()
        })
        
    }
                
    @IBOutlet weak var tableView: UITableView!
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        videodates.removeAll()
        videoids.removeAll()
        videolinks.removeAll()
        videodescriptions.removeAll()
        videotitles.removeAll()
        thumbnails.removeAll()
        thumbnailurls.removeAll()
        ref?.child("Influencers").child(uid).child("Plans").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    videoids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        videoids = videoids.sorted()

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
                
                if var author2 = value?["ProgramName"] as? String {
                    self.programname.text = author2
                    selectedprogramname = author2
                    self.programname.addCharacterSpacing()
                }
                
                if var author2 = value?["Times"] as? String {
                    videotimes[each] = author2
                    
                }
                
                if var author2 = value?["Title"] as? String {
                    self.videotitles[each] = author2
                    
                }
                
                if var author2 = value?["Date"] as? String {
                    videodates[each] = author2
                    
                }
                
                if var profileUrl = value?["Thumbnail"] as? String {
                    // Create a storage reference from the URL
                    
                    let url = URL(string: profileUrl)
                    thumbnailurls[each] = profileUrl
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    self.thumbnails[each] = UIImage(data: data!)
                    
                    functioncounter += 1
                }
                
                print(functioncounter)
                
                
                
                if functioncounter == videoids.count {
                    
                    self.collectionView.reloadData()
                    
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            selectedtitle = "Subscribe Now"
            selectedthumbnailurl = thumbnailurls["0"]!
            selectedvideourl = videolinks["0"]!
            self.performSegue(withIdentifier: "EditToPurchase", sender: self)
            
        } else {
            
            selectedthumbnailurl = thumbnailurls[videoids[indexPath.row-1]]!
            selectedvideo = videolinks[videoids[indexPath.row-1]]!
            selectedvideoid = videoids[indexPath.row-1]
            selectedtitle = videotitles[videoids[indexPath.row-1]]!
            
            self.performSegue(withIdentifier: "EditToWatch", sender: self)
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if thumbnails.count > 0 {
            
            return thumbnails.count
            
        } else {
            
            return 0
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Videos", for: indexPath) as! VideosCollectionViewCell
        
        //        cell.subscriber.tag = indexPath.row
    
        if thumbnails.count > indexPath.row {
            
            if indexPath.row == 0 {
                
                cell.thumbnail.image = thumbnails["0"]
                cell.titlelabel.text = "Subscribe Now"
                cell.timeago.text = "\(selectedsubs) subscribers"
                cell.whitelabel.alpha = 0
                cell.isUserInteractionEnabled = true
                
            } else {
                
                cell.thumbnail.image = thumbnails[videoids[indexPath.row-1]]

                cell.titlelabel.text = videotitles[videoids[indexPath.row-1]]
                cell.timeago.text = videodates[videoids[indexPath.row-1]]
                
                if locked {
                    
                    cell.whitelabel.alpha = 0.5
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.whitelabel.alpha = 0

                    cell.isUserInteractionEnabled = true
                }
                
            }
            
            //            cell.layer.borderWidth = 1.0
            //            cell.layer.borderColor = UIColor.lightGray.cgColor
            //            cell.subscriber.addTarget(self, action: #selector(tapJoin(sender:)), for: .touchUpInside)
            
            cell.thumbnail.layer.cornerRadius = 10.0
            cell.thumbnail.layer.masksToBounds = true
            
            cell.layer.cornerRadius = 10.0
            cell.layer.masksToBounds = true
            
     
            activityIndicator.alpha = 0
            collectionView.alpha = 1
            activityIndicator.stopAnimating()
            
            
        } else {
            
            
        }
        
        
        return cell
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @objc func tapDown(sender: UIButton){
        
      self.performSegue(withIdentifier: "EditToUpload", sender: self)
        
        
    }
    
    
    
    @objc func tapStory(sender: UIButton){
        
        selectedid = uid
        
        self.performSegue(withIdentifier: "InfluencerToPurchase", sender: self)
        
    }
    
  

    
    @IBAction func tapLogout(_ sender: Any) {
        try! Auth.auth().signOut()
        
        self.performSegue(withIdentifier: "Logout5", sender: self)
       
    }
}
