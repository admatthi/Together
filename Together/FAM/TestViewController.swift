//
//  TestViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/17/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import YPImagePicker
import AVFoundation

class TestViewController: UIViewController {


    var config = YPImagePickerConfiguration()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        config.library.maxNumberOfItems = 3

        config.screens = [.library, .video]
        config.library.mediaType = .video
        
        config.library.maxNumberOfItems = 3

        picker = YPImagePicker(configuration: config)

        picker.didFinishPicking { [unowned picker] items, cancelled in
            if cancelled {
                print("Picker was canceled")
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let video = items.singleVideo {
                print(video.fromCamera)
                print(video.thumbnail)
                print(video.url)
                
                
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
    }

    var picker = YPImagePicker()
    
    @IBOutlet weak var image: UIImageView!

    @IBAction func tapShow(_ sender: Any) {
        
        present(picker, animated: true, completion: nil)

       
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
