//
//  FilterViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 12/14/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

var selectedfilter = String()
var selectedindex = Int()

var brandimages = [UIImage]()
var brandtitles = [String]()
class FilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        tapmen.alpha = 0.5
        
        tapwomen.alpha = 0.5
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        
        selectedindex = indexPath.row
        
        selectedfilter = brandtitles[indexPath.row]
        
        selectedkey = "Brand"
        collectionView.reloadData()
        
        return 
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return brandimages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Filter", for: indexPath) as! FilterBrandCollectionViewCell
        
        cell.brandtitle.text = brandtitles[indexPath.row].uppercased()
        cell.brandtitle.addCharacterSpacing()
        
        cell.brandimage.image = brandimages[indexPath.row]
   
        
        if selectedindex == 0 {
            
            if indexPath.row == 0 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1

            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            

        }
        
        if selectedindex == 1 {
            
            if indexPath.row == 1 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1
                
            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            
            
        }
    
        if selectedindex == 2 {
            
            if indexPath.row == 2 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1
                
            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            
            
        }
        
        if selectedindex == 3 {
            
            if indexPath.row == 3 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1
                
            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            
            
        }
        
        if selectedindex == 4 {
            
            if indexPath.row == 4 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1
                
            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            
            
        }
        
        if selectedindex == 5 {
            
            if indexPath.row == 5 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1
                
            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            
            
        }
        
        if selectedindex == 6 {
            
            if indexPath.row == 6 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1
                
            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            
            
        }
        
        if selectedindex == 7 {
            
            if indexPath.row == 7 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1
                
            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            
            
        }
        
        if selectedindex == 8 {
            
            if indexPath.row == 8 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1
                
            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            
            
        }
        
        if selectedindex == 9 {
            
            if indexPath.row == 9 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1
                
            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            
            
        }
        
        if selectedindex == 10 {
            
            if indexPath.row == 10 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1
                
            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            
            
        }
        
        if selectedindex == 11 {
            
            if indexPath.row == 11 {
                
                cell.brandimage.alpha = 1
//                cell.brandtitle.alpha = 1
                
            } else {
                
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            }
            
            
        }
        
        if selectedindex == 1000 {
            
       
                cell.brandimage.alpha = 0.25
//                cell.brandtitle.alpha = 0.25
            
        }
        
        return cell

    }
    
    @IBOutlet weak var tapb3: UIButton!
    
    @IBOutlet weak var HEADER: UILabel!
    @IBAction func tapApply(_ sender: Any) {
        
       
    }
    @IBAction func tapB3(_ sender: Any) {
     
       selectedindex = 1000
        collectionView.reloadData()
        tapb1.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Brand"
        selectedfilter = "Tudor"
    
    }
    @IBAction func tapB2(_ sender: Any) {
      
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Brand"
        selectedfilter = "Omega"
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
  
    }
    @IBAction func tapB1(_ sender: Any) {
        
      
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
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Category"
        selectedfilter = "Necklaces"
        tapb4.alpha = 0.5
        tapb5.alpha = 0.5
        tapb6.alpha = 0.5

    }
    @IBAction func tapBrac(_ sender: Any) {
        
        tapbracelets.alpha = 1
        tapb2.alpha = 0.5
        tapb1.alpha = 0.5
        tapb3.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5

        selectedfilter = "Bracelets"
        selectedkey = "Category"
        tapb4.alpha = 0.5
        tapb5.alpha = 0.5
        tapb6.alpha = 0.5
        selectedindex = 1000
        collectionView.reloadData()
    }
    @IBAction func tapWomen(_ sender: Any) {
        
        selectedindex = 1000
        collectionView.reloadData()
        tapwomen.alpha = 1
      
        tapmen.alpha = 0.5
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        selectedfilter = "Women"
        selectedkey = "Gender"
   
    }
    @IBAction func tapMen(_ sender: Any) {
        
        tapmen.alpha = 1
     
        tapwomen.alpha = 0.5
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        selectedfilter = "Men"
        selectedkey = "Gender"
        selectedindex = 1000
        collectionView.reloadData()
    }
    
    
    @IBOutlet weak var tapb6: UIButton!
    @IBOutlet weak var tapb5: UIButton!
    @IBOutlet weak var tapb4: UIButton!
    @IBAction func tapB4(_ sender: Any) {
        
        tapb3.alpha = 0.5
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        tapb2.alpha = 0.5
        
        tapb1.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Brand"
        selectedfilter = "TAG Heuer"
        tapb4.alpha = 1
        tapb5.alpha = 0.5
        tapb6.alpha = 0.5
    }
    @IBAction func tapB5(_ sender: Any) {
        
        tapb3.alpha = 0.5
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        tapb2.alpha = 0.5
        
        tapb1.alpha = 0.5
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Brand"
        selectedfilter = "Breitling"
        tapb4.alpha = 0.5
        tapb5.alpha = 1
        tapb6.alpha = 0.5
    }
    @IBAction func tapB6(_ sender: Any) {
        
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        
        tapwomen.alpha = 0.5
        tapmen.alpha = 0.5
        selectedkey = "Brand"
        selectedfilter = "Panerai"
  
    }
    @IBOutlet weak var tapp1: UIButton!
    @IBOutlet weak var tapp2: UIButton!

    @IBOutlet weak var tapp3: UIButton!

    @IBAction func tapP1(_ sender: Any) {
       
        selectedindex = 1000
        collectionView.reloadData()
        
        selectedkey = "Used Price"
        selectedfilter = "275"
        minprice = 0
        tapp1.alpha = 1
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        tapmen.alpha = 0.5
  
        tapwomen.alpha = 0.5
  
    }
    @IBAction func tapP2(_ sender: Any) {
        selectedindex = 1000

        selectedkey = "Used Price"
        selectedfilter = "2900"
        minprice = 275
        tapp2.alpha = 1
        tapp1.alpha = 0.5
        tapp3.alpha = 0.5
        tapmen.alpha =  0.5
      
        tapwomen.alpha = 0.5
        selectedindex = 1000
        collectionView.reloadData()
    }
    @IBAction func tapP3(_ sender: Any) {
        selectedindex = 1000

        selectedkey = "Used Price"
        selectedfilter = "100000"
        minprice = 2900
        tapp3.alpha = 1
        tapp2.alpha = 0.5
        tapp1.alpha = 0.5
        tapmen.alpha =  0.5
   
        tapwomen.alpha = 0.5
        selectedindex = 1000
        collectionView.reloadData()
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
        
        tapmen.alpha = 0.5
        tapwomen.alpha = 0.5
        tapb1.alpha = 0.5
        tapb2.alpha = 0.5
        tapb3.alpha = 0.5
        tapb4.alpha = 0.5
        tapb5.alpha = 0.5
        tapb6.alpha = 0.5
        tapp1.alpha = 0.5
        tapp2.alpha = 0.5
        tapp3.alpha = 0.5
        selectedkey = ""
        selectedfilter = ""
    }
    @IBAction func tapcancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tapCancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        brandimages.removeAll()
        brandtitles.removeAll()
        
        brandimages.append(UIImage(named: "Omega")!)
        brandimages.append(UIImage(named: "Rolex")!)
        brandimages.append(UIImage(named: "Tudor")!)
        brandimages.append(UIImage(named: "Panerai")!)
        brandtitles.append("Omega")
        brandtitles.append("Rolex")
        brandtitles.append("Tudor")
        brandtitles.append("Panerai")

        brandimages.append(UIImage(named: "Tag")!)
        brandtitles.append("TAG Heur")

        brandimages.append(UIImage(named: "Seiko")!)
        brandtitles.append("Seiko")
        
        brandimages.append(UIImage(named: "Michael Kors")!)
        brandtitles.append("Michael Kors")
        
        brandimages.append(UIImage(named: "Bulgari")!)
        brandtitles.append("Bulgari")
        
        brandimages.append(UIImage(named: "Raymond Weil")!)
        brandtitles.append("Raymond Weil")
        
        brandimages.append(UIImage(named: "Gucci")!)
        brandtitles.append("Gucci")
        
        if selectedindex == 0 {
            
            selectedindex = 1000
            collectionView.reloadData()

        } else {
            
            collectionView.reloadData()

        }
        
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

//        if selectedfilter == "Earrings" {
//
//            tapearrings.alpha = 1
//
//        }
//
//        if selectedfilter == "Necklaces" {
//
//            tapnecklaces.alpha = 1
//
//        }
//
//        if selectedfilter == "Bracelets" {
//
//            tapbracelets.alpha = 1
//
//        }
//
        if selectedfilter == "275" {
            
            tapp1.alpha = 1
            selectedindex = 1000
            collectionView.reloadData()
            
        }
        
        if selectedfilter == "2900" {
            
            tapp2.alpha = 1
            selectedindex = 1000
            collectionView.reloadData()
            
        }
        
        if selectedfilter == "100000" {
            
            tapp3.alpha = 1
            selectedindex = 1000
            collectionView.reloadData()
            
        }
        if selectedfilter == "Men" {

            tapmen.alpha = 1
            selectedindex = 1000
            collectionView.reloadData()
        }
        if selectedfilter == "Women" {

            tapwomen.alpha = 1
            selectedindex = 1000
            collectionView.reloadData()
        }
//
//        if selectedfilter == "MVMT" {
//
//            tapb3.alpha = 1
//
//        }
//
//        if selectedfilter == "Rolex" {
//
//            tapb1.alpha = 1
//
//        }
//
//        if selectedfilter == "Omega" {
//
//            tapb2.alpha = 1
//
//        }
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
