//
//  Overview2ViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 4/9/19.
//  Copyright © 2019 AA Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class Overview2ViewController: UIViewController {

    @IBAction func tapContinue(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
    }
    
    @IBAction func tapB1(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        tapb1.setBackgroundImage(UIImage(named: "OR"), for: .normal)
        
        tapb2.setBackgroundImage(UIImage(named: "WhiteR"), for: .normal)
        
        tapb3.setBackgroundImage(UIImage(named: "WhiteR"), for: .normal)
    }
    @IBAction func tapB2(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        tapb2.setBackgroundImage(UIImage(named: "OR"), for: .normal)
        
        tapb3.setBackgroundImage(UIImage(named: "WhiteR"), for: .normal)
        
        tapb1.setBackgroundImage(UIImage(named: "WhiteR"), for: .normal)
    }
    @IBAction func tapB3(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        tapb3.setBackgroundImage(UIImage(named: "OR"), for: .normal)
 
        tapb2.setBackgroundImage(UIImage(named: "WhiteR"), for: .normal)

        tapb1.setBackgroundImage(UIImage(named: "WhiteR"), for: .normal)

    }
    @IBOutlet weak var tapb1: UIButton!
      @IBOutlet weak var tapb2: UIButton!
      @IBOutlet weak var tapb3: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

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
