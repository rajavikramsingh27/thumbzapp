//
//  Workout_TableViewCell.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 10/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit

class Workout_TableViewCell: UITableViewCell {
    @IBOutlet weak var view_Cordio_1:UIView!
    @IBOutlet weak var lbl_exercise_name:UILabel!
    @IBOutlet weak var img_TickMark:UIImageView!
    @IBOutlet weak var btn_Mark_as_Completed:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view_Cordio_1.layer.cornerRadius = 4
        view_Cordio_1.layer.shadowOpacity = 30.0
        // shadow opacity ---> uper uthane k liye
        view_Cordio_1.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view_Cordio_1.layer.shadowRadius = 30.0
        view_Cordio_1.layer.shadowColor = UIColor .lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
