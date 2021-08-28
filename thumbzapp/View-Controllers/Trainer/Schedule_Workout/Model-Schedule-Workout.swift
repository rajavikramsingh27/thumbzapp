//
//  Model-Schedule-Workout.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 16/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation



class Model_Schedule_Workout {
    
    static let shared = Model_Schedule_Workout()
    
    var str_client_id = ""
    var str_MSG = ""

    var str_workout_date = ""
    var str_workout_name = ""
    var str_workout_id = ""
    var str_workout_description = ""

    
    var arr_Schedule_Workout = [Model_Schedule_Workout]()
    
    
    func func_API_get_workout(completionHandler:@escaping (String)->()) {
        let strURL = k_BASEURL+k_get_workout
        print(strURL)
        
        APIFunc.getAPI(url: strURL, parameters:[:]) { (dictJSON) in
            print(dictJSON)
            
            if dictJSON["status"] as! String == "success" {
                self.arr_Schedule_Workout.removeAll()
                let arr_Result = dictJSON["result"] as! [[String:Any]]
                for dict_result in arr_Result {
                    self.arr_Schedule_Workout.append(self.func_set_workout(dict: dict_result))
                }
            }
            
            completionHandler(dictJSON["status"] as! String)
        }
    }
    
   private func func_set_workout(dict:[String:Any]) -> Model_Schedule_Workout {
        let model = Model_Schedule_Workout()
    
        model.str_workout_id = dict["workout_id"] as! String
        model.str_workout_name = dict["wrokout_name"] as! String
        model.str_workout_description = dict["workout_description"] as! String
    
        return model
    }
    
    func func_API_assign_workout(completionHandler:@escaping (String)->()) {
        let strURL = k_BASEURL+k_assign_workout
        print(strURL)
        
        let dict_params = [
            "trainer_id":ThumbzappUserDefaults.sharedInstance.userId ,
            "client_id":str_client_id,
            "workout_id":str_workout_id,
            "assign_date":str_workout_date
        ]
        
        print(dict_params)
        
        APIFunc.postAPI(url: strURL, parameters:dict_params) { (dictJSON) in
            print(dictJSON)
            
            if dictJSON["status"] as! String == "success" {
                self.str_MSG = dictJSON["message"] as! String
            }
            completionHandler(dictJSON["status"] as! String)
        }
    }

    
}







