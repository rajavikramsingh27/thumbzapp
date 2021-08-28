//
//  Extension-File_Shared_Trainer.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import MobileCoreServices


extension File_Shared_Trainer_ViewController {
    
    func func_Set_Shadow() {
        
        btn_Uplaod_Video_Image.layer.borderWidth = 1
        btn_Uplaod_Video_Image.layer.borderColor = UIColor (red: 136.0/255.0, green: 221.0/255.0, blue: 227.0/255.0, alpha: 1.0).cgColor
        btn_Uplaod_Video_Image.layer.cornerRadius = 4
        btn_Uplaod_Video_Image.clipsToBounds = true
        
        view_ImageContainer.layer.borderColor = UIColor .white.cgColor
        view_ImageContainer.layer .borderWidth = 1
        view_ImageContainer.layer.cornerRadius = view_ImageContainer.frame.size.height/2
        view_ImageContainer.clipsToBounds = true
        
        img_UserImage.layer.cornerRadius = img_UserImage.frame.size.height/2
        img_UserImage.clipsToBounds = true
        
        let img_trainer = UserDefaults.standard.object(forKey: "trainer_profile") as! String
        img_UserImage.downloadedFrom(link:img_trainer)
        
        lbl_name.text = UserDefaults.standard.object(forKey: "trainer_name") as? String
    }
    
    func func_get_share_files()  {
        func_ShowHud()
        Model_Shared_trainer.shared.func_API_get_share_files { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                self.tbl_shared_files.reloadData()
            }
        }
    }
    
}



extension File_Shared_Trainer_ViewController :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Shared_trainer.shared.arr_shared_files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_File_Shared = tableView.dequeueReusableCell(withIdentifier: "cell_File_Shared", for:indexPath) as! File_Shared_Trainer_TableViewCell
        
        let model = Model_Shared_trainer.shared.arr_shared_files[indexPath.row]
        if model.shared_file_type == "1" {
            cell_File_Shared.lbl_FileStorage.text = model.shared_file
        } else {
            cell_File_Shared.lbl_FileStorage.text = model.shared_file
        }
        
//        cell_File_Shared.lbl_FileStorage.text = arr_File_Shared[indexPath.row]
        let baseString_100 = cell_File_Shared.lbl_FileStorage.text
        let attributedString = NSMutableAttributedString(string: baseString_100!, attributes: nil)
        
        if model.shared_file_type == "1" {
            let dontRange = (attributedString.string as NSString).range(of: ".png")
            attributedString.setAttributes([NSAttributedStringKey.foregroundColor: UIColor .darkGray], range: dontRange)
        } else {
            let dontRange = (attributedString.string as NSString).range(of: ".mp4")
            attributedString.setAttributes([NSAttributedStringKey.foregroundColor: UIColor .darkGray], range: dontRange)
        }
        
        cell_File_Shared.lbl_FileStorage.attributedText = attributedString
        
        return cell_File_Shared
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = Model_Shared_trainer.shared.arr_shared_files[indexPath.row]
        Model_Shared_trainer.shared.shared_file = model.shared_file
        if model.shared_file_type == "1" {
            let storyboard = UIStoryboard (name: "Main", bundle: nil)
            let full_image_VC = storyboard.instantiateViewController(withIdentifier: "Full_Image_Trainer_ViewController") as! Full_Image_Trainer_ViewController
            present(full_image_VC, animated: true, completion: nil)
        } else {
            func_Video()
        }
    }
    
    func func_Video() {
        print(Model_Shared_trainer.shared.shared_file)
        let url = URL(string: Model_Shared_trainer.shared.shared_file)
        
        let player = AVPlayer(url: url!)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            playerController.player?.play()
        }
    }

}


extension File_Shared_Trainer_ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            imagePicker.mediaTypes = [kUTTypeMovie as String,kUTTypeImage as String]
            
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
        imagePicker.mediaTypes = [kUTTypeMovie as String,kUTTypeImage as String]
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let str_Path_Video = info[UIImagePickerControllerMediaURL] as? URL {
            self.url_Video_Path = str_Path_Video
            file_Type = 2
        }
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img_share = pickedImage
            file_Type = 1
        }
        
        dismiss(animated: true) {
            self.func_upload_file()
        }
    }
    
    func func_upload_file() {
        func_ShowHud()
        
        let strURL = k_BASEURL+"upload_file"
        let dict_params = [
            "trainer_id":ThumbzappUserDefaults.sharedInstance.userId ,
            "client_id":Model_Schedule_Workout.shared.str_client_id,
            "type":"\(file_Type)"
        ]
        
        print(dict_params)
        
        var data = Data()
        if file_Type == 1 {
            data = UIImageJPEGRepresentation(img_share, 0.2)!
        } else {
            do {
                data = try Data(contentsOf:url_Video_Path!)
            } catch {
                print("Unable to load data: \(error)")
            }
        }
        
        Model_Shared_trainer.func_UploadWithImage(endUrl: strURL, file_Type: file_Type, imageData: data, parameters: dict_params) { (dict_json) in
            print(dict_json)
            DispatchQueue.main.async {
                self.func_HideHud()
                if dict_json["status"] as! String == "success" {
                    self.func_ShowHude_Success(with:dict_json["message"] as! String)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        self.func_HideHud()
                        self.func_get_share_files()
                    })
                }
            }
        }
    }

}




