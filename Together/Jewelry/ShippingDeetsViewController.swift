//
//  ShippingDeetsViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 12/1/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class ShippingDeetsViewController: UIViewController {
    @IBOutlet weak var price: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectedcondition == "New" {
            
            price.setTitle("Complimentary ($0)", for: .normal)
        } else {
            
            
            price.setTitle("Standard ($10)", for: .normal)
            
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
