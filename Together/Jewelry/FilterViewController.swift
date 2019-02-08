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
        tapb3.alpha = 1
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        tapb2.alpha = 0.5
       
        tapb1.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Brand"
        selectedfilter = "MVMT"
    }
    @IBAction func tapB2(_ sender: Any) {
        tapb2.alpha = 1
        tapnecklaces.alpha = 0
        tapbracelets.alpha = 0
        tapb1.alpha = 0.5
        tapearrings.alpha = 0
        tapb3.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Brand"
        selectedfilter = "Omega"
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
    }
    @IBAction func tapB1(_ sender: Any) {
        
        tapb1.alpha = 1
        tapnecklaces.alpha = 0
        tapbracelets.alpha = 0
        tapb2.alpha = 0.5
        tapearrings.alpha = 0
        tapb3.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Brand"
        selectedfilter = "Rolex"
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
    }

    @IBAction func tapEarr(_ sender: Any) {
        
        tapearrings.alpha = 1
        tapnecklaces.alpha = 0
        tapbracelets.alpha = 0
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Category"
        selectedfilter = "Earrings"
    }
    @IBAction func tapNeck(_ sender: Any) {
        
        tapnecklaces.alpha = 1
        tapearrings.alpha = 0
        tapbracelets.alpha = 0
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Category"
        selectedfilter = "Necklaces"

    }
    @IBAction func tapBrac(_ sender: Any) {
        
        tapbracelets.alpha = 1
        tapnecklaces.alpha = 0
        tapearrings.alpha = 0
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5

        selectedfilter = "Bracelets"
        selectedkey = "Category"
    }
    @IBAction func tapWomen(_ sender: Any) {
        
        tapwomen.alpha = 1
        tapnecklaces.alpha = 0
        tapearrings.alpha = 0
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapbracelets.alpha = 0
        tapmen.alpha = 0.5
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        selectedfilter = "Women"
        selectedkey = "Gender"
    }
    @IBAction func tapMen(_ sender: Any) {
        
        tapmen.alpha = 1
        tapnecklaces.alpha = 0
        tapearrings.alpha = 0
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapbracelets.alpha = 0
        tapwomen.alpha = 0.5
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        selectedfilter = "Men"
        selectedkey = "Gender"
        
    }
    @IBOutlet weak var tapp1: UIButton!
    @IBOutlet weak var tapp2: UIButton!

    @IBOutlet weak var tapp3: UIButton!

    @IBAction func tapP1(_ sender: Any) {
        selectedkey = "Used Price"
        selectedfilter = "5000"
        tapp1.alpha = 1
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        tapmen.alpha = 0.5
        tapnecklaces.alpha = 0
        tapearrings.alpha = 0
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapbracelets.alpha = 0
        tapwomen.alpha = 0.5
    }
    @IBAction func tapP2(_ sender: Any) {
        selectedkey = "Used Price"
        selectedfilter = "1500"
        tapp2.alpha = 1
        tapp1.alpha = 0.5
        tapp3.alpha = 0.5
        tapmen.alpha =  0.5
        tapnecklaces.alpha = 0
        tapearrings.alpha = 0
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapbracelets.alpha = 0
        tapwomen.alpha = 0.5
    }
    @IBAction func tapP3(_ sender: Any) {
        selectedkey = "Used Price"
        selectedfilter = "500"
        tapp3.alpha = 1
        tapp2.alpha = 0.5
        tapp1.alpha = 0.5
        tapmen.alpha =  0.5
        tapnecklaces.alpha = 0
        tapearrings.alpha = 0
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapbracelets.alpha = 0
        tapwomen.alpha = 0.5
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
        
        tapearrings.alpha = 0
        tapnecklaces.alpha = 0
        tapbracelets.alpha = 0
        tapmen.alpha = 0.5
        tapwomen.alpha = 0.5
        tapb1.alpha = 0.5
        tapb2.alpha = 0.5
        tapb3.alpha = 0.5
        
        selectedkey = ""
        selectedfilter = ""
    }
    @IBAction func tapcancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet weak var tapCancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        tapapply.addTextSpacing(2.0)
        tapmen.addTextSpacing(2.0)
        tapwomen.addTextSpacing(2.0)
        tapp1.addTextSpacing(2.0)
        tapp2.addTextSpacing(2.0)
        tapp3.addTextSpacing(2.0)
        HEADER.addCharacterSpacing()
//        tapbracelets.addTextSpacing(2.0)
//        tapearrings.addTextSpacing(2.0)

//        tapnecklaces.addTextSpacing(2.0)

        if selectedfilter == "Earrings" {
            
            tapearrings.alpha = 1
 
        }
        
        if selectedfilter == "Necklaces" {
            
            tapnecklaces.alpha = 1
        
        }
        
        if selectedfilter == "Bracelets" {
            
            tapbracelets.alpha = 1
   
        }
        
        if selectedfilter == "Men" {
            
            tapmen.alpha = 1
            
        }
        if selectedfilter == "Women" {
            
            tapwomen.alpha = 1
            
        }
        
        if selectedfilter == "MVMT" {
            
            tapb3.alpha = 1
            
        }
        
        if selectedfilter == "Rolex" {
            
            tapb1.alpha = 1
            
        }
        
        if selectedfilter == "Omega" {
            
            tapb2.alpha = 1
            
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
