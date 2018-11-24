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
import YPImagePicker
import AVFoundation
import AVKit
import Photos

class YourChannelViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet weak var tapchoosevideo: UIButton!
    
    @IBAction func tapChooseVideo(_ sender: Any) {
        
        showPicker()
    }
    var imagePickerController = UIImagePickerController()
    var avPlayer = AVPlayer()
    
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
    
    var myString3 = String()
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
                
                self.myString3 = downloadURL.absoluteString
                
                
                
                
               
//                                self.activityIndicator.alpha = 0
//                                self.activityIndicator.stopAnimating()
//                                self.loadinglabel.alpha = 0
                
           
//                                DispatchQueue.main.async {
//                
//                                    self.performSegue(withIdentifier: "UploadToProfile", sender: self)
//                
//                
//                
//                                }
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueTo3rd" {
            
            let nextView = segue.destination as! TabInfluencerViewController
            
            switch (nextViewNumber) {
            case 1:
                nextView.selectedIndex = 2
                
            case 2:
                nextView.selectedIndex = 1
                
            default:
                break
            }
        }
    }

    
    var nextViewNumber = Int()
    @IBOutlet weak var B3: UIButton!
    @IBOutlet weak var B2: UIButton!
    @IBOutlet weak var B1: UIButton!
    @IBAction func b3(_ sender: Any) {
        
        B3.setTitleColor(mypink, for: .normal)
        B2.setTitleColor(.white, for: .normal)
        B1.setTitleColor(.white, for: .normal)
        mychannelprice = "100"
    }
    @IBAction func b2(_ sender: Any) {
        
        B2.setTitleColor(mypink, for: .normal)
        B1.setTitleColor(.white, for: .normal)
        B3.setTitleColor(.white, for: .normal)
        mychannelprice = "25"
    }
    @IBAction func b1(_ sender: Any) {
        
        B1.setTitleColor(mypink, for: .normal)
        B2.setTitleColor(.white, for: .normal)
        B3.setTitleColor(.white, for: .normal)
        mychannelprice = "5"
    }
    
    var strDate = String()
    @IBOutlet weak var tapsign: UIButton!
    
    @IBOutlet weak var paypaltf: UITextField!

    @IBOutlet weak var thumbnailview: UIImageView!
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
        channelname = "24"
        paypalname = "Whatever"
        channelprice = "25"
        
//        if channelname != "" {
             if channelname != "" && paypalname != "" && channelprice != "" && videoURL != nil {
        //        domainz = domainz.replacingOccurrences(of: " ", with: "-")
        //        if email != "" && password != "" && name != "" && domainz != "" {

            
            //
        ref?.child("Influencers").child(uid).updateChildValues(["Channel Name" : channelname, "Price" : channelprice, "PayPal" : paypalname])
//        ref?.child("Influencers").child(uid).updateChildValues(["Channel Name" : channelname])

            
        
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
                    ref!.child("Influencers").child(uid).updateChildValues(["ProPic" : self.myString3])


                    self.nextViewNumber = 1
                    self.performSegue(withIdentifier: "SegueTo3rd", sender: self)
                    
                    //
                    
                }
            }
            
            
        } else {
            
            self.nextViewNumber = 1
            self.performSegue(withIdentifier: "SegueTo3rd", sender: self)
            
        }

        } else {
            
            errorlabel.alpha = 1
        }
    }
    
    var selectedItems = [YPMediaItem]()

    func showPicker() {
        var config = YPImagePickerConfiguration()
        
        config.library.mediaType = .video
        
        config.shouldSaveNewPicturesToAlbum = false
        
        config.video.compression = AVAssetExportPresetMediumQuality
        
        config.startOnScreen = .library
        
        config.screens = [.library, .video]
        
        config.video.libraryTimeLimit = 500.0
        
        config.showsCrop = .rectangle(ratio: (9/16))
        
        config.wordings.libraryTitle = "Choose Video"
        
        config.hidesBottomBar = false
        config.hidesStatusBar = false
        config.library.maxNumberOfItems = 1
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            if cancelled {
                print("Picker was canceled")
                picker.dismiss(animated: true, completion: nil)
                return
            }
            _ = items.map { print("🧀 \($0)") }
            
            self.selectedItems = items
            for item in items {
                switch item {
                case .photo(let photo):
                    
                    print(photo)
                    
                case .video(let video):
                    
                    
                        mythumbnail = video.thumbnail
                        self.thumbnailview.image = mythumbnail
                        self.loadthumbnail()
                    //
                    
                    videoURL = video.url as NSURL
                    let playerVC = AVPlayerViewController()
                        self.avPlayer = AVPlayer(playerItem: AVPlayerItem(url:videoURL as! URL))
                    
                    
                    self.playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill
                    
                    self.playerView.playerLayer.player = self.avPlayer
                    
                    self.playerView.player?.pause()
         
                    self.tabBarController?.tabBar.isHidden = true
                    
                    
                }
            }
            picker.dismiss(animated: true, completion: nil)
            
        }
        
        
        
        present(picker, animated: true, completion: nil)
        
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
    
    @IBOutlet weak var tapBack: UIButton!
    @IBAction func tapback(_ sender: Any) {
        
                self.dismiss(animated: true, completion: {
        
                })
    }
    @IBOutlet weak var demo: UILabel!
    @IBOutlet weak var tapcreate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        errorlabel.alpha = 0
        playerView.layer.cornerRadius = 5.0
        playerView.layer.masksToBounds = true
        thumbnailview.layer.cornerRadius = 5.0
        thumbnailview.layer.masksToBounds = true
        
        shareurl.text = "jointhefam://Profiles/\(uid)"
        selectedshareurl = "jointhefam://Profiles/\(uid)"
        requestlabel.addCharacterSpacing()
        ref = Database.database().reference()
        
        playerView.backgroundColor = .white
        paypaltf.delegate = self
//        channelnametf.delegate = self
   //        emailtf.becomeFirstResponder()
    
        tapsave.addTextSpacing(2.0)

        queryforinfo()
 
        tapchoosevideo.layer.masksToBounds = false
        tapchoosevideo.layer.cornerRadius = tapchoosevideo.frame.height/2
        tapchoosevideo.clipsToBounds = true
        
        
        
        
        self.addLineToView(view: paypaltf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        
        
//        self.addLineToView(view: channelnametf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        
        
    }
    
    @IBAction func tapShare(_ sender: Any) {
        
        let text = "Follow Me on FAM"
        
        var image = UIImage()

            image = UIImage(named: "FamLogo")!
            
        
        let myWebsite = NSURL(string: selectedshareurl)
        let shareAll : Array = [myWebsite] as [Any]
        
        
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.addToReadingList, UIActivityType.postToVimeo, UIActivityType.saveToCameraRoll, UIActivityType.assignToContact]
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    @IBOutlet weak var shareurl: UILabel!
    @IBOutlet weak var errorlabel: UILabel!
    func queryforinfo() {
        
        var functioncounter = 0
        
        ref?.child("Influencers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            
            if var profileUrl2 = value?["ProPic"] as? String {
                // Create a storage reference from the URL
                
                
                if profileUrl2 == "" {
                    self.tapmore.alpha = 0

                    self.tapBack.alpha = 0

                } else {
                    
                    
                    let url = URL(string: profileUrl2)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    selectedimage = UIImage(data: data!)!
                    
                    self.thumbnailview.image = selectedimage
                    
                    self.tapBack.alpha = 1
                    self.tapmore.alpha = 1
                }
                
                
            }
            
            
            
            if var author2 = value?["Subscribers"] as? String {
                
                selectedsubs = author2
            }
            
            
            
            if var author2 = value?["Price"] as? String {
                
                mychannelprice = author2
                
                if mychannelprice == "5" {
                    
                    self.B1.setTitleColor(mypink, for: .normal)
                    self.B2.setTitleColor(.white, for: .normal)
                    self.B3.setTitleColor(.white, for: .normal)
                    mychannelprice = "100"                }
                
                if mychannelprice == "25" {
                    
                    self.B2.setTitleColor(mypink, for: .normal)
                    self.B3.setTitleColor(.white, for: .normal)
                    self.B1.setTitleColor(.white, for: .normal)
                    mychannelprice = "100"                }
                
                if mychannelprice == "100" {
                    
                    self.B3.setTitleColor(mypink, for: .normal)
                    self.B2.setTitleColor(.white, for: .normal)
                    self.B1.setTitleColor(.white, for: .normal)
                    mychannelprice = "100"                }
                self.tapBack.alpha = 1
                self.tapmore.alpha = 1
            
            } else {
                self.tapmore.alpha = 0
                self.tapBack.alpha = 0

            }
            
            if var author2 = value?["PayPal"] as? String {
                
                mypaypal = author2
                self.paypaltf.text = mypaypal
                self.tapBack.alpha = 1
                self.tapmore.alpha = 1

            } else {
                self.tapmore.alpha = 0

                self.tapBack.alpha = 0

            }
            
//            if var author2 = value?["Channel Name"] as? String {
//
//                mychannelname = author2
//                self.channelnametf.text = mychannelname
//                self.tapBack.alpha = 1
//                self.tapmore.alpha = 1
//
//
//            } else {
//                self.tapmore.alpha = 0
//
//                self.tapBack.alpha = 0
//            }
            
            
                
            
  
        })
        
    }
    
    
    
    
    
    
    @IBOutlet weak var tapmore: UIButton!
    
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

