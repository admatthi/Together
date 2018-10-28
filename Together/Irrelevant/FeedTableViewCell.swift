//
//  FeedTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 10/16/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var tapintro: UIButton!
    @IBOutlet weak var livesin: UILabel!
    @IBOutlet weak var lookingfor: UILabel!
    @IBOutlet weak var works: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var distance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
