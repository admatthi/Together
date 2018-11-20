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

var yoursubscribers = String()
var yourmrr = String()
var yourtotalreve = String()

class RevenueViewController: UIViewController {
    @IBOutlet weak var mrr: UILabel!
    
    @IBOutlet weak var domainlabel: UILabel!
    @IBOutlet weak var totalrevenue: UILabel!
    @IBOutlet weak var payingsubscribers: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
       backlabel.layer.cornerRadius = 5.0
        backlabel.layer.masksToBounds = true
        
        HEADERLABEL.addCharacterSpacing()
        tapshare.alpha = 0
        nofollows.alpha = 0
        ref = Database.database().reference()
        
        
        propic.layer.masksToBounds = false
        propic.layer.cornerRadius = propic.frame.height/2
        propic.clipsToBounds = true
        
        queryforinfo()
        
//        tapmonthly.setTitle("Paid Subscribers", for: .normal)
//        tapsubscribers.setTitle("Monthly Revenue", for: .normal)
//        tapmonthly.alpha = 1
//        tapsubscribers.alpha = 0.25
//        taptotal.alpha = 0.25
        descriptivelabel.text = "Total Active Subscribers"
        realvalue.text = "0"
        
    
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tapsubscribers: UIButton!
    
    @IBOutlet weak var tapshare: UIButton!
    
    @IBAction func tapShare(_ sender: Any) {
        
        let textToShare = "Check out my app"
        
        if let myWebsite = URL(string: "http://\(yourdomain))") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite, UIAccessibilityTraitImage ] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = sender as! UIView
            self.present(activityVC, animated: true, completion: nil)
        }
        
        
    }
    
    
    @IBOutlet weak var nofollows: UILabel!
    @IBOutlet weak var realvalue: UILabel!
    @IBOutlet weak var descriptivelabel: UILabel!
    @IBOutlet weak var tapmonthly: UIButton!
    @IBAction func tapSubscribers(_ sender: Any) {
        
        
        tapsubscribers.alpha = 1
        tapmonthly.alpha = 0.25
        taptotal.alpha = 0.25
        descriptivelabel.text = "Monthly Recurring Revenue"
        realvalue.text = "$\(yourmrr)"
        
    }

    @IBAction func tapMonthly(_ sender: Any) {
        
        tapmonthly.alpha = 1
        tapsubscribers.alpha = 0.25
        taptotal.alpha = 0.25
        descriptivelabel.text = "Total Paid Subscribers"
        realvalue.text = yoursubscribers
    }
    @IBOutlet weak var taptotal: UIButton!
    @IBOutlet weak var HEADERLABEL: UILabel!
    @IBAction func tapTotal(_ sender: Any) {
        
        taptotal.alpha = 1
        tapmonthly.alpha = 0.25
        tapsubscribers.alpha = 0.25
        descriptivelabel.text = "Total Revenue"
        realvalue.text = "$\(yourtotalreve)"
        
    }
    
    @IBOutlet weak var backlabel: UILabel!
    var yourdomain = String()
    func queryforinfo() {
        
        yoursubscribers = "0"
        yourmrr = "0"
        yourtotalreve = "0"
        var functioncounter = 0
            
            ref?.child("Influencers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                if var author2 = value?["Subscribers"] as? String {
                    
                    selectedsubs = author2
                    if author2 == "0" {
                        
//                        self.nofollows.alpha = 1
                        
                    } else {
                        
                        self.nofollows.alpha = 0
                    }
//                    let numberFormatter = NumberFormatter()
//                    numberFormatter.numberStyle = NumberFormatter.Style.decimal
//                    let formattedNumber = numberFormatter.string(from: NSNumber(value:Int(author2)!))
//                    yoursubscribers = formattedNumber!
//                    self.realvalue.text = yoursubscribers

                    if var author3 = value?["Price"] as? String {
                        
//                    var newprice = Double(Int(author2)!) * Double(Int(author3)!)
                        
//                        var newprice = Double(Int(author3)!)
//
//                        let numberFormatter = NumberFormatter()
//                        numberFormatter.numberStyle = NumberFormatter.Style.decimal
//                        let formattedNumber = numberFormatter.string(from: NSNumber(value:Int(newprice)))
//                        yourmrr = formattedNumber!

                    }
                    
                }
                
                if var author4 = value?["Total Revenue"] as? String {
                    
//                    let numberFormatter = NumberFormatter()
//                    numberFormatter.numberStyle = NumberFormatter.Style.decimal
//                    let formattedNumber = numberFormatter.string(from: NSNumber(value:Int(author4)!))
//                    yourtotalreve = formattedNumber!

                }
                
                if var author5 = value?["Domain"] as? String {
                    
//                    self.yourdomain = "\(author5).joinmyfam.com"
//                    self.domainlabel.text = self.yourdomain
//                    self.tapshare.alpha = 0
                }
                
                if var views = value?["Name"] as? String {
                    
                    selectedname = views
                }
                
                if var views = value?["ProgramName"] as? String {
                    
                    selectedprogramname = views
                    self.programname.text = selectedprogramname
                    
                } else {
                    
                    selectedprogramname = "-"
                    self.programname.text = selectedprogramname
                }
   
//                if var profileUrl = value?["ProPic"] as? String {
//                    // Create a storage reference from the URL
//                    
//                    let url = URL(string: profileUrl)
//                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//                    myselectedimage = UIImage(data: data!)!
//                    self.propic.image = selectedimage
//
//                }
                    
                
                
            })
            
        }
    @IBOutlet weak var propic: UIImageView!
    @IBOutlet weak var programname: UILabel!
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


