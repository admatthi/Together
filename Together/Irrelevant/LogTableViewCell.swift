//
//  LogTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 10/3/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell {

    @IBOutlet weak var tapdown: UIButton!
    @IBOutlet weak var tapup: UIButton!
    @IBOutlet weak var verified: UIImageView!
    @IBOutlet weak var responses: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var habit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
