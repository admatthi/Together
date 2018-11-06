//
//  ProjectCollectionViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 10/26/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var product: UILabel!
    
    @IBOutlet weak var playerView: PlayerViewClass!
    @IBOutlet weak var screenshot: UIImageView!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var price: UILabel!
}
