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
            
            getThumbnailFrom(path: videoURL as! URL)

            
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
    
    func getThumbnailFrom(path: URL) -> UIImage? {
        
        do {
            
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            mythumbnail = UIImage(cgImage: cgImage)
            
            //            tapplay.setBackgroundImage(mythumbnail, for: .normal)
            
            
            mythumbnail = cropToBounds(image: mythumbnail, width: 375, height: 667)
            
            loadthumbnail()

            return mythumbnail
            
            
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
            
        }
        
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    func loadthumbnail() {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let currentUser = Auth.auth().currentUser
        
        //        let metaData = StorageMetadata()
        //
        //        metaData.contentType = "image/jpg"
        
        uid = (currentUser?.uid)!
        
        
        
        
        var whatthough = UIImageJPEGRepresentation(mythumbnail, 1.0)
        
        
        let metaData = StorageMetadata()
        
        metaData.contentType = "image/jpg"
        
        // Create a reference to the file you want to upload
        let randomString = UUID().uuidString
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child(randomString)
        
        let uploadTask = riversRef.putData(whatthough!, metadata: metaData) { metadata, error in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print(error?.localizedDescription)
                
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            
            //            metadata.download
            
            
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    print(error?.localizedDescription)
                    return
                }
                
                print(downloadURL)
                
                let mystring2 = downloadURL.absoluteString
                
                
                ref!.child("Influencers").child(uid).updateChildValues(["ProPic" : mystring2])
                    
                    
               
                //                self.activityIndicator.alpha = 0
                //                self.activityIndicator.stopAnimating()
                //                self.loadinglabel.alpha = 0
                
//                self.nextViewNumber = 1
//                self.performSegue(withIdentifier: "SegueTo2nd", sender: self)
                
                //                DispatchQueue.main.async {
                //
                //                    self.performSegue(withIdentifier: "UploadToProfile", sender: self)
                //
                //
                //
                //                }
                
            }
        }
    }
    
    var strDate = String()
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
        ref?.child("Influencers").child(uid).updateChildValues(["Channel Name" : channelname, "Price" : channelprice, "PayPal" : paypalname])
            
            tapsave.alpha = 0.5
        
        if videoURL != nil {
            
            let data = Data()
            
            // Create a reference to the file you want to upload
            
            //        let localFile  = URL(string: )!
            
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let currentUser = Auth.auth().currentUser
            
            //        let metaData = StorageMetadata()
            //
            //        metaData.contentType = "image/jpg"
            
            uid = (currentUser?.uid)!
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "y-MM-dd H:m:ss" //Specify your format that you want
            
            var mystring = videoURL!.absoluteString
            let localFile = URL(string: mystring!)
            
            let timestamp = NSDate().timeIntervalSince1970
            
            let randomString = UUID().uuidString
            // Create a reference to the file you want to upload
            let riversRef = storageRef.child(randomString)
            
            //        let metaData = StorageMetadata()
            //
            //        metaData.contentType = "image/jpg"
            
            // Upload the file to the path "images/rivers.jpg"
            let uploadTask = riversRef.putFile(from: localFile!, metadata: nil) { metadata, error in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    print(error?.localizedDescription)
                    
                    return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                // You can also access to download URL after upload.
                
                //            metadata.download
                
                
                riversRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        print(error?.localizedDescription)
                        return
                    }
                    
                    print(downloadURL)
                    
                    let mystring2 = downloadURL.absoluteString
                    
                    
                    
                        ref!.child("Influencers").child(uid).updateChildValues(["Purchase" : mystring2])
                        

                    
                    
                }
            }
            
            
        }

        
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

        queryforinfo()
 
        tapchoosevideo.layer.masksToBounds = false
        tapchoosevideo.layer.cornerRadius = tapchoosevideo.frame.height/2
        tapchoosevideo.clipsToBounds = true
        
        
        self.addLineToView(view: channeltf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        
        self.addLineToView(view: paypaltf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        
        
        self.addLineToView(view: channelnametf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        

        
        
    }
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        ref?.child("Influencers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            
            if var profileUrl2 = value?["Purchase"] as? String {
                // Create a storage reference from the URL
                
                
                if profileUrl2 == "-" {
                    
                    
                } else {
                    
                    videolinks["0"] = profileUrl2
                    
                    myintrovideo = profileUrl2
                    
                }
                
                
            }
            
            
            
            if var author2 = value?["Subscribers"] as? String {
                
                selectedsubs = author2
            }
            
            
            if var author2 = value?["Price"] as? String {
                
                mychannelprice = author2
            }
            
            if var author2 = value?["PayPal"] as? String {
                
                mypaypal = author2
            }
            
            if var author2 = value?["Channel Name"] as? String {
                
                mychannelname = author2
            }
            
            if mychannelprice != "" {
                
                self.channeltf.text = mychannelprice
            }
            
            if mychannelname != "" {
                
                self.channelnametf.text = mychannelname
            }
            
            if mypaypal != "" {
                
                self.paypaltf.text = mypaypal
            }
            
            if myintrovideo != "" {
                
                //            let asset = AVURLAsset(url: videoURL as! URL , options: nil)
                //            let imgGenerator = AVAssetImageGenerator(asset: asset)
                //            imgGenerator.appliesPreferredTrackTransform = true
                ////            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                //            let thumbnail = UIImage(cgImage: cgImage)
                //            imgView.image = thumbnail
                
                let videourl = URL(string: myintrovideo)
                
                self.avPlayer = AVPlayer(url: videourl! as URL)
                
                
                self.playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill
                
                self.playerView.playerLayer.player = self.avPlayer
                
                self.playerView.player?.pause()
            }
            
        })
        
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

