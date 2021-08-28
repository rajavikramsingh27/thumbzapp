
//
//  apiFunctions.swift
//  metropolitan
//
//  Created by Love on 31/08/18.
//  Copyright © 2018 Appentus. All rights reserved.
//
import Foundation
import Alamofire

class APIFunc {
    class func postAPI(url: String , parameters: [String:Any] , completion: @escaping ([String:Any]) -> ()){
        let apiURL = url
        let param = parameters
        Alamofire.request(apiURL, method: .post, parameters: param).validate().responseString { (response) in
            switch response.result {
            case .success:
                let responseJson = anyConvertToDictionary(text: response.result.value!)
                completion(responseJson!)
                
                break
            case .failure:
                break
            }
        }
    }
    
    class func getAPI(url: String , parameters: [String:Any] , completion: @escaping ([String:Any]) -> ()){
        let apiURL = url
        let param = parameters
        Alamofire.request(apiURL, method: .get, parameters: param).validate().responseString { (response) in
            switch response.result {
            case .success:
                let responseJson = anyConvertToDictionary(text: response.result.value!)
                completion(responseJson!)
                break
            case .failure:
                break
            }
        }
    }
    
    
    class func postApiMultiPart(url: String ,imageParamaterName : String, parameters: [String:Any] ,imageData: Data, completion: @escaping (NSDictionary) -> ()){
        
        let date = NSDate()
        let df = DateFormatter()
        df.dateFormat = "dd-mm-yy-hh-mm-ss"
        
        let imageName = df.string(from: date as Date)
        Alamofire.upload(multipartFormData: { (multipartFormData : MultipartFormData) in
            multipartFormData.append(imageData, withName: imageParamaterName,fileName: "\(imageName)file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: url) { (result) in
            print(result)
            switch result {
            case .success(let upload, _ , _):
                
                upload.uploadProgress(closure: { (progress) in
                    
                    print("uploding")
                })
                
                upload.responseJSON { response in
                    
                    let resp = response.result.value! as! NSDictionary
                    completion(resp)
                    
                }
                
            case .failure(let encodingError):
                print("failed")
                print(encodingError)
                
            }
        }
    }
    
}



func anyConvertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
            
        }
    }
    return nil
}

func isValidEmail(testStr:String) -> Bool {
    
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: testStr)
}
