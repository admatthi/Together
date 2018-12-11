//
//  BuyerTabBarViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 12/10/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class BuyerTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.tabBar.translucent = true
//        self.tabBar.alpha = 0.0
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
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
