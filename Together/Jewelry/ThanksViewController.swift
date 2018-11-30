//
//  ThanksViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/30/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class ThanksViewController: UIViewController {
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var tapView: UIButton!
    @IBOutlet weak var tapContinue: UIButton!
    @IBAction func tapcontinue(_ sender: Any) {
    }
    @IBAction func tapview(_ sender: Any) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        header.addCharacterSpacing()
        
        tapContinue.addTextSpacing(2.0)
        tapView.addTextSpacing(2.0)
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
