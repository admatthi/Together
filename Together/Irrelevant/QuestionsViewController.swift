//
//  QuestionsViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 10/14/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        name.append("Olivia")
        name.append("Katie")
        name.append("Sara")
        name.append("Susan")

        
        questions.append("YOU SHOULDN'T GO OUT WITH ME IF")
        questions.append("BEST TRAVEL STORY")
        questions.append("A LIFE GOAL OF MINE")
        questions.append("MY MOST IRRATIONAL FEAR")
        questions.append("")
        questions.append("")
        questions.append("")
        questions.append("")
        questions.append("")
        questions.append("")
        
        answer.append("You hate hearing people say omg I love this song let's go dance.")
        answer.append("This one time my car broke down in this amazing place called the jersey turnpike.")
        answer.append("I want to do a cartwheel. But real casual like. Not make a big deal about it. Just one stunning gorgeous cartwheel.")
        answer.append("A serial killer in my back seat")
        answer.append("")
        answer.append("")
        answer.append("")
        answer.append("")
        answer.append("")
        answer.append("")
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if name.count > 0 {
            
            return name.count
            
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Questions", for: indexPath) as! QuestionsTableViewCell
        
        
            cell.name.text = name[indexPath.row]
            cell.question.text = questions[indexPath.row]
            cell.answer.text = answer[indexPath.row]

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
