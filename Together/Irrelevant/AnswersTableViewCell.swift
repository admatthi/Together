//
//  AnswersTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 10/8/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class AnswersTableViewCell: UITableViewCell {

    @IBOutlet weak var v2: UIImageView!
    @IBOutlet weak var tapdown: UIButton!
    @IBOutlet weak var tapup: UIButton!
    @IBOutlet weak var upvotetext: UILabel!
    @IBOutlet weak var answertext: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userprofile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
