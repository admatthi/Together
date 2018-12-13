//
//  BrandViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/29/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class BrandViewController: UIViewController {

    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var saleslabel2: UILabel!
    @IBOutlet weak var sales3: UILabel!
    @IBOutlet weak var mainimage: UIImageView!
    @IBOutlet weak var saleslabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        mainimage.image = selectedimage
        sales3.addCharacterSpacing()
        saleslabel.addCharacterSpacing()
        saleslabel2.addCharacterSpacing()
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
