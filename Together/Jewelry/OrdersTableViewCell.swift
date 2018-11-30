//
//  OrdersTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 11/30/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var mainimage: UIImageView!
    @IBOutlet weak var delivery: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
