//
//  ProductTableViewCell.swift
//  
//
//  Created by Alek Matthiessen on 11/29/18.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var b3: UILabel!
    @IBOutlet weak var b2: UILabel!
    
    @IBOutlet weak var b5: UILabel!
    @IBOutlet weak var b4: UILabel!
    @IBOutlet weak var b1: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var mainimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
