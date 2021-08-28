//
//  Extension-Myclient.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 25/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit



extension myClientsVC {
    @IBAction func btn_search (_ sender:UIButton) {
        if sender.tag == 1 {
            sender.tag = 2
            view_search.isHidden = false
            txt_search.becomeFirstResponder()
            btn_Search.setImage(UIImage (named: "cancel"), for: .normal)
        } else {
            sender.tag = 1
            view_search.isHidden = true
            self.view.endEditing(true)
            btn_Search.setImage(UIImage (named: "search"), for: .normal)
            func_search_result(arr_search: arrayList)
        }
    }
    
    
    
    @IBAction func txt_Search(_ sender: UITextField) {
        return_Response = [[String:Any]]()
        
        for i in 0..<arrayList.count
        {
            let dict = arrayList[i]
            let target = dict["client_name"] as? String
            if ((target as NSString?)?.range(of:txt_search.text!, options: .caseInsensitive))?.location == NSNotFound
            {
                boolIsFilterd=true
            } else {
                return_Response.append(dict)
            }
        }
        
        if (txt_search.text! == "")
        {
            return_Response = arrayList
            boolIsFilterd=false
        }
        
        func_search_result(arr_search: return_Response)
    }
    
    func func_search_result(arr_search : [[String:Any]]) {
        model_trainer_clients.shared.client_device_token.removeAll()
        model_trainer_clients.shared.client_device_type.removeAll()
        model_trainer_clients.shared.client_email.removeAll()
        model_trainer_clients.shared.client_id.removeAll()
        model_trainer_clients.shared.client_name.removeAll()
        model_trainer_clients.shared.client_password.removeAll()
        model_trainer_clients.shared.client_profile.removeAll()
        model_trainer_clients.shared.client_social.removeAll()
        model_trainer_clients.shared.client_status.removeAll()
        model_trainer_clients.shared.trainer_id.removeAll()
        
        for i in 0..<arr_search.count {
            let dict : NSDictionary = arr_search[i] as NSDictionary
            model_trainer_clients.shared.client_device_token.append("\(dict["device_token"]!)")
            model_trainer_clients.shared.client_device_type.append("\(dict["device_type"]!)")
            model_trainer_clients.shared.client_email.append("\(dict["client_email"]!)")
            model_trainer_clients.shared.client_id.append("\(dict["client_id"]!)")
            model_trainer_clients.shared.client_name.append("\(dict["client_name"]!)")
            model_trainer_clients.shared.client_password.append("\(dict["client_password"]!)")
            model_trainer_clients.shared.client_profile.append("\(dict["client_profile"]!)")
            model_trainer_clients.shared.client_social.append("\(dict["client_social"]!)")
            model_trainer_clients.shared.client_status.append("\(dict["client_status"]!)")
            model_trainer_clients.shared.trainer_id.append("\(dict["trainer_id"]!)")
        }
        
        collectionView.reloadData()
    }
    
}



