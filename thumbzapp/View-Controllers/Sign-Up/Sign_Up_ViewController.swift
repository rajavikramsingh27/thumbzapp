//
//  Sign_Up_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift
import SVProgressHUD
import AVFoundation

class Sign_Up_ViewController: UIViewController , UITextFieldDelegate{
    //    MARK:- IBOutlets
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var nameImage: UIImageView!
    @IBOutlet weak var img_Logo:UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var btn_NewUserSignUp:UIButton!
    @IBOutlet weak var btn_SignIn:UIButton!
    @IBOutlet weak var btn_Client:UIButton!
    @IBOutlet weak var btn_Trainer:UIButton!
    @IBOutlet weak var view_Credentials:UIView!
    @IBOutlet weak var NameTF: ACFloatingTextfield!
    @IBOutlet weak var constaint_Hight:NSLayoutConstraint!
    @IBOutlet weak var emailTF: ACFloatingTextfield!
    @IBOutlet weak var passwordTF: ACFloatingTextfield!
    
    @IBOutlet weak var view_Shadow_SignIn:UIView!
    @IBOutlet weak var view_Gradient_SignIn:UIView!
    
    
    //    MARK:- vars
    var imagePicker = UIImagePickerController()
    var imageName = String()
    var declarationImage: UIImage!
    var chosenImage = UIImage.init()
    var profilePicture : UIImage!
    //    MARK:- VC's life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        func_SetDesign()
        func_Set_Shadow()
        func_Set_Gradient_Color()
        func_Set_HightOfView()
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        
        passwordImage.isHidden = true
        emailImage.isHidden = true
        nameImage.isHidden = true
        NameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
    }
    //     MARK:- textfield delegates
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == NameTF{
            if textField.text == ""{
                nameImage.isHidden = true
            }
            else{
                nameImage.isHidden = false
            }
        }
        else if textField == emailTF{
            if textField.text == ""{
                emailImage.isHidden = true
            }
            else{
                emailImage.isHidden = false
            }

        }
        else if textField == passwordTF{
            if textField.text == ""{
                passwordImage.isHidden = true
            }
            else{
                passwordImage.isHidden = false
            }
        }
    }
    
    
    
    //    MARK:- IBActions
    @IBAction func btn_Trainer(_ sender:UIButton) {
        btn_Client.isSelected = false
        btn_Trainer.isSelected = true
    }
    
    @IBAction func btn_Client(_ sender:UIButton) {
        btn_Client.isSelected = true
        btn_Trainer.isSelected = false
    }
    
    @IBAction func btn_NewUserSignUp(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btn_SignIn(_ sender:UIButton) {
        let email = func_IsValidEmail(testStr: emailTF.text!)

        if emailTF.text == ""{
            SVProgressHUD.showError(withStatus: "Enter Email")
        }
        else if passwordTF.text == ""{
            SVProgressHUD.showError(withStatus: "Enter Password")
            
        }
        else if passwordTF.text!.count < 6{
            SVProgressHUD.showError(withStatus: "Password Should Be Greater Than 6 letters")
        }
        else if self.NameTF.text == ""{
            SVProgressHUD.showError(withStatus: "Enter Name")
        }
        else if self.declarationImage == nil{
            SVProgressHUD.showError(withStatus: "Select Image")
        }
        else if email == false{
            SVProgressHUD.showError(withStatus: "Enter a Valid Email Address")
            }
        else{
            
            //            type1: trainer
            //            #type2: client
            SVProgressHUD.show()
            
            var client_or_trainer = String()
            
            if btn_Client.isSelected{
                client_or_trainer = "2"
            }
            else if btn_Trainer.isSelected{
                client_or_trainer = "1"
            }
            
            if client_or_trainer.isEmpty{
                SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus: "Select coach or Client")
            }
            else{
                
                
                var parameter = [String:Any]()
                let d_T = UserDefaults.standard.object(forKey: "device_token")
                let imageData : Data = UIImageJPEGRepresentation(declarationImage, 0.2)!
                if client_or_trainer == "1"{
                    parameter = ["type":"1","trainer_name":"\(NameTF.text!)","trainer_email":"\(emailTF.text!)","trainer_password":"\(passwordTF.text!)","trainer_device_type":DEVICE_TYPE,"trainer_device_token":"\(d_T!)"]
                }
                else if client_or_trainer == "2"{
                    parameter = ["type":"2","client_name":"\(NameTF.text!)","client_email":"\(emailTF.text!)","client_password":"\(passwordTF.text!)","client_device_type":DEVICE_TYPE,"client_device_token":"\(d_T!)"]
                }
                APIFunc.postApiMultiPart(url: CLIENT_SIGNUP, imageParamaterName: "profile", parameters: parameter, imageData: imageData, completion: { (response) in
                        
                    
                    let status = "\(response["status"]!)"
                    if status == "failed"{
                        let message = "\(response["message"]!)"
                        SVProgressHUD.dismiss()
                        SVProgressHUD.showError(withStatus: message)
                    }
                    else{
                        let result : NSArray = response["result"] as! NSArray
                        let resultDict : NSDictionary = result[0] as! NSDictionary
                        ThumbzappUserDefaults.sharedInstance.user_type = client_or_trainer
                        if client_or_trainer == "1"{
                            // trainer
                            Model_SignUp.shared.userType = client_or_trainer
                            
                            ThumbzappUserDefaults.sharedInstance.userId = "\(resultDict["trainer_id"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_email = "\(resultDict["trainer_email"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_name = "\(resultDict["trainer_name"]!)"
                            
                            if let client_profile = resultDict["client_profile"] as? String {
                                ThumbzappUserDefaults.sharedInstance.user_image = client_profile
                                ThumbzappUserDefaults.sharedInstance.user_name = "\(resultDict["client_name"]!)"
                            }
                            
                            ThumbzappUserDefaults.sharedInstance.retriveUserFromUserDefaults()
                            
                            let main_Storyboard = UIStoryboard (name: "Trainer", bundle: nil)
                            let choose_VC = main_Storyboard.instantiateViewController(withIdentifier: "myClientsVC")
                            self.present(choose_VC, animated: true, completion: nil)
                        }
                        else if client_or_trainer == "2"{
                            // client
                            Model_SignUp.shared.userType = client_or_trainer

                            ThumbzappUserDefaults.sharedInstance.userId = "\(resultDict["client_id"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_email = "\(resultDict["client_email"]!)"
                            ThumbzappUserDefaults.sharedInstance.trainer_id = "\(resultDict["trainer_id"]!)"
                            
                            ThumbzappUserDefaults.sharedInstance.user_password = "\(resultDict["client_password"]!)"
                            
                            if let client_profile = resultDict["client_profile"] as? String {
                                ThumbzappUserDefaults.sharedInstance.user_image = client_profile
                                ThumbzappUserDefaults.sharedInstance.user_name = "\(resultDict["client_name"]!)"
                            }
                            
                            ThumbzappUserDefaults.sharedInstance.retriveUserFromUserDefaults()
                            let schedule_Your_Choice = self.storyboard?.instantiateViewController(withIdentifier: "tabbar")
                            self.present(schedule_Your_Choice!, animated: true, completion: nil)
                        }
                        SVProgressHUD.dismiss()
                    }
                })
            }
        }
    }
    
    //    MARK:- Custom functions
    @IBAction func signin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectImage(_ sender: UIButton) {
        chooseImagePickerMethod()
    }
}

extension Sign_Up_ViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func checkPermissionForCamera() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            self.openCamera()
        } else if AVCaptureDevice.authorizationStatus(for: .video) == .denied {
            self.alertPromptToAllowCameraAccessViaSetting()
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    self.openCamera()
                }
            })
        }
    }
    
    func checkPermissionForPhotos() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            self.openPhotoLibrary()
        } else if AVCaptureDevice.authorizationStatus(for: .video) == .denied {
            self.alertPromptToAllowCameraAccessViaSetting()
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    self.openPhotoLibrary()
                }
            })
        }
    }
    
    func alertPromptToAllowCameraAccessViaSetting() {
        let alert = UIAlertController.init(title: "Permission Required", message: "Allow camera to take photo for your profile pic.", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Cancel", style: .default, handler: { (sender) in
            
        })
        let action1 = UIAlertAction.init(title: "Settings", style: .default, handler: { (sender) in
            UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!, options: [ : ], completionHandler: nil)
        })
        alert.addAction(action)
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }
    
    func chooseImagePickerMethod() {
        let actionSheetController = UIAlertController(title: "Please select", message: nil, preferredStyle: .actionSheet)
        
        let openCameraAction = UIAlertAction(title: "Open Camera", style: .default) { action -> Void in
            self.checkPermissionForCamera()
        }
        let chooseFromPhotosAction = UIAlertAction(title: "Choose from Photos", style: .default) { action -> Void in
            self.checkPermissionForPhotos()
        }
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in  }
        
        actionSheetController.addAction(openCameraAction)
        actionSheetController.addAction(chooseFromPhotosAction)
        actionSheetController.addAction(cancelActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        profileImage.image = chosenImage
        self.declarationImage = profileImage.image
        print(declarationImage!)
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated:true, completion: nil)
    }
    
}
