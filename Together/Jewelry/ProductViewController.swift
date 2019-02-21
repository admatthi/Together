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
var b7 = String()

var k1 = String()
var k2 = String()
var k3 = String()
var k4 = String()
var k5 = String()
var k6 = String()
var k7 = String()

var selectedpackaging = String()

var productimages = [UIImage]()

var myselectedimage = UIImage()

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
 {

    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        tapsell.layer.borderColor = UIColor.black.cgColor
        tapsell.addTextSpacing(2.0)
        tapsell.layer.borderWidth = 0.5
        
        ref = Database.database().reference()
        queryforinfo()
        
        counter = 0
        selectedindex == 0
    
        activityIndicator.color = myblue
        tableView.alpha = 0
        collectionView.alpha = 0
        collectionView.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.85)

        var swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ProductViewController.respondToSwipeGesture(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ProductViewController.respondToSwipeGesture(gesture:)))
        
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
  
        
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
            
         
            
            if var author4 = value?["New Price"] as? String {
                
                if author4 == "null" {
                    
                    self.prices2.append("OUT OF STOCK")
                }
                
            } else {
                
                if var author4 = value?["New Price"] as? Int {
                    
                    self.prices2.append("$\(author4)")
                    
                } else {
                    
                    if var author4 = value?["New Price"] as? Double {
                        
                        self.prices2.append("$\(author4)")

                    }
                }
            }
            
            
            if var author1 = value?["Used Price"] as? Int {
                
                if author1 != 0 {
                var intviews = Double(author1)
                intviews = intviews * 1.15
                    self.myusedint = Int(Double(intviews))

                var author3 = "$\(String(Int(intviews)))"
                
                
                self.prices2.append(author3)
                    
                } else {
                    
                    self.prices2.append("SOLD OUT")

                }
                
                
            }
          
          
           
            if var author2 = value?["Description"] as? String {
                
                selecteddescription = author2
                
            } else {
                
                selecteddescription = " "

            }
            
            
            if var author2 = value?["Key 3"] as? String {
                
                k1 = author2
                
            }
            
            if var author2 = value?["Value 3"] as? String {
                
                b1 = author2
                
            } else {
                
                if var author2 = value?["Value 3"] as? Int {
                    
                    b1 = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 3"] as? Double {
                        
                        b1 = "\(author2)"
                    }
                }
                
            }
            
      
            if var author2 = value?["Key 10"] as? String {
                
                k2 = author2
                
            }
            
            if var author2 = value?["Value 10"] as? String {
                
                b2 = author2
                
            } else {
                
                if var author2 = value?["value 10"] as? Int {
                    
                    b2 = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 10"] as? Double {
                        
                        b2 = "\(author2)"
                    }
                }
                
            }
            
            if var author2 = value?["Key 9"] as? String {
                
                k3 = author2
                
            }
            
            if var author2 = value?["Value 9"] as? String {
                
                b3 = author2
                
            } else {
                
                if var author2 = value?["Value 9"] as? Int {
                    
                    b3 = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 9"] as? Double {
                        
                        b3 = "\(author2)"
                    }
                }
                
            }
            
            if var author2 = value?["Key 6"] as? String {
                
                k4 = author2
                
            }
            
            if var author2 = value?["Value 6"] as? String {
                
                b4 = author2
                
            } else {
                
                if var author2 = value?["Value 6"] as? Int {
                    
                    b4 = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 6"] as? Double {
                        
                        b4 = "\(author2)"
                    }
                }
                
            }
            
            if var author2 = value?["Key 7"] as? String {
                
                k5 = author2
                
            }
            
            if var author2 = value?["Value 7"] as? String {
                
                b5 = author2
                selectedpackaging = author2
                
            } else {
                
                if var author2 = value?["Value 7"] as? Int {
                    
                    b5 = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 7"] as? Double {
                        
                        b5 = "\(author2)"
                    }
                }
                
            }
            
            if var author2 = value?["Key 8"] as? String {
                
                k6 = author2
                
            }
            
            if var author2 = value?["Value 8"] as? String {
                
                b6 = author2
                
            } else {
                
                if var author2 = value?["Value 8"] as? Int {
                    
                    b6 = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 8"] as? Double {
                        
                        b6 = "\(author2)"
                    }
                }
                
            }
            
            if var author2 = value?["Key 11"] as? String {
                
                k7 = author2
                
            }
            
            if var author2 = value?["Value 11"] as? String {
                
                b7 = author2
                
            } else {
                
                if var author2 = value?["Value 11"] as? Int {
                    
                    b7 = "\(author2)"
                    
                } else {
                    
                    if var author2 = value?["Value 11"] as? Double {
                        
                        b7 = "\(author2)"
                    }
                }
                
            }
            
            if var profileUrl = value?["Image 2"] as? String {
                // Create a storage reference from the URL
                
                if profileUrl == "null" {
                    
                } else {
                    
                let url = URL(string: profileUrl)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                var image4 = UIImage(data: data!)!
                
                productimages.append(image4)
                
                }
            }
            
            if var profileUrl = value?["Image 3"] as? String {
                // Create a storage reference from the URL
                
                if profileUrl == "null" {
                    
                } else {
                    
                let url = URL(string: profileUrl)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                var image4 = UIImage(data: data!)!
                
                productimages.append(image4)
                    
                }
            }
            
            if var profileUrl = value?["Image 4"] as? String {
                // Create a storage reference from the URL
                
                if profileUrl == "null" {
                    
                } else {
                    
                let url = URL(string: profileUrl)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                var image4 = UIImage(data: data!)!
                
                productimages.append(image4)
                    
                }
            }
            
            if var profileUrl = value?["Image 5"] as? String {
                // Create a storage reference from the URL
                
                if profileUrl == "null" {
                    
                } else {
                    
                let url = URL(string: profileUrl)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                var image4 = UIImage(data: data!)!
                
                productimages.append(image4)
                    
                }
            }
            
     
            
//        
//            
//            if var author2 = value?["Packaging"] as? String {
//                
//                if author2 != "-" {
//                    
//                    selectedpackaging = author2
//
//                } else {
//                    
//                    selectedpackaging = "Original Packaging"
//
//                }
//                
//            } else {
//                
//                selectedpackaging = "None"
//
//            }
        
//            self.prices2.rev
            self.tableView.reloadData()
            self.collectionView.reloadData()
            self.tableView.alpha = 1
            self.collectionView.alpha = 1
            self.activityIndicator.alpha = 0
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
        
        if counter > 0 {
            
            
            myselectedimage = productimages[counter-1]
            self.performSegue(withIdentifier: "Enlarge", sender: self)

        } else {
            
            myselectedimage = selectedimage
            self.performSegue(withIdentifier: "Enlarge", sender: self)

        }
        

        
    }
    
    @objc func tapNext(sender: UIButton) {
        
       
    }
    
    func connected() {
        
        
        print(counter)
        
        if counter < productimages.count {
            counter += 1

            
            tableView.reloadData()
            
        }
        
        
        
    }
    
    var counter = Int()
    
     func tapLeft() {
        print(counter)


        if counter > 0 {
        
            counter -= 1

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
                    
                    if prices2.contains("OUT OF STOCK") {
                        
                        
                    } else {
                        
                    selectedcondition = "New"
                    
                    selecteddetails = "\(selectedcondition) / \(selectedpackaging)"

                    self.performSegue(withIdentifier: "ProductToCheckout", sender: self)
                        
                    }

                } else {
                    
                    selectedcondition = "Used"
                    selecteddetails = "\(selectedcondition) / \(selectedpackaging)"
                    self.performSegue(withIdentifier: "ProductToCheckout", sender: self)

                }
        
    }
    
    
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                tapLeft()
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                connected()
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath) as! ProductTableViewCell
    
    print(counter)
    
  
        
    
    if counter > 0 {

        
        cell.mainimage.image = productimages[counter-1]
        
    } else {
        
        cell.mainimage.image = selectedimage
        
    }
    
    
    
    cell.title.text = "\(selectedbrand) \(selectedname)"
//    cell.tapenlarge.addTarget(self, action: #selector(ProductViewController.tapGo(sender:)), for: .allTouchEvents)

//    cell.tapright.addTarget(self, action: #selector(ProductViewController.tapNext(sender:)), for: .allTouchEvents)
    
    cell.tapright.addTarget(self, action: #selector(ProductViewController.tapGo(sender:)), for: .touchUpInside)
//
//    cell.tapleft.addTarget(self, action: #selector(ProductViewController.tapLeft(sender:)), for: .allTouchEvents)
    
    
    if productimages.count > 0 && counter == 0  {
        
        cell.progressView.setProgress(0.1, animated: true)

    } else {
    
        if counter == 0 {
            
            cell.progressView.setProgress(0.0, animated: false)

        } else {
            
        let fractionalProgress = Float(counter) / Float(productimages.count)
    
        cell.progressView.setProgress(fractionalProgress, animated: true)
        
        }
    }
    
        if selecteddescription == "null" {
            
            cell.descriptionlabel.text = " "
        } else {
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
        
        }
     
      
            
    cell.b1.text = b1
    cell.b2.text = b2

    cell.b3.text = b3
    cell.b4.text = b4
    cell.b5.text = b5
    cell.b6.text = b6

        cell.h1.text = k1.uppercased()
        cell.h2.text = k2.uppercased()
        cell.h3.text = k3.uppercased()
        cell.h4.text = k4.uppercased()
        cell.h5.text = k5.uppercased()
        cell.h6.text = k6.uppercased()

    cell.title.sizeToFit()
    cell.descriptionlabel.sizeToFit()
    cell.b1.sizeToFit()
    cell.b3.sizeToFit()
    cell.b4.sizeToFit()
    cell.b5.sizeToFit()
    cell.b6.sizeToFit()

        cell.h1.addCharacterSpacing()
        cell.h2.addCharacterSpacing()
        cell.h3.addCharacterSpacing()
        cell.h4.addCharacterSpacing()
        cell.h5.addCharacterSpacing()
        cell.h6.addCharacterSpacing()
    cell.h1.addCharacterSpacing()
    cell.h2.addCharacterSpacing()
    cell.h3.addCharacterSpacing()
    cell.h4.addCharacterSpacing()
    cell.h5.addCharacterSpacing()
    cell.h6.addCharacterSpacing()

    return cell
}

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if prices2.count > 0 {
        
        return prices2.count
        
    } else {
        
        return 0
    }
    
}

var myusedint = Int()
var selectedindex = Int()
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Prices", for: indexPath) as! PricesCollectionViewCell
    
    cell.titlelabel.text = pricetitles[indexPath.row]
    cell.titlelabel.addCharacterSpacing()
    
   
    
    if prices2[indexPath.row] == "OUT OF STOCK" {
        
        
      
        cell.priceslabel.textColor = UIColor.lightGray
        
//        var int4 = Double(myusedint) * 1.83
//
//        prices2[0] = "$\(String(Int(int4)))"
//        cell.priceslabel.text = prices2[indexPath.row]

//        cell.priceslabel.textColor = .gray
//        cell.isUserInteractionEnabled = false
        
    } else {
        
        cell.isUserInteractionEnabled = true
        cell.priceslabel.text = prices2[indexPath.row]
        cell.priceslabel.textColor = myblue
    }


    return cell

    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let kWhateverHeightYouWant = 83
        return CGSize(width: collectionView.bounds.size.width/2, height: CGFloat(kWhateverHeightYouWant))
    }

}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
