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
import AVFoundation
import AVKit
import MobileCoreServices

var videoURL : NSURL?

var yourprogramname = String()
var mythumbnail = UIImage()
var yourpropic = UIImage()
class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBAction func tapShare(_ sender: Any) {
        
        if videoURL != nil {
        let data = Data()
        
        // Create a reference to the file you want to upload
        
//        let localFile  = URL(string: )!


        if tv.text != "" && tv2.text != "" {
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
        dateFormatter.dateFormat = "yyyy-MM-dd HH" //Specify your format that you want
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
            ref!.child("Influencers").child(uid).child("Plans").child(self.strDate).updateChildValues(["URL" : mystring2, "Description" : self.tv.text!, "Title" : self.tv2.text!])

                self.loadthumbnail()
                
           
                
            }
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
                ref!.child("Influencers").child(uid).child("Plans").child(self.strDate).updateChildValues(["Thumbnail" : mystring2])
                
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
            
            let avPlayer = AVPlayer(url: videoURL! as URL)
            
            playerView.playerLayer.videoGravity  = AVLayerVideoGravity.resizeAspectFill
            
            playerView.playerLayer.player = avPlayer
            
            getThumbnailFrom(path: videoURL as! URL)


//            playerView.player?.play()

            
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    @IBOutlet weak var programname: UILabel!
    @IBAction func tapBack(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        present(imagePickerController, animated: true, completion: nil)
    }
    @IBOutlet weak var propic: UIImageView!

    override func viewDidAppear(_ animated: Bool) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
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

    
    override func viewDidLoad() {
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        present(imagePickerController, animated: true, completion: nil)
        
        ref = Database.database().reference()

        tv.text = "Write a caption..."
        tv.textColor = UIColor.lightGray
        tv2.text = "Title"
        tv2.textColor = UIColor.lightGray
        tapplay.alpha = 1
        queryforinfo()
        programname.addCharacterSpacing()
        self.addLineToView(view: tv2, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        self.addLineToView(view: tv, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)

//        propic.layer.masksToBounds = false
//        propic.layer.cornerRadius = propic.frame.height/2
//        propic.clipsToBounds = true
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        strDate = dateFormatter.string(from: date)
        
     
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
    
    func getThumbnailFrom(path: URL) -> UIImage? {
        
        do {
            
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            mythumbnail = UIImage(cgImage: cgImage)
            
//            tapplay.setBackgroundImage(mythumbnail, for: .normal)
            
//            loadthumbnail()

            mythumbnail = cropToBounds(image: mythumbnail, width: 375, height: 375)
            
            return mythumbnail
            
            
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
            
        }
        
    }
    
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
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
}