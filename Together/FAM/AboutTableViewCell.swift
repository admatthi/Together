//
//  AboutTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 11/8/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {
    @IBOutlet weak var dollers: UILabel!
    @IBOutlet weak var tapjoin: UIButton!
    
    @IBOutlet weak var monthlylabel: UILabel!
    @IBOutlet weak var sublabel: UILabel!
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var pitch: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subs: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var tapjoin2: UIButton!
    @IBOutlet weak var longdescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tapjoin.layer.cornerRadius = 5.0
        tapjoin.layer.masksToBounds = true
        tapjoin2.layer.cornerRadius = 5.0
        tapjoin2.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
