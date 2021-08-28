//
//  Home_TableViewCell.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 20/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit

class Home_TableViewCell: UITableViewCell {

    @IBOutlet weak var btn_Profile:UIButton!
    @IBOutlet weak var coll_Home:UICollectionView!
    @IBOutlet weak var img_user: UIImageView!

    @IBOutlet weak var lbl_videos_shared: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        img_user.layer.cornerRadius = img_user.frame.size.height/2
        img_user.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
