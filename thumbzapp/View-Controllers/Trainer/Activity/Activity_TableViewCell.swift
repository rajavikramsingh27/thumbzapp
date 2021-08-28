//
//  Activity_TableViewCell.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 18/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//








import UIKit

class Activity_TableViewCell: UITableViewCell {
        @IBOutlet weak var lbl_Up:UILabel!
        @IBOutlet weak var lbl_exercise:UILabel!
        @IBOutlet weak var view_ContentView:UIView!
    
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbl_Up.layer.cornerRadius = lbl_Up.frame.size.height/2
        lbl_Up.clipsToBounds = true
        
        view_ContentView.layer.cornerRadius = 2
        view_ContentView.layer.shadowOpacity = 5.0
        view_ContentView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view_ContentView.layer.shadowRadius = 5.0
        view_ContentView.layer.shadowColor = UIColor .lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
