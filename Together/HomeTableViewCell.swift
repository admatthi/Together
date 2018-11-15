//
//  HomeTableViewCell.swift
//  
//
//  Created by Alek Matthiessen on 10/13/18.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var people: UILabel!
    @IBOutlet weak var topic: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
