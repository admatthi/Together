//
//  WatchViewController.swift
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

var lowercasename = String()

class WatchViewController: UIViewController {
    @IBAction func tapBack(_ sender: Any) {
        
        
                self.dismiss(animated: true, completion: {
        
                })
        
    }
    
    @IBOutlet weak var influencername: UILabel!
    @IBOutlet weak var playerView: PlayerViewClass!

    @IBOutlet weak var tapwelcome: UIButton!
    @IBOutlet weak var profileimage: UIImageView!
    
    @IBAction func tapWelcome(_ sender: Any) {
        
        let alert = UIAlertController(title: "Make Welcome Video?", message: "Are you sure you'd like to make this your welcome video?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
                //                self.playerView.player?.pause()
               
                ref?.child("Influencers").child(selectedid).updateChildValues(["ProPic" : selectedthumbnailurl, "Purchase" : selectedvideo])

                
                ref?.child("Influencers").child(selectedid).child("Plans").child(selectedvideoid).removeValue()

                ref!.child("Influencers").child(selectedid).child("Plans").childByAutoId().updateChildValues(["Date" : thisdate, "Thumbnail" : thumbnailurls["0"], "Title" : "", "URL" : videolinks["0"]])
                
                self.performSegue(withIdentifier: "WatchToNav", sender: self)
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBOutlet weak var tapdelete: UIButton!
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if playerView.player?.isPlaying == true {
            
            playerView.player?.pause()
            
        } else {
            playerView.player?.play()
            
        }
    }
    
    @IBAction func tapDelete(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete?", message: "Are you sure you'd like to remove this video?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
//                self.playerView.player?.pause()
 ref?.child("Influencers").child(selectedid).child("Plans").child(selectedvideoid).removeValue()

            self.performSegue(withIdentifier: "WatchToNav", sender: self)
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBOutlet weak var videotitle: UILabel!
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        
        if let playerItem: AVPlayerItem = notification.object as? AVPlayerItem {
            
            playerItem.seek(to: kCMTimeZero, completionHandler: nil)
            print("done")
            
            self.playerView.player?.play()
            
        }
        
    }
    
    var avPlayer = AVPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(WatchViewController.playerItemDidReachEnd),
                                               name: Notification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
        
        ref = Database.database().reference()

        influencername.text = lowercasename
        videotitle.text = selectedtitle
        profileimage.image = myselectedimage
        
        profileimage.layer.masksToBounds = true
        profileimage.layer.cornerRadius = 5.0
        
        let videourl = URL(string: selectedvideo)
        
        avPlayer = AVPlayer(url: videourl! as URL)
        
        playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill
        
        playerView.playerLayer.player = avPlayer
        
        
        
        if playerView.player?.isPlaying == true {
            
            playerView.player?.pause()
            
        } else {
            playerView.player?.play()
            
        }
        
        if uid == selectedid {
            
            tapdelete.alpha = 1
            tapwelcome.alpha = 1
            
        } else {
            
            tapdelete.alpha = 0
            tapwelcome.alpha = 0
        }
        

        // Do any additional setup after loading the view.
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
