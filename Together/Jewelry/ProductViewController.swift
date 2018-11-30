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

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
queryforinfo()
        
        // Do any additional setup after loading the view.
    }
    
    
    func queryforinfo() {
        
        pricetitles.append("BUY NEW")
        pricetitles.append("BUY USED")
        
        var functioncounter = 0
        ref?.child("Products").child(selectedid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["New Price"] as? String {

                    self.prices2.append(author2)
                    
                }
            
            if var author2 = value?["Used Price"] as? String {
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
        
        selectedprice = prices2[indexPath.row]
    
        self.performSegue(withIdentifier: "<#T##String#>", sender: <#T##Any?#>)
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

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Prices", for: indexPath) as! PricesCollectionViewCell
    
    cell.titlelabel.text = pricetitles[indexPath.row]
    cell.priceslabel.text = prices2[indexPath.row]
    
    return cell

    }





}
