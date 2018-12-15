//
//  FilterViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 12/14/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

var selectedfilter = String()

class FilterViewController: UIViewController {
    @IBOutlet weak var tapb3: UIButton!
    
    @IBOutlet weak var HEADER: UILabel!
    @IBAction func tapApply(_ sender: Any) {
        
       
    }
    @IBAction func tapB3(_ sender: Any) {
    }
    @IBAction func tapB2(_ sender: Any) {
    }
    @IBAction func tapB1(_ sender: Any) {
    }
    @IBAction func tapNew(_ sender: Any) {
    }
    @IBAction func tapUsed(_ sender: Any) {
    }
    @IBAction func tapEarr(_ sender: Any) {
        
        tapearrings.alpha = 1
        tapnecklaces.alpha = 0.5
        tapbracelets.alpha = 0.5
        selectedfilter = "Earrings"
    }
    @IBAction func tapNeck(_ sender: Any) {
        
        tapnecklaces.alpha = 1
        tapearrings.alpha = 0.5
        tapbracelets.alpha = 0.5
        selectedfilter = "Necklaces"

    }
    @IBAction func tapBrac(_ sender: Any) {
        
        tapbracelets.alpha = 1
        tapearrings.alpha = 0.5
        tapnecklaces.alpha = 0.5
        selectedfilter = "Bracelets"
    }
    @IBAction func tapWomen(_ sender: Any) {
    }
    @IBAction func tapMen(_ sender: Any) {
    }
    @IBOutlet weak var tapapply: UIButton!
    @IBOutlet weak var tapb2: UIButton!
    @IBOutlet weak var tapb1: UIButton!
    @IBOutlet weak var tapnew: UIButton!
    @IBOutlet weak var tapused: UIButton!
    @IBOutlet weak var tapearrings: UIButton!
    @IBOutlet weak var tapnecklaces: UIButton!
    @IBOutlet weak var tapbracelets: UIButton!
    @IBOutlet weak var tapwomen: UIButton!
    @IBOutlet weak var tapmen: UIButton!
    @IBAction func tapClear(_ sender: Any) {
        
        tapearrings.alpha = 0.5
        tapnecklaces.alpha = 0.5
        tapbracelets.alpha = 0.5
        selectedfilter = ""
    }
    @IBAction func tapcancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet weak var tapCancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        tapapply.addTextSpacing(2.0)
        HEADER.addCharacterSpacing()
//        tapbracelets.addTextSpacing(2.0)
//        tapearrings.addTextSpacing(2.0)

//        tapnecklaces.addTextSpacing(2.0)

        if selectedfilter == "Earrings" {
            
            tapearrings.alpha = 1
            tapbracelets.alpha = 0.5
            tapnecklaces.alpha = 0.5
        }
        
        if selectedfilter == "Necklaces" {
            
            tapnecklaces.alpha = 1
            tapbracelets.alpha = 0.5
            tapearrings.alpha = 0.5
        }
        
        if selectedfilter == "Bracelets" {
            
            tapbracelets.alpha = 1
            tapearrings.alpha = 0.5
            tapnecklaces.alpha = 0.5
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
