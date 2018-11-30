//
//  ProductViewController.swift
//  
//
//  Created by Alek Matthiessen on 11/29/18.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var b1 = String()
var b2 = String()
var b3 = String()
var b4 = String()
var b5 = String()

var selectedpackaging = String()

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
queryforinfo()
        
        selectedindex == 0
        // Do any additional setup after loading the view.
    }
    
    
    func queryforinfo() {
        
        pricetitles.append("BUY NEW")
        pricetitles.append("BUY USED")
        
        var functioncounter = 0
        ref?.child("Products").child(selectedid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["New Price"] as? String {

                    
                    var intviews = Double(Int(author2.dropFirst())!)
                    intviews = intviews * 1.1
                    author2 = "$\(String(Int(intviews)))"
                    
                    self.prices2.append(author2)
                    
                }
            
            if var author2 = value?["Used Price"] as? String {
                
                var intviews = Double(Int(author2.dropFirst())!)
                intviews = intviews * 1.1
                author2 = "$\(String(Int(intviews)))"

                self.prices2.append(author2)

            }
            
            if var author2 = value?["Bullet1"] as? String {
                
                selecteddescription = author2
                
            }
            
            if var author2 = value?["Bullet2"] as? String {
                
                b2 = author2
                
            }
            
            if var author2 = value?["Bullet3"] as? String {
                
                b3 = author2
                
            }
            if var author2 = value?["Bullet4"] as? String {
                
                b4 = author2
                
            }
            if var author2 = value?["Bullet5"] as? String {
                
                b5 = author2
                
            }
            
            if var author2 = value?["Packaging"] as? String {
                
                selectedpackaging = author2
                
            } else {
                
                selectedpackaging = "None"

            }
        
            self.tableView.reloadData()
            self.collectionView.reloadData()
                
            }
            
            )
            
        }
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    var pricetitles = [String]()
    var prices2 = [String]()

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 1
}
    
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    generator.impactOccurred()
    
            if Auth.auth().currentUser == nil {
                
    // Do smth if user is not logged in
        self.performSegue(withIdentifier: "ProductToRegister", sender: self)
        
    } else {
        
        selectedprice = prices2[indexPath.row]
        
                if indexPath.row == 0 {
                    
                    selectedcondition = "New"
                    
                    selecteddetails = "\(selectedcondition) / \(selectedpackaging)"

                    self.performSegue(withIdentifier: "ProductToSale", sender: self)

                } else {
                    
                    selectedcondition = "Used"
                    selecteddetails = "\(selectedcondition) / \(selectedpackaging)"
                    self.performSegue(withIdentifier: "ProductToSale", sender: self)

                }
        
    }
    
    
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath) as! ProductTableViewCell
    
    cell.mainimage.image = selectedimage
    cell.title.text = selectedname
    cell.descriptionlabel.text = selecteddescription
    cell.b1.text = b1
    cell.b2.text = b2
    cell.b3.text = b3
    cell.b4.text = b4
    cell.b5.text = b5
    
    cell.title.sizeToFit()
    cell.descriptionlabel.sizeToFit()
    cell.b1.sizeToFit()
    cell.b2.sizeToFit()
    cell.b3.sizeToFit()
    cell.b4.sizeToFit()
    cell.b5.sizeToFit()
    
    return cell
}

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if prices2.count > 0 {
        
        return prices2.count
        
    } else {
        
        return 0
    }
    
}
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//
////
////        selectedindex = indexPath.row
////        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
////
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Prices", for: indexPath) as! PricesCollectionViewCell
////     
////        collectionView.reloadData()
//    }
//
var selectedindex = Int()
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Prices", for: indexPath) as! PricesCollectionViewCell
    
    cell.titlelabel.text = pricetitles[indexPath.row]
    cell.priceslabel.text = prices2[indexPath.row]
    
//    if selectedindex == 0 {
//
//        if indexPath.row == 0 {
//
//
//
//        } else {
//
//            cell.titlelabel.alpha = 0.25
//            cell.priceslabel.alpha = 0.25
//        }
//
//
//    } else {
//
//        if indexPath.row == 0 {
//
//            cell.titlelabel.alpha = 0.25
//            cell.priceslabel.alpha = 0.25
//
//        } else {
//
//            cell.titlelabel.alpha = 1
//            cell.priceslabel.alpha = 1
//        }
//
    
    return cell

    }





}
