//
//  File_Shared_Trainer_TableViewCell.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 10/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit

class File_Shared_Trainer_TableViewCell: UITableViewCell {
    @IBOutlet weak var view_FileContainer:UIView!
    @IBOutlet weak var lbl_FileStorage:UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()

        func_Set_Shadow()
        
//        let strURL = k_BASEURL+k_upload_file
//        print(strURL)
//
//        let parameters = [
//            "trainer_id":ThumbzappUserDefaults.sharedInstance.userId ,
//            "client_id":Model_Schedule_Workout.shared.str_client_id
//        ]
//
//        print(parameters)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func func_Set_Shadow() {
        view_FileContainer.layer.borderWidth = 1
        view_FileContainer.layer.borderColor = UIColor (red: 136.0/255.0, green: 221.0/255.0, blue: 227.0/255.0, alpha: 1.0).cgColor
        view_FileContainer.layer.cornerRadius = 4
        view_FileContainer.layer.shadowOpacity = 1.0
        view_FileContainer.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view_FileContainer.layer.shadowRadius = 1.0
        view_FileContainer.layer.shadowColor = UIColor .lightGray.cgColor
    
    }
}
