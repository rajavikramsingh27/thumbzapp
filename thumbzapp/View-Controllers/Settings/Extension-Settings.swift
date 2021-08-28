//
//  Extension-Settings.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 29/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import  UIKit
import Alamofire


extension Settings_ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func btn_Image(_ sender:UIButton) {
        func_ChooseImage()
    }
    
    @IBAction func btn_save_edit(_ sender:UIButton) {
        if sender.currentTitle == "Edit" {
            sender.setTitle("Save", for: .normal)
            view_Settings.isUserInteractionEnabled = true
        } else {
            func_Edit_profile()
        }
    }
    
    func func_ChooseImage() {
        
        let alert = UIAlertController(title: "", message: "Select Image", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {
                self.func_OpenCamera()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Photos", style: .default , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {
                self.func_OpenGallary()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
            print("User click Delete button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    func func_OpenCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate=self
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera in simulator", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func func_OpenGallary()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate=self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img_selected = pickedImage
            img_profile.image = img_selected
        }
        
        dismiss(animated: true, completion: nil)
    }
    
     func func_UploadWithImage(endUrl: String, file_Type:Int, imageData: Data?, parameters: [String : String], completionHandler:@escaping ([String:Any])->())
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
                    multipartFormData.append(data, withName: "profile", fileName: "image.png", mimeType: "image/png")
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
                        
                        completionHandler(json as! [String : Any])
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
    
    func func_Edit_profile() {
        func_ShowHud()
        let image_data = UIImageJPEGRepresentation(img_selected, 0.2)
        
        let d_T = UserDefaults.standard.object(forKey: "device_token")
        
        let parameter = ["client_id":ThumbzappUserDefaults.sharedInstance.userId,
                         "client_name":txt_name.text!,
                         "client_email":txt_email.text!,
                         "client_password":txt_password.text!,
                         "client_device_type":"iOS",
                         "client_device_token":"\(d_T!)"]
        
        func_UploadWithImage(endUrl: "http://appentus.me/trainer/api/api/update_client_profile", file_Type: 0, imageData: image_data, parameters: parameter) { (dict_json) in
            print(dict_json)
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if dict_json["status"] as! String == "success" {
                    let dict_client_json = dict_json["result"] as! [[String:Any]]
                    
                    ThumbzappUserDefaults.sharedInstance.userId = "\(dict_client_json[0]["client_id"]!)"
                    ThumbzappUserDefaults.sharedInstance.user_email = "\(dict_client_json[0]["client_email"]!)"
                    ThumbzappUserDefaults.sharedInstance.trainer_id = "\(dict_client_json[0]["trainer_id"]!)"
                    ThumbzappUserDefaults.sharedInstance.user_name = "\(dict_client_json[0]["client_name"]!)"
                    ThumbzappUserDefaults.sharedInstance.user_password = "\(dict_client_json[0]["client_password"]!)"
                    ThumbzappUserDefaults.sharedInstance.user_image = "\(dict_client_json[0]["client_profile"]!)"
                    self.txt_name.text = ThumbzappUserDefaults.sharedInstance.user_name
                    self.txt_email.text = ThumbzappUserDefaults.sharedInstance.user_email
                    self.txt_password.text = ThumbzappUserDefaults.sharedInstance.user_password
                    self.img_profile.downloadedFrom(link: ThumbzappUserDefaults.sharedInstance.user_image)
                    
                    self.view_Settings.isUserInteractionEnabled = false
                    
                    self.func_ShowHude_Success(with: dict_json["message"] as! String)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        self.func_HideHud()
                    })
                    
                } else {
                    self.func_ShowHude_Error(with: dict_json["message"] as! String)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        self.func_HideHud()
                    })
                }
            }
        }

    }
    
    
    
}



