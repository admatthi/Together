//
//  UploadViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/11/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import MobileCoreServices
import YPImagePicker
import AVFoundation
import AVKit
import Photos

var videoURL : NSURL?
var thisdate = String()
var videodates = [String:String]()
var yourprogramname = String()
var mythumbnail = UIImage()
var yourpropic = UIImage()
class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var loadinglabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func tapShare(_ sender: Any) {
        
        tapcancel.alpha = 0
        tapshare.alpha = 0
        var snaplabel = String()
        if tv2.text != "" {
            
            snaplabel = tv2.text!
            
        } else {
            
            snaplabel = " "
        }
        headerlabel.text = "Uploading...This May Take A Moment."
        headerlabel.alpha = 1
//        headerlabel.addCharacterSpacing()
        
        if playerView.player?.isPlaying == true {
            
            playerView.player?.pause()
            
        } else {
            
        }
        
        activityIndicator.alpha = 1
        activityIndicator.color = mypink
        activityIndicator.startAnimating()
        loadinglabel.alpha = 1
        
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

                
                if noothervids == true {
                    
                    ref!.child("Influencers").child(uid).updateChildValues(["Purchase" : mystring2])

                        noothervids = false
                    
                } else {
                    
                    ref!.child("Influencers").child(uid).child("Plans").child(self.strDate).updateChildValues(["URL" : mystring2, "Title" : snaplabel, "Date" : thisdate])

                }
                self.loadthumbnail()
                
           
                
            }
        }
                
            
        }
    }
    var strDate = String()
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
                
                
                if noothervids == true {
                    
                    ref!.child("Influencers").child(uid).updateChildValues(["ProPic" : mystring2])
                    
                    
                } else {
                    
                ref!.child("Influencers").child(uid).child("Plans").child(self.strDate).updateChildValues(["Thumbnail" : mystring2])

                    
                }
//                self.activityIndicator.alpha = 0
//                self.activityIndicator.stopAnimating()
//                self.loadinglabel.alpha = 0
                
                self.nextViewNumber = 1
                self.performSegue(withIdentifier: "SegueTo2nd", sender: self)
                
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
    @IBOutlet weak var imgView: UIImageView!
    var imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var tapplay: UIButton!
    @IBAction func btnSelectVideo_Action(_ sender: Any) {
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.delegate = self
//        imagePickerController.mediaTypes = [kUTTypeMovie as String]
//        present(imagePickerController, animated: true, completion: nil)
        
        playerView.player?.play()
        tapplay.alpha = 0
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.title = "Choose Video"
    }
    @IBOutlet weak var playerView: PlayerViewClass!
    
    @IBOutlet weak var tv2: UITextView!
    @IBOutlet weak var tv: UITextView!
    
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
            
//            getThumbnailFrom(path: videoURL as! URL)
            tv2.alpha = 0

            playerView.player?.play()

//            let item = AVPlayerItem(asset: asset)
//            let player = AVQueuePlayer(playerItem: item)
//            let videoLooper = AVPlayerLooper(player: player, templateItem: item)
//
//            videoLooper.
            headerlabel.alpha = 0
            tapshowtv.alpha = 1
            tapshare.alpha = 1
            tapnew.alpha = 0
            tapcancel.alpha = 0.5
            self.tabBarController?.tabBar.isHidden = true

        } catch let error {
            
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    /*
     @IBAction func tapCancel(_ sender: Any) {
     }
     // MARK: - Navigation
     @IBOutlet weak var tapcancel: UIButton!
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func tapCancel(_ sender: Any) {
        
        self.tabBarController?.tabBar.isHidden = false

        tapcancel.alpha = 0
        tapshare.alpha = 0
        tapshowtv.alpha = 0
        tapnew.alpha = 1
        headerlabel.alpha = 1
        playerView.player?.replaceCurrentItem(with: nil)
        
    }
    
    @IBOutlet weak var tapcancel: UIButton!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    var selectedItems = [YPMediaItem]()

    @IBOutlet weak var programname: UILabel!
    @IBAction func tapBack(_ sender: Any) {
    
        showPicker()
        
    }
    var selectedImageV = UIImage()

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
        config.library.maxNumberOfItems = 5
        let picker = YPImagePicker(configuration: config)

        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            if cancelled {
                print("Picker was canceled")
                picker.dismiss(animated: true, completion: nil)
                return
            }
            _ = items.map { print("🧀 \($0)") }
            
            self.selectedItems = items
            if let firstItem = items.first {
                switch firstItem {
                case .video(let video):
                    self.selectedImageV = video.thumbnail
                    
                    let videoURL = video.url
                    let playerVC = AVPlayerViewController()
                    self.avPlayer = AVPlayer(playerItem: AVPlayerItem(url:videoURL))
                    
                    
                    self.playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill
                    
                    self.playerView.playerLayer.player = self.avPlayer
                    
                    //            getThumbnailFrom(path: videoURL as! URL)
                    
                    self.playerView.player?.play()
                    self.headerlabel.alpha = 0
                    self.tapshowtv.alpha = 1
                    self.tapshare.alpha = 1
                    self.tapnew.alpha = 0
                    self.tapcancel.alpha = 0.5
                    self.tabBarController?.tabBar.isHidden = true
                    
                    picker.dismiss(animated: true, completion: { [weak self] in
//                        self?.present(playerVC, animated: true, completion: nil)
//                        print("😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
                    })
                case .photo(let photo):
                    
//                    self.selectedImageV.image = photo.image
                    picker.dismiss(animated: true, completion: nil)
                }
            
            }
        }
        
        present(picker, animated: true, completion: nil)

    }
    
    func showResults() {
        if selectedItems.count > 0 {
            let gallery = YPSelectionsGalleryVC(items: selectedItems) { g, _ in
                g.dismiss(animated: true, completion: nil)
            }
            let navC = UINavigationController(rootViewController: gallery)
            self.present(navC, animated: true, completion: nil)
        } else {
            print("No items selected yet.")
        }
    }
    @IBOutlet weak var propic: UIImageView!

    @IBOutlet weak var tapnew: UIButton!
    @IBOutlet weak var tapshare: UIButton!
    override func viewDidAppear(_ animated: Bool) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "y-MM-dd H:m:ss" //Specify your format that you want
        strDate = dateFormatter.string(from: date)
        


        
    }
    
    private var nextViewNumber = Int()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueTo2nd" {
            
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

    @IBOutlet weak var headerlabel: UILabel!
    override func viewDidDisappear(_ animated: Bool) {
        
        if playerView.player?.isPlaying == true {
            
            playerView.player?.pause()
            
        } else {
            
        }
    }

    
    override func viewDidLoad() {
        
        self.tabBarController?.tabBar.isHidden = false

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UploadViewController.playerItemDidReachEnd),
                                               name: Notification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
        
        tapshowtv.alpha = 0
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.delegate = self
//        imagePickerController.mediaTypes = [kUTTypeMovie as String]
//        present(imagePickerController, animated: true, completion: nil)
        
        
        tapnew.alpha = 1
        tapshare.alpha = 0
        tapcancel.alpha = 0
        
        ref = Database.database().reference()
    
        self.activityIndicator.alpha = 0
        self.loadinglabel.alpha = 0
        tv2.text = ""
        tv2.tintColor = .white
//        tv2.textColor = UIColor.white
        
        tv2.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.5)


//        tapplay.alpha = 1
        queryforinfo()
        headerlabel.text = "UPLOAD"
        headerlabel.addCharacterSpacing()
        self.addLineToView(view: tv2, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

//        propic.layer.masksToBounds = false
//        propic.layer.cornerRadius = propic.frame.height/2
//        propic.clipsToBounds = true
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "y-MM-dd H:m:ss.SSSS" //Specify your format that you want
        strDate = dateFormatter.string(from: date)
        tv2.alpha = 0

        dateFormatter.dateFormat = "MMM dd"

        thisdate = dateFormatter.string(from: date)
        
        
     
        //            imgView.image = thumbnail
//        NotificationCenter.default.addObserver(self, selector: #selector(UploadViewController.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(UploadViewController.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
//
//        let asset = AVURLAsset(url: videoURL as! URL , options: nil)
//        let imgGenerator = AVAssetImageGenerator(asset: asset)
//        imgGenerator.appliesPreferredTrackTransform = true
//        let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
//        let thumbnail = UIImage(cgImage: cgImage)
        //            imgView.image = thumbnail
        
//        let avPlayer = AVPlayer(url: videoURL! as URL)
//        
//        playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill
//        
//        playerView.playerLayer.player = avPlayer
//        
//        playerView.player?.pause()
    }
    

    @IBOutlet weak var tapshowtv: UIButton!
    @IBAction func tapShowTV(_ sender: Any) {
        
        if tv2.alpha == 1 {
            
            tv2.alpha = 0
            self.view.endEditing(true)

        } else {
            
            tv2.alpha = 1
            
            
            tv2.becomeFirstResponder()
            
        }
   

    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        
        if let playerItem: AVPlayerItem = notification.object as? AVPlayerItem {
            
            playerItem.seek(to: kCMTimeZero, completionHandler: nil)
            print("done")
            
            self.playerView.player?.play()
            
        }
        
    }
//
//    func getThumbnailFrom(path: URL) -> UIImage? {
//
//        do {
//
//            let asset = AVURLAsset(url: path , options: nil)
//            let imgGenerator = AVAssetImageGenerator(asset: asset)
//            imgGenerator.appliesPreferredTrackTransform = true
//            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
//            mythumbnail = UIImage(cgImage: cgImage)
//
////            tapplay.setBackgroundImage(mythumbnail, for: .normal)
//
////            loadthumbnail()
//
//            mythumbnail = cropToBounds(image: mythumbnail, width: 375, height: 667)
//
//            return mythumbnail
//
//
//
//        } catch let error {
//
//            print("*** Error generating thumbnail: \(error.localizedDescription)")
//            return nil
//
//        }
//
//    }
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        
        
        ref?.child("Influencers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var author2 = value?["ProgramName"] as? String {
                
                yourprogramname = author2
//                self.programname.text = yourprogramname

                
            }
            
            if var productimagee = value?["ProPic"] as? String {
                
                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                    
                    let url = URL(string: productimagee)
                    
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    
                    if data != nil {
                        
                        let productphoto = UIImage(data: (data)!)
                        
//                        yourpropic = productphoto!
//                        self.propic.image = yourpropic
//                        self.programname.text = yourprogramname
                        
                    }
                    
                    
                }
            }
            
            
        })
        
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

    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
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
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.textAlignment = .left

//        if textView.textColor == UIColor.lightGray {
//            textView.text = ""
//            textView.textColor = UIColor.white
//        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.textAlignment = .center

    }

}
