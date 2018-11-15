//
//  TabInfluencerViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/14/18.
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

class TabInfluencerViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self

        // Do any additional setup after loading the view.
    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
//        let application = UIApplication.shared.delegate as! AppDelegate
//        let tabbarController = application.window?.rootViewController as! UITabBarController
//        let selectedIndex = tabbarController.selectedIndex
//
//
//        if selectedIndex == 1 {
//            //do your stuff
//
//            imagePickerController.sourceType = .photoLibrary
//            imagePickerController.delegate = self
//            imagePickerController.mediaTypes = ["public.movie"]
//            present(imagePickerController, animated: true, completion: nil)
//
//        }
        
    }
    
  

    
    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    
        print("Selected view controller")
        
        
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
