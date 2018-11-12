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

class UpdateProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var nametf: UITextField!
    
    @IBAction func tapAdd(_ sender: Any) {
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        profileimage.image = image
        selectedimage = image
    }

    
    @IBOutlet weak var tapadd: UIButton!
    @IBOutlet weak var pdftf: UITextField!
    @IBOutlet weak var pntf: UITextField!
    @IBOutlet weak var profileimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        profileimage.layer.masksToBounds = false
        profileimage.layer.cornerRadius = profileimage.frame.height/2
        profileimage.clipsToBounds = true
        
        tapadd.layer.masksToBounds = false
        tapadd.layer.cornerRadius = tapadd.frame.height/2
        tapadd.clipsToBounds = true
        
        pdftf.delegate = self
        pntf.delegate = self
        nametf.delegate = self
        nametf.becomeFirstResponder()
        
        if selectedname != "-" {
            
            nametf.text = selectedname
        }
        
        if selectedprogramname != "-" {
            
            pntf.text = selectedprogramname
        }
        
        if selectedpitch != "-" {
            
            pdftf.text = selectedpitch
        }
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
        
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child(uid)
        
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
                ref!.child("Influencers").child(uid).updateChildValues(["ProgramName" : self.pntf.text!, "Description" : self.pdftf.text!, "Name" : self.nametf.text!, "ProPic" : newpropic])
                
                self.performSegue(withIdentifier: "UpdateToEdit", sender: self)
                
            }
        }
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
       
        if pntf.text != "" && pdftf.text != "" && nametf.text != "" {
            
                uploadimage()
            
        }
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

}
