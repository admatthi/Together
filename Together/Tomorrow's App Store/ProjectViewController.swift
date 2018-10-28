//
//  ProjectViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 10/26/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit


var selectedprice = String()
var selectedtitle = String()
var selecteddescription = String()
var selectedprogress = String()

class ProjectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titlelabel: UILabel!
    var prices = [String]()
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var backers: UILabel!
    @IBOutlet weak var amountpledged: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var authorlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        titlelabel.text = selectedtitle
        descriptionlabel.text = selecteddescription
        tapBuy.setTitle("$\(selectedprice)", for: .normal) 
        authorlabel.text = "by Alek Matthiessen"
        amountpledged.text = "$2,987"
        let progress = (Float(selectedprogress)!/100)
        self.progressView.setProgress(Float(progress), animated:true)
        screenshots.append(UIImage(named: "A")!)
        screenshots.append(UIImage(named: "B")!)
        screenshots.append(UIImage(named: "C")!)
        
        
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        return 3
    }
    
    @IBOutlet weak var pricelabel: UILabel!
    
    @IBOutlet weak var tapshare: UIButton!
    @IBAction func tapShare(_ sender: Any) {
    }
    @IBOutlet weak var tapBuy: UIButton!
    @IBAction func tapbuy(_ sender: Any) {
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Project", for: indexPath) as! ProjectCollectionViewCell
   
        cell.screenshot.image = screenshots[indexPath.row]
//        cell.price.text = "$\(prices[indexPath.row])"
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    var screenshots = [UIImage]()
}
