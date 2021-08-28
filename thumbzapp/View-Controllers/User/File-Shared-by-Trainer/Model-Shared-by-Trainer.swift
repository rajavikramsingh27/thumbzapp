//
//  Model-Shared-by-Trainer.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 16/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import Alamofire


class Model_Shared_trainer {

    static let shared = Model_Shared_trainer()

    var str_MSG = ""
    
    var shared_file = ""
    var shared_file_type = ""

    var str_date = Date()
    
    var arr_shared_files = [Model_Shared_trainer]()
    
    func func_API_get_share_files(completionHandler:@escaping (String)->()) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let str_date = formatter.string(from:self.str_date)
        
        let strURL = k_BASEURL+"get_share_files"
        print(strURL)
        
        if Model_Schedule_Workout.shared.str_client_id.isEmpty {
            Model_Schedule_Workout.shared.str_client_id = ThumbzappUserDefaults.sharedInstance.userId
        }
        
        let dict_params = [
            "client_id":Model_Schedule_Workout.shared.str_client_id ,
            "date":str_date
        ]
        
        print(dict_params)
        
        APIFunc.postAPI(url: strURL, parameters:dict_params) { (dictJSON) in
            print(dictJSON)
            
            self.arr_shared_files.removeAll()
            if dictJSON["status"] as! String == "success" {
                let arr_exercise = dictJSON["result"] as! [[String:Any]]
                for dict_result in arr_exercise {
                    self.arr_shared_files.append(self.func_get_share_files(dict: dict_result))
                }
            }
            completionHandler(dictJSON["status"] as! String)
        }
    }
    
    func func_get_share_files(dict:[String:Any]) -> Model_Shared_trainer {
        let model = Model_Shared_trainer()
        
        model.shared_file = dict["shared_file"] as! String
        model.shared_file_type = dict["file_type"] as! String
        
        return model
    }
    
    class func func_UploadWithImage(endUrl: String, file_Type:Int, imageData: Data?, parameters: [String : String], completionHandler:@escaping ([String:Any])->())
    {
        let url = URL (string: endUrl) /* your API url */
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData {
                if file_Type == 1 {
//                    multipartFormData.append(data, withName: "file", fileName: "image.jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(data, withName: "file", fileName: "image.jpg", mimeType: "image/jpg")

                } else {
                    multipartFormData.append(data, withName: "file", fileName: "video.mp4", mimeType: "video/mp4")
                }
            }
            
        }, usingThreshold: UInt64.init(), to: url!, method: .post, headers: headers) { (result) in
            
            print(result)
            
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    do {
                        let json =  try JSONSerialization .jsonObject(with:response.data!
                            , options: .allowFragments)
                        print(json)
                        
                        completionHandler(json as! [String:Any])
                    }
                    catch let error as NSError {
                        print("error is:-",error)
                        completionHandler(["status":"false"])
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completionHandler(["status":"false"])
            }
        }
    }
    
    

}







