//
//  HelpViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 12/11/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

var squestion = String()

class HelpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        header.addCharacterSpacing()

        questions.removeAll()
        questions.append("WHAT IS BLING?")
        questions.append("HOW DOES IT WORK?")
        questions.append("HOW DO I DELETE MY ACCOUNT?")
        questions.append("HOW DO I CONTACT YOU?")
        questions.append("HOW DO I PLACE AN ORDER?")
        questions.append("WHAT PAYMENT OPTIONS DO YOU ACCEPT?")
        questions.append("WILL I RECEIVE MY ORDER BEFORE DECEMBER 24, 2018?")
        questions.append("CAN I CANCEL MY ORDER?")
        questions.append("HOW DO I KNOW IF THE JEWLERY IS AUTHENTIC?")
        questions.append("HOW DOES THE AUTHENTICITY GUARANTEE WORK?")
        questions.append("HOW MUCH DOES THE AUTHENTICITY GUARANTEE COST?")
        questions.append("DO YOU ACCEPT RETURNS?")
        questions.append("HOW MUCH DOES SHIPPING COST?")
        questions.append("WHEN WILL I RECEIVE MY ORDER?")
        questions.append("I PLACED AN ORDER, BUT DIDN’T RECEIVE A CONFIRMATION EMAIL.")


        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    @IBAction func tapCancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        squestion = questions[indexPath.row]
        self.performSegue(withIdentifier: "Help2", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return questions.count
    }
    
    var questions = [String]()
 
    @IBOutlet weak var header: UILabel!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Help", for: indexPath) as! HelpTableViewCell
        cell.question.text = questions[indexPath.row].lowercased()
        cell.question.text = cell.question.text?.capitalized
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
