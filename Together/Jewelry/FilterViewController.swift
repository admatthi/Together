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
        tapnecklaces.alpha = 0.5
        tapbracelets.alpha = 0.5
        tapb2.alpha = 0.5
        tapearrings.alpha = 0.5
        tapb1.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Brand"
        selectedfilter = "Gucci"
    }
    @IBAction func tapB2(_ sender: Any) {
        tapb2.alpha = 1
        tapnecklaces.alpha = 0.5
        tapbracelets.alpha = 0.5
        tapb1.alpha = 0.5
        tapearrings.alpha = 0.5
        tapb3.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Brand"
        selectedfilter = "Tiffany & Co."
    }
    @IBAction func tapB1(_ sender: Any) {
        
        tapb1.alpha = 1
        tapnecklaces.alpha = 0.5
        tapbracelets.alpha = 0.5
        tapb2.alpha = 0.5
        tapearrings.alpha = 0.5
        tapb3.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Brand"
        selectedfilter = "David Yurman"
    }

    @IBAction func tapEarr(_ sender: Any) {
        
        tapearrings.alpha = 1
        tapnecklaces.alpha = 0.5
        tapbracelets.alpha = 0.5
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
        tapearrings.alpha = 0.5
        tapbracelets.alpha = 0.5
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
        tapnecklaces.alpha = 0.5
        tapearrings.alpha = 0.5
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
        tapnecklaces.alpha = 0.5
        tapearrings.alpha = 0.5
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapbracelets.alpha = 0.5
        tapmen.alpha = 0.5
        
        selectedfilter = "Women"
        selectedkey = "Gender"
    }
    @IBAction func tapMen(_ sender: Any) {
        
        tapmen.alpha = 1
        tapnecklaces.alpha = 0.5
        tapearrings.alpha = 0.5
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapbracelets.alpha = 0.5
        tapwomen.alpha = 0.5
        
        selectedfilter = "Men"
        selectedkey = "Gender"
        
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
        tapmen.addTextSpacing(2.0)
        tapwomen.addTextSpacing(2.0)
        
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
        
        if selectedfilter == "Gucci" {
            
            tapb3.alpha = 1
            
        }
        
        if selectedfilter == "David Yurman" {
            
            tapb2.alpha = 1
            
        }
        
        if selectedfilter == "Tiffany & Co." {
            
            tapb1.alpha = 1
            
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
