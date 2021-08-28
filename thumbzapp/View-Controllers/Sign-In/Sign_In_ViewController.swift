//
//  Sign_In_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift
import SVProgressHUD
import FBSDKLoginKit
import GoogleSignIn

class Sign_In_ViewController: UIViewController, GIDSignInUIDelegate , GIDSignInDelegate ,UITextFieldDelegate {
    //    MARK:- IBOutlets
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var img_Logo:UIImageView!
    @IBOutlet weak var emailTF: ACFloatingTextfield!
    @IBOutlet weak var passwordImage: UIImageView!
    
    @IBOutlet weak var passwordTF: ACFloatingTextfield!
    @IBOutlet weak var btn_NewUserSignUp:UIButton!
    @IBOutlet weak var btn_SignIn:UIButton!

    @IBOutlet weak var view_Credentials:UIView!
    @IBOutlet weak var view_Shadow_SignIn:UIView!
    @IBOutlet weak var view_Gradient_SignIn:UIView!
    
    @IBOutlet weak var btn_Client:UIButton!
    @IBOutlet weak var btn_Trainer:UIButton!
    
    @IBOutlet weak var constaint_Hight:NSLayoutConstraint!

    //    MARK:- vars
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //    MARK:- VC's life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
           GIDSignIn.sharedInstance().uiDelegate = self
      func_Set_Gradient_Color()
        func_SetDesign()
        func_Set_Shadow()
//        func_Set_Gradient_Layer(btn_SignIn)
        func_Set_HightOfView()
        emailImage.isHidden = true
        passwordImage.isHidden = true
        emailTF.delegate = self
        passwordTF.delegate = self
        
    }

    //     MARK:- textfield delegates
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTF{
            if textField.text == "" {
                emailImage.isHidden = true
            }
            else{
                emailImage.isHidden = false
            }
        }

        else if textField == passwordTF{
            if textField.text == "" {
                passwordImage.isHidden = true
            }
            else{
                passwordImage.isHidden = false
            }
        }
    }
    
    
    //    MARK:- IBActions
   @IBAction func btn_RemeberME(_ sender:UIButton) {
        sender.isSelected = !(sender.isSelected)
    
        UserDefaults.standard.set(sender.isSelected, forKey: "rememberMe")
    }
    
    
    @IBAction func btn_Trainer(_ sender:UIButton) {
       btn_Client.isSelected = false
       btn_Trainer.isSelected = true
    }
    @IBAction func btn_Client(_ sender:UIButton) {
       btn_Client.isSelected = true
       btn_Trainer.isSelected = false
    }
    
    @IBAction func signin(_ sender: UIButton) {
        
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
                SVProgressHUD.showError(withStatus: "Are you a Coach or  Client?")
            }
            else{
                let d_T = UserDefaults.standard.object(forKey: "device_token")
                
                print(LOGIN_URL)
                let parameters : [String:Any] = ["type":client_or_trainer,"email":"\(emailTF.text!)","password":"\(passwordTF.text!)","device_type":DEVICE_TYPE,"device_token":"\(d_T!)"]
                print(parameters)
                APIFunc.postAPI(url: LOGIN_URL, parameters: parameters) { (response) in
                    let status = "\(response["status"]!)"
                    if status == "failed" {
                        let message = "\(response["message"]!)"
                        SVProgressHUD.dismiss()
                        SVProgressHUD.showError(withStatus: message)
                    } else {
                        let result : NSArray = response["result"] as! NSArray
                        print("result is:-",result)
                        
                        let resultDict : NSDictionary = result[0] as! NSDictionary
                        ThumbzappUserDefaults.sharedInstance.user_type = client_or_trainer
                        
                        if client_or_trainer == "1" {
                            
                            Model_SignUp.shared.userType = client_or_trainer
                            
                            ThumbzappUserDefaults.sharedInstance.userId = "\(resultDict["trainer_id"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_email = "\(resultDict["trainer_email"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_name = "\(resultDict["trainer_name"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_image = "\(resultDict["trainer_profile"]!)"
                            
                            ThumbzappUserDefaults.sharedInstance.retriveUserFromUserDefaults()
                            
                            let main_Storyboard = UIStoryboard (name: "Trainer", bundle: nil)
                            let choose_VC = main_Storyboard.instantiateViewController(withIdentifier: "myClientsVC")
                            self.present(choose_VC, animated: true, completion: nil)
                        } else if client_or_trainer == "2" {
                            
                            Model_SignUp.shared.userType = client_or_trainer
                            
                            ThumbzappUserDefaults.sharedInstance.userId = "\(resultDict["client_id"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_email = "\(resultDict["client_email"]!)"
                            ThumbzappUserDefaults.sharedInstance.trainer_id = "\(resultDict["trainer_id"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_password = "\(resultDict["client_password"]!)"
                            
                            ThumbzappUserDefaults.sharedInstance.user_password = "\(resultDict["client_password"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_image = "\(resultDict["client_profile"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_name = "\(resultDict["client_name"]!)"
                            
                            UserDefaults.standard.set("\(resultDict["trainer_name"]!)", forKey: "trainer_name")
                            UserDefaults.standard.set("\(resultDict["trainer_profile"]!)", forKey: "trainer_profile")
                            
                            ThumbzappUserDefaults.sharedInstance.retriveUserFromUserDefaults()
                            
                            let schedule_Your_Choice = self.storyboard?.instantiateViewController(withIdentifier: "tabbar")
                            self.present(schedule_Your_Choice!, animated: true, completion: nil)
                        }
                        SVProgressHUD.dismiss()
                    }
                }
            }
        }
    }
    
    //    MARK:- Custom functions
    @IBAction func Google_Login(_ sender: UIButton) {
        
        var client_or_trainer = String()
        
        if btn_Client.isSelected{
            client_or_trainer = "2"
        }
        else if btn_Trainer.isSelected{
            client_or_trainer = "1"
        }
        
        if client_or_trainer.isEmpty{
            SVProgressHUD.dismiss()
            SVProgressHUD.showError(withStatus: "Are you a Coach or  Client?")
        }
        else{
         
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().uiDelegate=self
            GIDSignIn.sharedInstance().signIn()
        }
    }
    
    @IBAction func fbLogin(_ sender: UIButton) {
        
        var client_or_trainer = String()
        
        if btn_Client.isSelected{
            client_or_trainer = "2"
        }
        else if btn_Trainer.isSelected{
            client_or_trainer = "1"
        }
        
        if client_or_trainer.isEmpty{
            SVProgressHUD.dismiss()
            SVProgressHUD.showError(withStatus: "Are you a Coach or  Client?")
        }
        else{
            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
            fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
                if (error == nil) {
                    let fbloginresult : FBSDKLoginManagerLoginResult = result!
                    // if user cancel the login
                    if (result?.isCancelled)!{
                        return
                    }
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }
        
    }
    
    
    
    @IBAction func newSignup(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sign_Up_ViewController") as! Sign_Up_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
//    MARK:- Finish
    func getFBUserData(){
        SVProgressHUD.show()
        
        if((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil) {
                    //everything works print the user data
                    print(result!)
                    let resultJson : NSDictionary = result as! NSDictionary
                    let socialID = "\(resultJson["id"]!)"
                    let name = "\(resultJson["name"]!)"
                    let imageDict : NSDictionary = resultJson["picture"] as! NSDictionary
                    let dataOne : NSDictionary = imageDict["data"] as! NSDictionary
                    let imageUrl = "\(dataOne["url"]!)"
                    
                    var client_or_trainer = String()
                    let d_T = UserDefaults.standard.object(forKey: "device_token")

                    if self.btn_Client.isSelected{
                        client_or_trainer = "2"
                    }
                    else if self.btn_Trainer.isSelected{
                        client_or_trainer = "1"
                    }
                    if client_or_trainer == "1"{
                        let param : [String:Any] = ["type":"1","trainer_profile":imageUrl,"trainer_name":name,"trainer_social":socialID,"trainer_device_type":DEVICE_TYPE,"trainer_device_token":"\(d_T!)"]
                        
                        APIFunc.postAPI(url: TRAINER_SOCIAL_LOGIN, parameters: param, completion: { (response) in
                            print(response)
                            let result : NSArray = response["result"] as! NSArray
                            let resultDict : NSDictionary = result[0] as! NSDictionary
                            ThumbzappUserDefaults.sharedInstance.user_type = client_or_trainer
                            
                            Model_SignUp.shared.userType = client_or_trainer
                            
                            ThumbzappUserDefaults.sharedInstance.userId = "\(resultDict["trainer_id"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_email = "\(resultDict["trainer_email"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_name = "\(resultDict["trainer_name"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_image = "\(resultDict["trainer_profile"]!)"

                            ThumbzappUserDefaults.sharedInstance.retriveUserFromUserDefaults()
                            
                            let main_Storyboard = UIStoryboard (name: "Trainer", bundle: nil)
                            let choose_VC = main_Storyboard.instantiateViewController(withIdentifier: "myClientsVC")
                            self.present(choose_VC, animated: true, completion: nil)
                        })
                    }
                    else if client_or_trainer == "2" {
                        let param : [String:Any] = ["type":"2","client_profile":imageUrl,"client_name":name,"client_social":socialID,"client_device_type":DEVICE_TYPE,"client_device_token":"\(d_T!)"]
                        print(param)
                        
                        APIFunc.postAPI(url: CLIENT_SOCIAL_LOGIN, parameters: param, completion: { (response) in
                            
                            let result : NSArray = response["result"] as! NSArray
                            let resultDict : NSDictionary = result[0] as! NSDictionary
                            print(resultDict)
                            
                            ThumbzappUserDefaults.sharedInstance.user_type = client_or_trainer
                            
                            Model_SignUp.shared.userType = client_or_trainer
                            
                            ThumbzappUserDefaults.sharedInstance.userId = "\(resultDict["client_id"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_email = "\(resultDict["client_email"]!)"
                            ThumbzappUserDefaults.sharedInstance.trainer_id = "\(resultDict["trainer_id"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_password = "\(resultDict["client_password"]!)"
                            
                            ThumbzappUserDefaults.sharedInstance.user_image = "\(resultDict["client_profile"]!)"
                            ThumbzappUserDefaults.sharedInstance.user_name = "\(resultDict["client_name"]!)"
                            
                            UserDefaults.standard.set("\(resultDict["trainer_name"]!)", forKey: "trainer_name")
                            UserDefaults.standard.set("\(resultDict["trainer_profile"]!)", forKey: "trainer_profile")
                            
                            ThumbzappUserDefaults.sharedInstance.retriveUserFromUserDefaults()
                            
                            let schedule_Your_Choice = self.storyboard?.instantiateViewController(withIdentifier: "tabbar")
                            self.present(schedule_Your_Choice!, animated: true, completion: nil)
                        })
                    }
                    
                  SVProgressHUD.dismiss()
                } else {
                  SVProgressHUD.dismiss()
                }
            })
        }
    }
    
    //    MARK: google login
    
    //MARK:- Google Delegate
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                     withError error: Error!) {
        
        if (error == nil) {
            // Perform any operations on signed in user here.
            let socialID = user.userID
            let name = user.profile.name
            var imageUrl = String()
            
            if user.profile.hasImage{
                imageUrl = "\(user.profile.imageURL(withDimension: (200))!)"
            }
            else{
                imageUrl = ""
            }

            var client_or_trainer = String()
            let d_T = UserDefaults.standard.object(forKey: "device_token")

            if self.btn_Client.isSelected{
                client_or_trainer = "2"
            }
            else if self.btn_Trainer.isSelected{
                client_or_trainer = "1"
            }
            if client_or_trainer == "1"{
                let param : [String:Any] = ["type":"1","trainer_profile":imageUrl,"trainer_name":name!,"trainer_social":socialID!,"trainer_device_type":DEVICE_TYPE,"trainer_device_token":"\(d_T!)"]
                APIFunc.postAPI(url: TRAINER_SOCIAL_LOGIN, parameters: param, completion: { (response) in
                    
                    let result : NSArray = response["result"] as! NSArray
                    let resultDict : NSDictionary = result[0] as! NSDictionary
                    ThumbzappUserDefaults.sharedInstance.user_type = client_or_trainer
                    
                    Model_SignUp.shared.userType = client_or_trainer

                    ThumbzappUserDefaults.sharedInstance.userId = "\(resultDict["trainer_id"]!)"
                    ThumbzappUserDefaults.sharedInstance.user_email = "\(resultDict["trainer_email"]!)"
                    ThumbzappUserDefaults.sharedInstance.user_name = "\(resultDict["trainer_name"]!)"
                    ThumbzappUserDefaults.sharedInstance.user_image = "\(resultDict["trainer_profile"]!)"

                    
                    ThumbzappUserDefaults.sharedInstance.retriveUserFromUserDefaults()
                    let main_Storyboard = UIStoryboard (name: "Trainer", bundle: nil)
                    let choose_VC = main_Storyboard.instantiateViewController(withIdentifier: "myClientsVC")
                    self.present(choose_VC, animated: true, completion: nil)
                })
            }
            else if client_or_trainer == "2"{
                let param : [String:Any] = ["type":"2","client_profile":imageUrl,"client_name":name!,"client_social":socialID!,"client_device_type":DEVICE_TYPE,"client_device_token":"\(d_T!)"]
                APIFunc.postAPI(url: CLIENT_SOCIAL_LOGIN, parameters: param, completion: { (response) in
                    
                    let result : NSArray = response["result"] as! NSArray
                    let resultDict : NSDictionary = result[0] as! NSDictionary
                    ThumbzappUserDefaults.sharedInstance.user_type = client_or_trainer
                    
                    Model_SignUp.shared.userType = client_or_trainer

                    ThumbzappUserDefaults.sharedInstance.userId = "\(resultDict["client_id"]!)"
                    ThumbzappUserDefaults.sharedInstance.user_email = "\(resultDict["client_email"]!)"
                    ThumbzappUserDefaults.sharedInstance.trainer_id = "\(resultDict["trainer_id"]!)"
                    
                    ThumbzappUserDefaults.sharedInstance.user_password = "\(resultDict["client_password"]!)"
                    ThumbzappUserDefaults.sharedInstance.user_image = "\(resultDict["client_profile"]!)"
                    ThumbzappUserDefaults.sharedInstance.user_name = "\(resultDict["client_name"]!)"

                    UserDefaults.standard.set("\(resultDict["trainer_name"]!)", forKey: "trainer_name")
                    UserDefaults.standard.set("\(resultDict["trainer_profile"]!)", forKey: "trainer_profile")
                    
                    ThumbzappUserDefaults.sharedInstance.retriveUserFromUserDefaults()
                    let schedule_Your_Choice = self.storyboard?.instantiateViewController(withIdentifier: "tabbar")
                    self.present(schedule_Your_Choice!, animated: true, completion: nil)
                })
            }

            SVProgressHUD.dismiss()

        } else {
            print("\(error)")
        }
    }
    
    

    
    
    
    
    
    
    
    
    
    
}
