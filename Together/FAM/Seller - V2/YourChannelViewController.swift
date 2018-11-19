//
//  YourChannelViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/19/18.
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
import AVKit

class YourChannelViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet weak var tapchoosevideo: UIButton!
    
    @IBAction func tapChooseVideo(_ sender: Any) {
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    var imagePickerController = UIImagePickerController()
    var avPlayer = AVPlayer()
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        videoURL = info[UIImagePickerControllerMediaURL]as? NSURL
        print(videoURL!)
        do {
            let asset = AVURLAsset(url: videoURL as! URL , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            //            imgView.image = thumbnail
            
            avPlayer = AVPlayer(url: videoURL! as URL)
            
            playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill
            
            playerView.playerLayer.player = avPlayer
            
            playerView.player?.pause()
            
            //            let item = AVPlayerItem(asset: asset)
            //            let player = AVQueuePlayer(playerItem: item)
            //            let videoLooper = AVPlayerLooper(player: player, templateItem: item)
            //
            //            videoLooper.

            
        } catch let error {
            
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var playerView: PlayerViewClass!
    var channelname = String()
    var channelprice = String()
    var paypalname = String()

    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == mygray {
            textView.text = ""
            textView.textColor = UIColor.white
        }
    }
    

    @IBOutlet weak var tapsign: UIButton!
    
    @IBOutlet weak var paypaltf: UITextField!

    @IBOutlet weak var tapsave: UIButton!
    @IBOutlet weak var channelnametf: UITextField!
    @IBOutlet weak var channeltf: UITextField!
    @IBAction func tapSave(_ sender: Any) {
        
        
        self.view.endEditing(true)
        
        //        pn2tf.text = " "
        //        pricetf.text = " "
        //        pdtf.text = " "
        //        domaintf.text = " "
        //
        channelname = "\(channelnametf.text!)"
        paypalname = "\(paypaltf.text!)"
        channelprice = "\(channeltf.text!)"
        
        //        domainz = domainz.replacingOccurrences(of: " ", with: "-")
        //        if email != "" && password != "" && name != "" && domainz != "" {

            
            //
        ref?.child("Influencers").child(uid).updateChildValues(["Channel Name" : channelname, "Channel Price" : channelprice, "PayPal" : paypalname])
            
            tapsave.alpha = 0.5
        
        
        
        
        //        }
        
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        //        self.dismiss(animated: true, completion: {
        //
        //        })
    }
    

    //    func signup() {
    //
    //        var email = "\(emailtf.text!)"
    //        var password = "\(passwordtf.text!)"
    //        var name = "\(nametf.text!)"
    //        var domain = "\(domaintf.text!)"
    //
    //        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
    //
    //            if let error = error {
    //
    //                self.errorlabel.alpha = 1
    //                self.errorlabel.text = error.localizedDescription
    //
    //                return
    //
    //            } else {
    //
    //                uid = (Auth.auth().currentUser?.uid)!
    //
    //                //                ref!.child("Users").child(uid).child("Purchased").child(selectedid).updateChildValues(["Title": "x"])
    //
    //                let date = Date()
    //                let calendar = Calendar.current
    //                let dateFormatter = DateFormatter()
    //                dateFormatter.dateFormat = "MM-dd-yy"
    //                var todaysdate =  dateFormatter.string(from: date)
    //                let thirtyDaysAfterToday = Calendar.current.date(byAdding: .day, value: +30, to: date)!
    //                let thirty = dateFormatter.string(from: thirtyDaysAfterToday)
    //
    //                //                self.addstaticbooks()
    //                ref?.child("Users").child(uid).updateChildValues(["Email" : email, "Influencer" : "True", "Password": password, "Name" : name, "Domain" : domain, "Approved" : "False"])
    //
    //
    //
    //
    //                DispatchQueue.main.async {
    //
    //                    //                    purchased = true
    //
    //                    self.performSegue(withIdentifier: "InfluencerToThankYou", sender: self)
    //                }
    //            }
    //
    //        }
    //
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    @IBOutlet weak var requestlabel: UILabel!
    
    @IBOutlet weak var demo: UILabel!
    @IBOutlet weak var tapcreate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        playerView.layer.cornerRadius = 5.0
        playerView.layer.masksToBounds = true
        requestlabel.addCharacterSpacing()
        ref = Database.database().reference()
        
        channeltf.delegate = self
        paypaltf.delegate = self
        channelnametf.delegate = self
   //        emailtf.becomeFirstResponder()
    
        tapsave.layer.cornerRadius = 22.0
        tapsave.layer.masksToBounds = true

        
 
        self.addLineToView(view: channeltf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        
        self.addLineToView(view: paypaltf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        
        
        self.addLineToView(view: channelnametf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        

        
        
    }
    
    @IBOutlet weak var errorlabel: UILabel!
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    enum LINE_POSITION {
        case LINE_POSITION_TOP
        case LINE_POSITION_BOTTOM
    }
    
    func addLineToView(view : UIView, position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        view.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        default:
            break
        }
    }
}

