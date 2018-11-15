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

class WatchViewController: UIViewController {
    @IBAction func tapBack(_ sender: Any) {
        
        
                self.dismiss(animated: true, completion: {
        
                })
        
    }
    
    @IBOutlet weak var playerView: PlayerViewClass!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        
        let videourl = URL(string: selectedvideo)
        
        let avPlayer = AVPlayer(url: videourl! as URL)
        
        playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill
        
        playerView.playerLayer.player = avPlayer
        
        
        
        if playerView.player?.isPlaying == true {
            
            playerView.player?.pause()
            
        } else {
            playerView.player?.play()
            
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
