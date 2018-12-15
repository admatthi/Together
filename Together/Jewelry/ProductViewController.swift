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
var b6 = String()

var selectedpackaging = String()

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
 {

    

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
                
                if author2 != "-" {
                var intviews = Double(Int(author2.dropFirst())!)
                intviews = intviews * 1.1
                author2 = "$\(String(Int(intviews)))"
                
                self.prices2.append(author2)
                    
                } else {
                    
                    self.prices2.append("SOLD OUT")

                }
                
                
            }
          
            
            if var author2 = value?["Description"] as? String {
                
                selecteddescription = author2
                
            }
            
            if var author2 = value?["Gemstone"] as? String {
                
                b2 = author2
                
            }
            
            if var author2 = value?["Weight"] as? String {
                
                b3 = author2
                
            } else {
                
                b3 = "-"

            }
            if var author2 = value?["Color"] as? String {
                
                b4 = author2
                
            }
            if var author2 = value?["Size"] as? String {
                
                b5 = author2
                
            }
            
            if var author2 = value?["Designer"] as? String {
                
                b6 = author2
                
            }
            
            if var author2 = value?["Metal"] as? String {
                
                self.selectedmetal = author2
                
            } else {
                
                self.selectedmetal = "Sterling Silver"

            }
            
            
            if var author2 = value?["Packaging"] as? String {
                
                if author2 != "-" {
                    
                    selectedpackaging = author2

                } else {
                    
                    selectedpackaging = "Original Packaging"

                }
                
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
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    var pricetitles = [String]()
    var prices2 = [String]()
var selectedmetal = String()
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    @objc func tapGo(sender: UIButton) {
        
        selectedimage = images[selectedid]!

        self.performSegue(withIdentifier: "Enlarge", sender: self)
        
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
                    
                    selecteddetails = "\(selectedcondition) / Original Packaging"

                    self.performSegue(withIdentifier: "ProductToCheckout", sender: self)

                } else {
                    
                    selectedcondition = "Used"
                    selecteddetails = "\(selectedcondition) / Pouch: \(selectedpackaging)"
                    self.performSegue(withIdentifier: "ProductToSale", sender: self)

                }
        
    }
    
    
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath) as! ProductTableViewCell
    
    cell.mainimage.image = selectedimage
    cell.title.text = "\(selectedbrand) \(selectedname)"
    cell.tapenlarge.addTarget(self, action: #selector(ProductViewController.tapGo(sender:)), for: .allTouchEvents)

    let attributedString = NSMutableAttributedString(string: selecteddescription)
    
    // *** Create instance of `NSMutableParagraphStyle`
    let paragraphStyle = NSMutableParagraphStyle()
    
    // *** set LineSpacing property in points ***
    paragraphStyle.lineSpacing = 10 // Whatever line spacing you want in points
    
    // *** Apply attribute to string ***
attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
    
    // *** Set Attributed String to your label ***
    cell.descriptionlabel.attributedText = attributedString
    cell.descriptionlabel.textAlignment = .center
    cell.b1.text = b1
    cell.b2.text = b2
    cell.b3.text = b3
    cell.b4.text = b4
    cell.b5.text = b5
    cell.b6.text = b6
    cell.b7.text = selectedmetal

    cell.title.sizeToFit()
    cell.descriptionlabel.sizeToFit()
    cell.b1.sizeToFit()
    cell.b2.sizeToFit()
    cell.b3.sizeToFit()
    cell.b4.sizeToFit()
    cell.b5.sizeToFit()
    cell.b6.sizeToFit()
    cell.b7.sizeToFit()

    cell.h1.addCharacterSpacing()
    cell.h2.addCharacterSpacing()
    cell.h3.addCharacterSpacing()
    cell.h4.addCharacterSpacing()
    cell.h5.addCharacterSpacing()
    cell.h7.addCharacterSpacing()

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
    cell.titlelabel.addCharacterSpacing()
    
    if prices2[indexPath.row] == "SOLD OUT" {
        
        cell.priceslabel.textColor = .gray
        cell.isUserInteractionEnabled = false
        
    } else {
        
        cell.isUserInteractionEnabled = true

    }
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let kWhateverHeightYouWant = 83
        return CGSize(width: collectionView.bounds.size.width/2, height: CGFloat(kWhateverHeightYouWant))
    }

}
