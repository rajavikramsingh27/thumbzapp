
//  Konstant.swift
//  thumbzapp
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.



import Foundation
import UIKit
import SVProgressHUD



// MARK:- KONSTANT THINGS
let k_User_Device_Value = "Ios"
let k_Token_Value = "03af688d3c57b62511a98f878e819184"


// MARK:- BASE URL

let k_BASEURL = "https://appentus.me/trainer/api/api/"

// MARK:- REST URLS
// MARK:- REGISTRATION
let k_get_workout = "get_workout"
let k_assign_workout = "assign_workout"
let k_upload_file = "upload_file"



//MARK:- PARAMETERS

// MARK:- REGISTRATION

let k_User_Name = "user_name"
let k_User_Email = "user_email"
let k_User_Password = "user_password"
let k_User_Device = "user_device"
let k_User_Token = "_token"



// MARK:- RESPONSE PARAMETERS KEY

extension UIViewController {
    
    func func_ShowHud() {
        SVProgressHUD .show()
        self.view .isUserInteractionEnabled = false
    }
    
    func func_HideHud()  {
        SVProgressHUD .dismiss()
        self.view.isUserInteractionEnabled = true
    }
    
    func func_ShowHude_Success(with success_MSG:String) {
        SVProgressHUD.showSuccess(withStatus: success_MSG)
        self.view.isUserInteractionEnabled = true
    }
    
    func func_ShowHude_Error(with success_MSG:String) {
        SVProgressHUD.showError(withStatus: success_MSG)
        self.view.isUserInteractionEnabled = true
    }
    
}


extension UIViewController {
    
    func func_IsValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}

extension UIColor {
   class func func_Color_Blue() -> UIColor {
        return UIColor (red: 112.0/255.0, green: 119.0/255.0, blue: 236.0/255.0, alpha: 1.0)
    }
}


extension UIColor
{
    class func funcGradientLayerEx() -> (gradientColorFirst:UIColor , gradientColorSecond:UIColor)
    {
        let colorFirst = UIColor (red: 94.0/255.0, green: 198.0/255.0, blue: 226.0/255.0, alpha: 1.0)
        let colorSecond = UIColor (red: 243.0/255.0, green: 119.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        return (colorFirst,colorSecond)
    }
}

