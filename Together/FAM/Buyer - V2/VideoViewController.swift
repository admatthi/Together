//
//  VideoViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/15/18.
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

var selectedvideoid = String()

class VideoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBAction func tapBack(_ sender: Any) {
        
                self.dismiss(animated: true, completion: {
        
                })
    }
    
    @IBOutlet weak var programname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lowercasename = selectedname
        
        selectedname = selectedname.uppercased()
        
        activityIndicator.color = mypink

        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        collectionView.alpha = 0
        programname.text = selectedname
        programname.addCharacterSpacing()
        //        tableView.rowHeight = UITableViewAutomaticDimension
        
        //        cta.text = "Join \(firstname)'s FAM"
        
        locked = true
        
        if uid == selectedid {
            
            locked = false
            
            queryforids { () -> () in
                
                self.queryforinfo()
                
            }
            
        }
        
        if myprojectids.contains(selectedid) {
            
            locked = false
            
            queryforids { () -> () in
                
                self.queryforinfo()
                
            }
            
        }
        
        ref = Database.database().reference()
        
 
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            locked = true
            
        } else {
            
            if selectedid == unlockedid {
                
                locked = false
                
                queryforids { () -> () in
                    
                    self.queryforinfo()
                    
                }
                
                
                
            }
            
        
            
//            queryforpurchased()
            
        }
        
        
        collectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
  
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        videoids.removeAll()
        videolinks.removeAll()
        videodescriptions.removeAll()
        videotitles.removeAll()
        thumbnails.removeAll()
        videodates.removeAll()
        ref?.child("Influencers").child(selectedid).child("Plans").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
    
    var videotitles = [String:String]()
    
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
                
                if var author2 = value?["Title"] as? String {
                    self.videotitles[each] = author2
                    
                }
                
                
                if var author2 = value?["Date"] as? String {
                
                    videodates[each] = author2
                    
                }
                
                if var profileUrl = value?["Thumbnail"] as? String {
                    // Create a storage reference from the URL
                    
                    let url = URL(string: profileUrl)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    thumbnails[each] = UIImage(data: data!)
                    
                    functioncounter += 1
                }
                
                print(functioncounter)
                
                
                
                if functioncounter == videoids.count {
                    
                    self.collectionView.reloadData()
                    
                }
                
                
            })
            
        }
    }
    @IBOutlet weak var tableView: UITableView!
    /*
     @IBOutlet weak var collectionView: UICollectionView!
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            selectedtitle = "Tap To Watch"
            
            self.performSegue(withIdentifier: "VideoToPurchase", sender: self)

        } else {
            
            selectedvideo = videolinks[videoids[indexPath.row-1]]!
            selectedvideoid = videoids[indexPath.row-1]
            selectedtitle = videotitles[videoids[indexPath.row-1]]!
            self.performSegue(withIdentifier: "VideoToWatch", sender: self)
        }
        
        
    }
 
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if locked {
        
        return 24
        
    } else {
        
        if thumbnails.count > 0 {
            
            return thumbnails.count
            
            } else {
            
                return 1
            }
        
        }
    
    }
    
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Videos", for: indexPath) as! VideosCollectionViewCell
        
        //        cell.subscriber.tag = indexPath.row
        
        if locked {
            
            cell.whitelabel.alpha = 0.5
            cell.isUserInteractionEnabled = false
            cell.lockimage.alpha = 1
            
            cell.thumbnail.image = nil
            
            cell.titlelabel.text = ""
            cell.timeago.text = ""
            
        }
        
        if thumbnails.count >= indexPath.row{
            
            if indexPath.row == 0 {
                
                cell.thumbnail.image = myselectedimage
                cell.titlelabel.text = "Subscribe Now"
                cell.timeago.text = "\(selectedsubs) subscribers"
                cell.whitelabel.alpha = 0

                cell.isUserInteractionEnabled = true

                cell.thumbnail.layer.cornerRadius = 10.0
                cell.layer.cornerRadius = 10.0
                cell.layer.masksToBounds = true
                cell.thumbnail.layer.masksToBounds = true
                activityIndicator.alpha = 0
                collectionView.alpha = 1
                activityIndicator.stopAnimating()
                cell.whitelabel.layer.cornerRadius = 10.0
                cell.whitelabel.layer.masksToBounds = true
                cell.lockimage.alpha = 0
                
            } else {
                
                
                
              
                
                if locked {
                    
                    cell.whitelabel.alpha = 0.5
                    cell.isUserInteractionEnabled = false
                    cell.lockimage.alpha = 1
                    
                    cell.thumbnail.image = nil
                    
                    cell.titlelabel.text = ""
                    cell.timeago.text = ""
                    
                } else {
                    
                    cell.lockimage.alpha = 0
                    cell.thumbnail.image = thumbnails[videoids[indexPath.row-1]]
                    
                    cell.titlelabel.text = videotitles[videoids[indexPath.row-1]]
                    cell.timeago.text = videodates[videoids[indexPath.row-1]]
                    
                    cell.whitelabel.alpha = 0
                    
                    cell.isUserInteractionEnabled = true
                }
                
                cell.thumbnail.layer.cornerRadius = 10.0
                cell.layer.cornerRadius = 10.0
                cell.layer.masksToBounds = true
                cell.thumbnail.layer.masksToBounds = true
                activityIndicator.alpha = 0
                collectionView.alpha = 1
                activityIndicator.stopAnimating()
                cell.whitelabel.layer.cornerRadius = 10.0
                cell.whitelabel.layer.masksToBounds = true
            }
            
            //            cell.layer.borderWidth = 1.0
            //            cell.layer.borderColor = UIColor.lightGray.cgColor
            //            cell.subscriber.addTarget(self, action: #selector(tapJoin(sender:)), for: .touchUpInside)
            
   
            
      

        } else {
            
            
        }
        
        
        return cell
    }
    
    var buttonspressedup = [String:String]()
    
    @objc func tapJoin(sender: UIButton){
        
        let buttonTag = sender.tag
        
        
        self.performSegue(withIdentifier: "SaleToBuy", sender: self)
    }
    
    @objc func tapDown(sender: UIButton){
        let buttonTag = sender.tag
        
        
        //            tableView.reloadData()
    }
    
}


