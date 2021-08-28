//
//  Mdoel-Chat.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 25/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation

class Model_chat {
    
    static let shared = Model_chat()
    
    var str_user_id = ""
    var str_fri_id = ""
    
    var str_date = ""
    var str_time = ""
    var str_msg = ""
    var str_current_user_id = ""
    var str_current_user_image = ""
    
    var arr_chat_list = [Model_chat]()

    var str_send_msg = ""
    
    func func_API_send_msg(completionHandler:@escaping (String)->()) {
        let strURL = "http://appentus.me/trainer/api/chat/insert_chat"
        
        let today = Date()
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "dd/MM/yyy hh:mm a"
        let str_current_date = date_formatter.string(from: today)
        let arr_current_date = str_current_date.components(separatedBy: " ")
        
        var str_rx_sx = ""
        
        if Model_SignUp.shared.userType == "2" {
            str_rx_sx = "2"
        } else {
            str_rx_sx = "1"
        }
        
        let dict_params = [
            "user_id":str_user_id,
            "fri_id":str_fri_id,
            "date":arr_current_date[0],
            "time":"\(arr_current_date[1])" + " \(arr_current_date[2])",
            "msg":str_send_msg,
            "type":1,
            "receiver":str_rx_sx
            ] as [String : Any]
        
        print(dict_params)
        
        APIFunc.postAPI(url: strURL, parameters:dict_params) { (dictJSON) in
            print(dictJSON)

            if dictJSON["status"] as! String == "success" {
               
            }
            completionHandler(dictJSON["status"] as! String)
        }
    }

    func func_set_chat_list(dict:[String:Any]) -> Model_chat {
        let model = Model_chat()
        
        model.str_current_user_id = dict["user_id"] as! String
        model.str_date = dict["date"] as! String
        model.str_time = dict["time"] as! String
        model.str_msg = dict["msg"] as! String

        return model
    }
    
    func func_API_get_user_chat(completionHandler:@escaping (String)->()) {
        let strURL = "http://appentus.me/trainer/api/chat/get_user_chat"
        print(strURL)
        
        let dict_params = [
            "user_id":str_user_id,
            "fri_id":str_fri_id
        ]
        
        print(dict_params)
        
        APIFunc.postAPI(url: strURL, parameters:dict_params) { (dictJSON) in
            print(dictJSON)
            self.arr_chat_list.removeAll()
            if dictJSON["status"] as! String == "success" {
                for dict_chat_list in dictJSON["result"] as! [[String:Any]] {
                    self.arr_chat_list.append(self.func_set_chat_list(dict: dict_chat_list))
                }
            }
            completionHandler(dictJSON["status"] as! String)
        }
    }
    
    
}




