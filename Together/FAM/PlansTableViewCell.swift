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
    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var monthlylabel: UILabel!
    @IBOutlet weak var sublabel: UILabel!
    @IBOutlet weak var pitch: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subs: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var tapjoin2: UIButton!
    @IBOutlet weak var programn: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var minipic: UIImageView!
    @IBOutlet weak var playerView: PlayerViewClass!

    @IBOutlet weak var tapcircle: UIButton!
    @IBOutlet weak var lockimage: UIImageView!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var thumbnailpreview: UIImageView!
    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var daylabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tapjoin.layer.cornerRadius = 15.0
        tapjoin.layer.masksToBounds = true
        
                profilepic.layer.masksToBounds = false
                profilepic.layer.cornerRadius = profilepic.frame.height/2
                profilepic.clipsToBounds = true
        
        minipic.layer.masksToBounds = false
        minipic.layer.cornerRadius = minipic.frame.height/2
        minipic.clipsToBounds = true
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
