//
//  LargeImageViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 12/11/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class LargeImageViewController: UIViewController {

    @IBOutlet weak var bigimage2: UIImageView!
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectedimage != nil {
            
        bigimage2.image = selectedimage
            
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
