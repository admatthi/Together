//
//  UpdateProfileViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/12/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var newpropic = String()
var selectedemail = String()
var selecteddomain = String()

class UpdateProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var email = String()
    var password = String()
    var inputname = String()
    var domainz = String()
    var inputdescription = String()
    var inputprice = String()
    var inputprogramname = String()
    var phonenumber = String()
    
    
    @IBOutlet weak var pdtf: UITextField!
    @IBOutlet weak var pntf: UITextField!
    @IBOutlet weak var pn2tf: UITextField!
    
    @IBOutlet weak var nametf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var emailtf: UITextField!

    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var domainlabel: UILabel!
    
    @IBAction func tapDone(_ sender: Any) {
        
        email = "\(emailtf.text!)"
        inputname = "\(nametf.text!)"
        inputdescription = "\(pdtf.text!)"
        inputprogramname = "\(pn2tf.text!)"
        phonenumber = "\(pntf.text!)"
        
        uploadimage()

    }
    @IBAction func tapAdd(_ sender: Any) {
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
//        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        profileimage.image = image
        selectedimage = image
    }

    
    @IBOutlet weak var tapadd: UIButton!
    @IBOutlet weak var profileimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        profileimage.layer.masksToBounds = false
        profileimage.layer.cornerRadius = profileimage.frame.height/2
        profileimage.clipsToBounds = true
        
        tapadd.layer.cornerRadius = tapadd.frame.height/2
        tapadd.clipsToBounds = true
        
        emailtf.delegate = self
        nametf.delegate = self
        emailtf.becomeFirstResponder()
        
        
        self.addLineToView(view: pntf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        self.addLineToView(view: pdtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        self.addLineToView(view: pn2tf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        self.addLineToView(view: pdtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        self.addLineToView(view: nametf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        self.addLineToView(view: emailtf, position:.LINE_POSITION_BOTTOM, color: UIColor.lightGray, width: 0.5)
        
        
        
            nametf.text = selectedname
        
            pn2tf.text = selectedprogramname
        
            pdtf.text = selectedpitch
            emailtf.text = selectedemail
            pntf.text = selectednumber
            domainlabel.text = "\(selecteddomain).joinmyfam.com"
            pricelabel.text = "$\(selectedprice)"
        // Do any additional setup after loading the view.
    }
    
    var imagePickerController = UIImagePickerController()

    func uploadimage() {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let currentUser = Auth.auth().currentUser
        
        //        let metaData = StorageMetadata()
        //
        //        metaData.contentType = "image/jpg"
        
        uid = (currentUser?.uid)!
        
        
        
        
        var whatthough = UIImageJPEGRepresentation(selectedimage, 1.0)
        
        
        let metaData = StorageMetadata()
        
        metaData.contentType = "image/jpg"
        
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
                
                let newpropic = downloadURL.absoluteString
                ref?.child("Influencers").child(uid).updateChildValues(["Description" : self.inputdescription, "Phone Number" : self.phonenumber, "ProgramName" : self.inputprogramname, "ProPic" : newpropic, "Name" : self.inputname, "Email" : self.email])
                
                self.dismiss(animated: true, completion: {
                    
                })
            }
        }
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
       
//        if pntf.text != "" && pdftf.text != "" && nametf.text != "" {
//
//                uploadimage()
//
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
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
