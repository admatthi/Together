//
//  RevenueViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/12/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class RevenueViewController: UIViewController {
    @IBOutlet weak var mrr: UILabel!
    
    @IBOutlet weak var totalrevenue: UILabel!
    @IBOutlet weak var payingsubscribers: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        ref = Database.database().reference()

        
        queryforinfo()
        // Do any additional setup after loading the view.
    }
    
    func queryforinfo() {
        
        var functioncounter = 0
            
            ref?.child("Influencers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                if var author2 = value?["Subscribers"] as? String {
                    
                    self.payingsubscribers.text = author2
                    
                    if var author3 = value?["Price"] as? String {
                        
                        var newprice = Double(Int(author2)!) * Double(Int(author3)!)
                        
                        self.mrr.text = "$\(String(Int(newprice)))"
                        
                    }
                    
                }
                
                if var author4 = value?["Total Revenue"] as? String {
                    
                    self.totalrevenue.text = "$\(author4)"
                    
                }
   
                
                
            })
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


