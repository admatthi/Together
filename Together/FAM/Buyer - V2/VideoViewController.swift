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
        
        if linkedin {
            
            self.performSegue(withIdentifier: "VideoToExplore", sender: self)
            
        } else {
                self.dismiss(animated: true, completion: {
        
                })
            
        }
    }
    @IBOutlet weak var tapback: UIButton!
    
    @IBOutlet weak var programname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedname == "" {
            
            queryforname()
            
            linkedin = true
            
            
        } else {
            
            linkedin = false
            tapback.alpha = 1
            selectedname = selectedname.uppercased()

        }
        
        lowercasename = selectedname
        
        selectedshareurl = "jointhefam://Profiles/\(selectedid)"

        activityIndicator.color = mypink

        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        collectionView.alpha = 0
        errorlabel.alpha = 0
        programname.text = selectedname
        programname.addCharacterSpacing()
        //        tableView.rowHeight = UITableViewAutomaticDimension
        
        //        cta.text = "Join \(firstname)'s FAM"
        
        locked = true
        
        queryforids { () -> () in
            
            self.queryforinfo()
            
        }
        
        if uid == selectedid {
            
            locked = false
            
        }
        
        if myprojectids.contains(selectedid) {
            
            locked = false
            
        }
        
        ref = Database.database().reference()
        
 
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            locked = true
            
        } else {
            
            if selectedid == unlockedid {
                
                locked = false

                
            }
            
        
            
//            queryforpurchased()
            
        }
        
        
        collectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
  
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        collectionView.alpha = 0
        errorlabel.alpha = 1
        activityIndicator.alpha = 0
        
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
                
                self.errorlabel.alpha = 0
                self.activityIndicator.alpha = 1
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
    
    func queryforname() {
        
        ref?.child("Influencers").child(selectedid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var author2 = value?["Name"] as? String {
                selectedname = author2
                lowercasename = author2
                selectedname = selectedname.uppercased()
                self.programname.text = selectedname
                self.programname.addCharacterSpacing()
                
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
        
        if locked {
            
            self.performSegue(withIdentifier: "VideoToPurchase", sender: self)

        } else {
            
//            selectedvideo = videolinks[videoids[indexPath.row]]!
            selectedvideoid = videoids[indexPath.row]
            selectedtitle = videotitles[videoids[indexPath.row]]!
            self.performSegue(withIdentifier: "VideoToWatch", sender: self)
        }
        
        
    }
 
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if thumbnails.count > 0 {
            
        return thumbnails.count
            
    } else {
            
        return 1
    }
        
    
    }
    
    @IBOutlet weak var errorlabel: UILabel!
    
    @IBAction func tapShare(_ sender: Any) {
        
        let text = "\(selectedname) on FAM"
        
        var image = UIImage()
        if thumbnails.count > 0 {
            
            image = thumbnails[videoids[0]]!
            
        } else {
            
            image = UIImage(named: "FamLogo")!
            
        }
        let myWebsite = NSURL(string: selectedshareurl)
        let shareAll : Array = [text , image , myWebsite] as [Any]
        
        
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.addToReadingList, UIActivityType.postToVimeo, UIActivityType.saveToCameraRoll, UIActivityType.assignToContact]
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Videos", for: indexPath) as! VideosCollectionViewCell
        
        //        cell.subscriber.tag = indexPath.row

        cell.layer.cornerRadius = 10.0
        cell.layer.masksToBounds = true
        cell.thumbnail.layer.cornerRadius = 10.0
        cell.thumbnail.layer.masksToBounds = true
        if thumbnails.count > indexPath.row{
            
            collectionView.alpha = 1
            errorlabel.alpha = 0
            activityIndicator.alpha = 0
            cell.thumbnail.image = thumbnails[videoids[indexPath.row]]
                    
            cell.titlelabel.text = videotitles[videoids[indexPath.row]]
            cell.timeago.text = videodates[videoids[indexPath.row]]
            
            cell.isUserInteractionEnabled = true
            
            
        } else {
            
            collectionView.alpha = 0
            
        }
                
            return cell
        
            //            cell.layer.borderWidth = 1.0
            //            cell.layer.borderColor = UIColor.lightGray.cgColor
            //            cell.subscriber.addTarget(self, action: #selector(tapJoin(sender:)), for: .touchUpInside)
            
   
    
        
        
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


