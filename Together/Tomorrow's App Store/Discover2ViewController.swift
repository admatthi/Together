//
//  Discover2ViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 10/28/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

var images = [UIImage]()
var titles = [String]()
var prices = [String]()
var descriptions = [String]()
var progress = [String]()

class Discover2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        images.append(UIImage(named: "1")!)
        images.append(UIImage(named: "2")!)
        images.append(UIImage(named: "3")!)
        images.append(UIImage(named: "4")!)
        images.append(UIImage(named: "5")!)
        
        titles.append("Slide")
        titles.append("Black Ocean")
        titles.append("Paleo Beginers")
        titles.append("Slide")
        titles.append("Slide")
        
        descriptions.append("Make your texts better and more charming")
        descriptions.append("Own and manage a share of an ethereum mine")
        descriptions.append("Find paleo recipes for any time")
        
        progress.append("25")
        progress.append("50")
        progress.append("75")
        
        prices.append("5.99")
        prices.append("15.99")
        prices.append("25.99")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedtitle = titles[indexPath.row]
        selecteddescription = descriptions[indexPath.row]
        selectedprice = prices[indexPath.row]
        selectedprogress = progress[indexPath.row]
        
        self.performSegue(withIdentifier: "DiscoverToProject", sender: self)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
       return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Discover", for: indexPath) as! DiscoverTableViewCell
        
        cell.titlelabel.text = titles[indexPath.row]
        cell.summarylabel.text = descriptions[indexPath.row]
        cell.percent.text = "\(progress[indexPath.row])% funded"
        cell.tapfun.setTitle("$\(prices[indexPath.row])", for: .normal)
        cell.titlelabel.text = titles[indexPath.row]
        cell.productimage.image = images[indexPath.row]
        
        
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

}
