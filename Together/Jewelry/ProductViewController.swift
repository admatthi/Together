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

var productimages = [UIImage]()

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
 {

    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tapsell.layer.borderColor = UIColor.black.cgColor
        tapsell.addTextSpacing(2.0)
        tapsell.layer.borderWidth = 0.5
        
        ref = Database.database().reference()
        queryforinfo()
        
        counter = 0
        selectedindex == 0
        collectionView.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.85)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapSell(_ sender: Any) {
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarBuyer : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Buyer") as! UITabBarController
        
        tabBarBuyer.selectedIndex = 2
        UIApplication.shared.keyWindow?.rootViewController = tabBarBuyer
    }
    @IBOutlet weak var tapsell: UIButton!
    
    func queryforinfo() {
        
        pricetitles.append("BUY NEW")
        pricetitles.append("BUY USED")
        productimages.removeAll()
        
        var functioncounter = 0
        ref?.child("Products").child(selectedid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var author2 = value?["New Price"] as? String {

                    if author2 != "null" {
                    
                        
                    var intviews = Double(Int(author2.dropFirst())!)
                    intviews = intviews * 1.15
                    author2 = "$\(String(Int(intviews)))"
                    
                    self.prices2.append(author2)
                        
                    } else {
                        
                        self.prices2.append("Not Available")

                    }
                    
                }
            
            if var author2 = value?["Used Price"] as? Int {
                
                if author2 != 0 {
                var intviews = Double(author2)
                intviews = intviews * 1.3
                var author3 = "$\(String(Int(intviews)))"
                
                self.prices2.append(author3)
                    
                } else {
                    
                    self.prices2.append("SOLD OUT")

                }
                
                
            }
          
            
            if var author2 = value?["Description"] as? String {
                
                selecteddescription = author2
                
            }
            
            if var author2 = value?["Case"] as? String {
                
                b3 = author2
                
            } else {
                
                if var author2 = value?["Case"] as? Int {
                    
                    b3 = "\(author2)"
                } else {
                    
                    if var author2 = value?["Case"] as? Double {
                        
                        b3 = "\(author2)"
                    }
                }
                
            }
          
            
            if var author2 = value?["Case Size"] as? String {
                
                b2 = author2
//                if author2 == "-" {
//
//                    b2 = author2
//                    b3 = author2
//
//                } else {
//
//                    b2 = author2
//
//                    if var author2 = value?["Gemstone Weight"] as? String {
//
//                        if author2 == "-" {
//
//                            b3 = "4mm"
//
//                        } else {
//
//                            b3 = author2
//                        }
//
//
//                    }
//                }
                
            } else {
                
                if var author2 = value?["Case Size"] as? Int {
                    
                    b2 = String(author2)
                    
                } else {
                    
                    if var author2 = value?["Case Size"] as? Double {
                        
                        b2 = "\(String(author2)) mm"
                        
                    }
                    
                }

            }
//
//            if var author2 = value?["Gemstone Weight"] as? String {
//
//                if author2 == "-" {
//
//                    b3 = "4mm"
//
//                } else {
//                    b3 = author2
//                }
//
//
//            } else {
//
//                b3 = "-"
//
//            }
            if var author2 = value?["Strap"] as? String {
                
                b4 = author2
                
            } else {
                
                b4 = "-"

            }
            if var author2 = value?["Release"] as? Int {
                
              
                    b5 = String(author2)
                
            } else {
                
                if var author2 = value?["Release"] as? String {
                    
                    if author2 == "-" {
                        
                        b5 = "-"
                    } else {
                        
                        b5 = author2
                    }
                }
                
            }
            
            if var profileUrl = value?["Image2"] as? String {
                // Create a storage reference from the URL
                let url = URL(string: profileUrl)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                var image4 = UIImage(data: data!)!
                
                productimages.append(image4)
                
            }
            
            if var profileUrl = value?["Image3"] as? String {
                // Create a storage reference from the URL
                let url = URL(string: profileUrl)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                var image4 = UIImage(data: data!)!
                
                productimages.append(image4)
            }
            
            if var profileUrl = value?["Image4"] as? String {
                // Create a storage reference from the URL
                let url = URL(string: profileUrl)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                var image4 = UIImage(data: data!)!
                
                productimages.append(image4)
            }
            
            if var profileUrl = value?["Image5"] as? String {
                // Create a storage reference from the URL
                let url = URL(string: profileUrl)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                var image4 = UIImage(data: data!)!
                
                productimages.append(image4)
            }
            
            if var author2 = value?["Movement"] as? String {
                
                if author2 == "-" {
                    
                    b6 = "\(selectedbrand)"

                } else {
                    
                b6 = author2
                    
                }
                
            }
            
            if var author2 = value?["Water Resistance"] as? String {
                
                if author2 == "-" {

                    self.selectedmetal = "Sterling Silver"

                } else {
                    
                    self.selectedmetal = author2

                }
                
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
    
    @objc func tapNext(sender: UIButton) {
        
        counter += 1

        print(counter)
        
        if counter < productimages.count {
            
        
            tableView.reloadData()
            
        }
    }
    
    var counter = Int()
    
    @objc func tapBack(sender: UIButton) {
        
        counter -= 1

        if counter > productimages.count {
        
            tableView.reloadData()
        
        }
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
    
    print(counter)
    
    if counter > 0 {
        
        if counter < productimages.count {
        
            cell.mainimage.image = productimages[counter]
        
    }
        
    } else {
        
        cell.mainimage.image = selectedimage
        
    }
    
    
    cell.title.text = "\(selectedbrand) \(selectedname)"
    cell.tapenlarge.addTarget(self, action: #selector(ProductViewController.tapGo(sender:)), for: .allTouchEvents)

    cell.tapright.addTarget(self, action: #selector(ProductViewController.tapNext(sender:)), for: .allTouchEvents)
    
    cell.tapleft.addTarget(self, action: #selector(ProductViewController.tapBack(sender:)), for: .allTouchEvents)
    
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
