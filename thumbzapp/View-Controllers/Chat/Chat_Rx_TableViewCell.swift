//
//  Chat_Rx_TableViewCell.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit

class Chat_Rx_TableViewCell: UITableViewCell {

    @IBOutlet weak var img_UserImage:UIImageView!
    @IBOutlet weak var lbl_MSG:UILabel!
    @IBOutlet weak var view_MSG:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        img_UserImage.layer.cornerRadius = img_UserImage.frame.size.height/2
        img_UserImage.clipsToBounds = true
        
        view_MSG.layer.cornerRadius = 20
        view_MSG.layer.shadowOpacity = 5.0
        // shadow opacity ---> uper uthane k liye
        view_MSG.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view_MSG.layer.shadowRadius = 3.0
        view_MSG.layer.shadowColor = UIColor .lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
