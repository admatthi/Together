//
//  HomeViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 10/13/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

var topics = [String]()
var n = [String]()
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadictonarhy()
        tableView.layer.cornerRadius = 10.0
        tableView.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadictonarhy() {
        
        topics.append("Kavanaugh")
        topics.append("Kanye's visit to the White House")
        topics.append("Staying In Tonight")
        topics.append("Feeling Lonely")
        topics.append("CNN")
        topics.append("Fox News")
        topics.append("Don Lemon")
        topics.append("My GPA")
        topics.append("Getting Married")
        topics.append("Skipping Class")
        topics.append("Wondering what to do with my life")
        topics.append("Not showering today")
        topics.append("Feeling awkward taking Instagram photos")
        topics.append("Going to the club")
        topics.append("Missing someone right now")
        topics.append("Just got cheated on")
        topics.append("Don't feel like they have any friends.")
        topics.append("Don't look great naked")
        topics.append("Look great naked")
        topics.append("Have never left the country")
        topics.append("Are single")
        topics.append("Binge ate carbs today")
        topics.append("Ate healthy the whole day")
        topics.append("Got ghosted today")

        n.append("1,242")
        n.append("5,231")
        n.append("5,621")
        n.append("1,242")
        n.append("1,242")
        n.append("5,231")
        n.append("5,621")
        n.append("1,242")
        n.append("1,242")
        n.append("5,231")
        n.append("5,621")
        n.append("1,242")
        n.append("1,242")
        n.append("5,231")
        n.append("5,621")
        n.append("1,242")
        n.append("1,242")
        n.append("1,242")
        n.append("5,231")
        n.append("5,621")
        n.append("1,242")
        n.append("1,242")
        n.append("5,231")
        n.append("5,621")
        n.append("1,242")
        n.append("1,242")
        n.append("1,242")
        n.append("5,231")
        n.append("5,621")
        n.append("1,242")
        n.append("1,242")
        n.append("1,242")
        n.append("5,231")
        n.append("5,621")
        n.append("1,242")
        n.append("1,242")
        n.append("5,231")
        n.append("5,621")
        n.append("1,242")
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if topics.count > 0 {
            
            return topics.count
            
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Home", for: indexPath) as! HomeTableViewCell
        
        
        cell.topic.text = topics[indexPath.row]
        cell.people.text = n[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
