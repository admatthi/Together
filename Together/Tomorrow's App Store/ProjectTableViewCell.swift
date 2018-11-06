//
//  ProjectTableViewCell.swift
//  Together
//
//  Created by Alek Matthiessen on 11/5/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var includes: UILabel!
    @IBOutlet weak var projectname: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tapshare: UIButton!
    @IBOutlet weak var tapback: UIButton!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var backers: UILabel!
    @IBOutlet weak var amountpledged: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var longdescription: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var projectdescription: UILabel!
    @IBOutlet weak var projectimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ProjectTableViewCell  {
    
    func setCollectionViewDataSourceDelegate <D: UICollectionViewDataSource & UICollectionViewDelegate> (_ dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        
        collectionView.reloadData()
    }
}
