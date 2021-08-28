//
//  WorkoutList_TableViewCell.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 20/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit

class WorkoutList_TableViewCell: UITableViewCell {

    @IBOutlet weak var img_Profile:UIImageView!
    @IBOutlet weak var lbl_date:UILabel!
    @IBOutlet weak var lbl_exercise_name:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        img_Profile.layer.cornerRadius = 4
        img_Profile.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
