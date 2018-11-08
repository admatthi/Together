//
//  PlansTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 11/7/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class PlansTableViewCell: UITableViewCell {
    @IBOutlet weak var dollers: UILabel!
    @IBOutlet weak var tapjoin: UIButton!
    
    @IBOutlet weak var monthlylabel: UILabel!
    @IBOutlet weak var sublabel: UILabel!
    @IBOutlet weak var pitch: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subs: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var tapjoin2: UIButton!
    
    @IBOutlet weak var playerView: PlayerViewClass!

    @IBOutlet weak var thumbnailpreview: UIImageView!
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
