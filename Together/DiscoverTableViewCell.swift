

//
//  DiscoverTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 10/26/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {

    @IBOutlet weak var tapfun: UIButton!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var backers: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var summarylabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var productimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tapfun.layer.cornerRadius = 10.0
        tapfun.layer.masksToBounds = true 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
