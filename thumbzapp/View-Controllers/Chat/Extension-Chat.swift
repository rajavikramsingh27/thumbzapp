//
//  Extension-Chat.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


extension Chat_ViewController {
    func func_Set_Design() {
        view_TextContainer.layer.cornerRadius = 20
        view_TextContainer.clipsToBounds = true
        view_TextContainer.layer.borderColor = UIColor .lightGray .cgColor
        view_TextContainer.layer.borderWidth = 0.5
        
        btn_Send.layer.cornerRadius = btn_Send.frame.size.height/2
        btn_Send.clipsToBounds = true
    }
}




extension Chat_ViewController :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_chat.shared.arr_chat_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = Model_chat.shared.arr_chat_list[indexPath.row]
        let str_compare_user = model.str_current_user_id
        
        if str_compare_user == Model_chat.shared.str_user_id {
            let cell_Sx = tableView.dequeueReusableCell(withIdentifier: "cell_Sx", for:indexPath) as! Chat_Sx_TableViewCell
            
            cell_Sx.lbl_MSG.text = model.str_msg
            
            cell_Sx.img_UserImage.downloadedFrom(link:Model_chat.shared.str_current_user_image)
            
            return cell_Sx
        } else {
            let cell_Rx = tableView.dequeueReusableCell(withIdentifier: "cell_Rx", for:indexPath) as! Chat_Rx_TableViewCell
            
            cell_Rx.lbl_MSG.text = model.str_msg

            let str_user_image = UserDefaults.standard.object(forKey:"trainer_profile") as! String
            cell_Rx.img_UserImage.sd_setImage(with: URL(string:str_user_image), placeholderImage: UIImage(named: "brad-Pitt"))
            
            return cell_Rx
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}


