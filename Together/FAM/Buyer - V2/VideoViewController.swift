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

var selecteddate = String()
var selectedvideoid = String()
var selecteddaytitle = String()

class VideoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func tapBack(_ sender: Any) {
        
        if linkedin {
            
            self.performSegue(withIdentifier: "VideoToExplore", sender: self)
            
        } else {
            
                self.dismiss(animated: true, completion: {
        
                })
            
        }
    }
    @IBOutlet weak var tapback: UIButton!
    
    @IBAction func tapCircle(_ sender: Any) {
        
        if locked {
            
            self.performSegue(withIdentifier: "VideoToPurchase", sender: self)
            
        } else {
            
            
        }
    }
    @IBAction func tapSubscribe(_ sender: Any) {
        
        if locked {
            
            self.performSegue(withIdentifier: "VideoToPurchase", sender: self)

        } else {
            
            
        }
    }
    @IBOutlet weak var tapcircle: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var subscribers: UILabel!
    @IBOutlet weak var posts: UILabel!
    @IBOutlet weak var monthlabel: UILabel!
    @IBOutlet weak var subscriblabel: UILabel!
    @IBOutlet weak var postlabel: UILabel!
    @IBOutlet weak var tapsubscribe: UIButton!
    @IBOutlet weak var programname: UILabel!
    @IBOutlet weak var lockimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tapsubscribe.layer.masksToBounds = true
//        tapsubscribe.layer.cornerRadius = 5.0
        
        monthlabel.addCharacterSpacing()
        subscriblabel.addCharacterSpacing()
        postlabel.addCharacterSpacing()
        lowercasename = selectedname

        queryforname()

        if linkedin  {
            
            tapback.alpha = 0
            

        } else {
            
            tapback.alpha = 1
            selectedname = selectedname.uppercased()

        }
        
        tableView.layer.cornerRadius = 5.0
        tableView.layer.masksToBounds = true
        tapsubscribe.addTextSpacing(2.0)
        
        activityIndicator.color = mypink

        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        tableView.alpha = 0
        errorlabel.alpha = 0
        programname.text = selectedname
        programname.addCharacterSpacing()
        programname.sizeToFit()
        
        lilthumbnail.layer.masksToBounds = false
        lilthumbnail.layer.cornerRadius = lilthumbnail.frame.height/2
        lilthumbnail.clipsToBounds = true
        
        lilthumbnail.image = myselectedimage
        //        tableView.rowHeight = UITableViewAutomaticDimension
        
        //        cta.text = "Join \(firstname)'s FAM"
        
        locked = true

        
        ref = Database.database().reference()
        
 
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            locked = true
            tapsubscribe.alpha = 1
            tapcircle.alpha = 1
            tableView.alpha = 0
            lockimage.alpha = 1
            activityIndicator.alpha = 0
            
        } else {
         
        
            if uid == selectedid || myprojectids.contains(selectedid)  || selectedid == unlockedid  {
                
                locked = false
                tapsubscribe.alpha = 0
                tapcircle.alpha = 0
                tableView.alpha = 1
                lockimage.alpha = 0
                
                queryforids { () -> () in
                    
                    self.queryforinfo()
                    
                }
            }
            
//            queryforpurchased()
            
        }
        
        
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
  
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        tableView.alpha = 0
        errorlabel.alpha = 1
        activityIndicator.alpha = 0
        
        var functioncounter = 0
        
        
        videoids.removeAll()
        videolinks.removeAll()
        videodescriptions.removeAll()
        videotitles.removeAll()
        thumbnails.removeAll()
        videodates.removeAll()
        videodaytitles.removeAll()
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
                        self.posts.text = "\(videoids.count)"
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
    }
    
    @IBOutlet weak var lilthumbnail: UIImageView!
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
            
            
            if var profileUrl2 = value?["ProPic"] as? String {
                // Create a storage reference from the URL
                
                
                if profileUrl2 == "" {
                    
                    self.lilthumbnail.alpha = 0
                    
                } else {
                    
                    self.lilthumbnail.alpha = 1
                    
                    let url = URL(string: profileUrl2)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    selectedimage = UIImage(data: data!)!
                    
                    self.lilthumbnail.image = selectedimage
                    
                }
                
                
            }
            
            if var author2 = value?["Domain"] as? String {
                
                selectedshareurl = author2
                
            }
            
            if var author2 = value?["Price"] as? String {
                
                self.price.text = "$\(author2)"
                
            }
            
            if var author2 = value?["Subscribers"] as? String {
                
                self.subscribers.text = "\(author2)"
                
            }
            
        })
        
    }
    
    var videotitles = [String:String]()
    var videodaytitles = [String:String]()
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
                
                if var author2 = value?["DayTitle"] as? String {
                    self.videodaytitles[each] = author2
                    
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
                
                if var author2 = value?["Domain"] as? String {
                    
                    selectedshareurl = author2
                    
                }
                
                if functioncounter == videoids.count {
                    
                    self.tableView.reloadData()
                    
                }
                
                
            })
            
        }
    }
    @IBOutlet weak var tableView: UITableView!
    /*
     @IBOutlet weak var tableView: UItableView!
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if locked {
            

        } else {
            
//            selectedvideo = videolinks[videoids[indexPath.row]]!
            selectedvideoid = videoids[indexPath.row]
            selecteddate = videodates[videoids[indexPath.row]]!
            selectedtitle = videotitles[videoids[indexPath.row]]!
            selecteddaytitle = videodaytitles[videoids[indexPath.row]]!
            
            self.performSegue(withIdentifier: "VideoToWatch", sender: self)
        }
        
        
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        let shareAll : Array = [myWebsite] as [Any]
        
        
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.addToReadingList, UIActivityType.postToVimeo, UIActivityType.saveToCameraRoll, UIActivityType.assignToContact]
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Plans", for: indexPath) as! PlansTableViewCell
        
        //        cell.subscriber.tag = indexPath.row

//        cell.layer.cornerRadius = 10.0
//        cell.layer.masksToBounds = true
//        cell.thumbnail.layer.cornerRadius = 10.0
//        cell.thumbnail.layer.masksToBounds = true
//
        cell.selectionStyle = .none
        if thumbnails.count > indexPath.row{
            
            tableView.alpha = 1
            errorlabel.alpha = 0
            activityIndicator.alpha = 0
            cell.thumbnail.image = thumbnails[videoids[indexPath.row]]
                    
            cell.titlelabel.text = videotitles[videoids[indexPath.row]]
            cell.timeago.text = videodates[videoids[indexPath.row]]
            cell.timeago.text = videodates[videoids[indexPath.row]]?.uppercased()
            cell.timeago.addCharacterSpacing()
            
//            cell.titlelabel.sizeToFit()
//            cell.timeago.text = "\(videodaytitles[videoids[indexPath.row]]!)"

            cell.isUserInteractionEnabled = true
            
            
        } else {
            
            tableView.alpha = 0
            
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


