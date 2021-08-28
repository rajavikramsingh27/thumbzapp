//
//  Schedule_Workouts_TableViewCell.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 16/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit

class Schedule_Workouts_TableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name_workout:UILabel!
    @IBOutlet weak var lbl_description_workout:UILabel!
    
    @IBOutlet weak var view_name_workout:UIView!

    @IBOutlet weak var img_tick_mark:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        view_name_workout.layer.cornerRadius = 2
        view_name_workout.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
