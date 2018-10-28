//
//  QuestionsTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 10/14/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

var name = [String]()
var questions = [String]()
var answer = [String]()

class QuestionsTableViewCell: UITableViewCell {

    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
