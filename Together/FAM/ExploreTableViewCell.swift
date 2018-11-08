//
//  ExploreTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 11/7/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {

    @IBOutlet weak var subscriber: UIButton!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var programname: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var toppic: UIImageView!
    @IBOutlet weak var subscribercount: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        subscriber.layer.cornerRadius = 5.0
        subscriber.layer.masksToBounds = true
        
                profilepic.layer.masksToBounds = true
                profilepic.layer.cornerRadius = 10.0

        
//        profilepic.layer.masksToBounds = false
//        profilepic.layer.cornerRadius = profilepic.frame.height/2
        profilepic.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
