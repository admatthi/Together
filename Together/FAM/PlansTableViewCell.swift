//
//  PlansTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 11/7/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class PlansTableViewCell: UITableViewCell {

    @IBOutlet weak var playerView: PlayerViewClass!

    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var daylabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
