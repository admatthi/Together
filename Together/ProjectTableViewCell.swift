//
//  ProjectTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 11/2/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var tapbuy: UIButton!
    @IBOutlet weak var tapshare: UIButton!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var goalpledged: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var backers: UILabel!
    @IBOutlet weak var amountpledged: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
