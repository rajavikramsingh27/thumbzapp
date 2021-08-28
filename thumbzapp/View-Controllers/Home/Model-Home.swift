//
//  Model-Home.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 23/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation

class Model_Home {
    
    static let shared = Model_Home()
    
    var str_date = ""
    var str_exercise = ""
    var str_assign_status = ""
    var str_assign_id = ""
    var str_trainer_id = ""
    
    var arr_exercise = [Model_Home]()
    
    func func_API_get_latest_workout_client(completionHandler:@escaping (String)->()) {
        let strURL = k_BASEURL+"get_latest_workout_client"
        print(strURL)
        
        if Model_Schedule_Workout.shared.str_client_id.isEmpty {
            Model_Schedule_Workout.shared.str_client_id = ThumbzappUserDefaults.sharedInstance.userId
        }
        
        let dict_params = [
            "client_id": Model_Schedule_Workout.shared.str_client_id,
        ]
        
        print(dict_params)
        
        APIFunc.postAPI(url: strURL, parameters:dict_params) { (dictJSON) in
            print(dictJSON)
            
            self.arr_exercise.removeAll()
            
            if dictJSON["status"] as! String == "success" {
                let arr_exercise = dictJSON["result"] as! [[String:Any]]
                for dict_result in arr_exercise {
                    self.arr_exercise.append(self.func_set_exercise(dict: dict_result))
                }
            }
            completionHandler(dictJSON["status"] as! String)
        }
    }
    
    func func_set_exercise(dict:[String:Any]) -> Model_Home {
        let model = Model_Home()
        
        model.str_exercise = dict["wrokout_name"] as! String
        model.str_assign_status = dict["assign_status"] as! String
        
        model.str_trainer_id = dict["trainer_id"] as! String
        model.str_assign_id = dict["assign_id"] as! String
        model.str_date = dict["assign_date"] as! String
        
        return model
    }

}


