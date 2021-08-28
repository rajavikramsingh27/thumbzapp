//
//  Extension-SignUp.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit

extension Sign_Up_ViewController {
    func func_Set_Gradient_Color() {
        view_Gradient_SignIn.layer.cornerRadius = 4
        view_Gradient_SignIn.clipsToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame = view_Gradient_SignIn.bounds
        
        let color_1 = UIColor (red: 23.0/255.0, green: 223.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        let color_2 = UIColor (red: 56.0/255.0, green: 168.0/255.0, blue: 212.0/255.0, alpha: 1.0)
        
        let color_3 = UIColor (red: 94.0/255.0, green: 117.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        
        gradient.colors = [color_1.cgColor, color_2.cgColor,color_3.cgColor]
        
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        view_Gradient_SignIn.layer.insertSublayer(gradient, at: 0)
    }
    
    func func_Set_HightOfView()  {
//        if self.view.frame.size.height > 568 {
//            constaint_Hight.constant = self.view.frame.size.height
//        } else {
//            constaint_Hight.constant = 800
//        }
    }
    
    func func_SetDesign()  {
//        img_Logo.layer.cornerRadius  = img_Logo.frame.size.height/2
//        img_Logo.clipsToBounds = true
        
        let baseString = btn_NewUserSignUp.titleLabel?.text!
        let attributedString = NSMutableAttributedString(string: baseString!, attributes: nil)
        let dontRange = (attributedString.string as NSString).range(of: "SignIn")
        attributedString.setAttributes([NSAttributedStringKey.font: UIFont (name: "System Semibold", size: 16.0)], range: dontRange)
        attributedString.setAttributes([NSAttributedStringKey.foregroundColor: UIColor .func_Color_Blue()], range: dontRange)
        btn_NewUserSignUp.setAttributedTitle(attributedString, for: .normal)
    }
    
    func func_Set_Shadow() {
        view_Shadow_SignIn.layer.cornerRadius = 4
        view_Shadow_SignIn.layer.shadowOpacity = 5.0
        // shadow opacity ---> uper uthane k liye
        view_Shadow_SignIn.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view_Shadow_SignIn.layer.shadowRadius = 5.0
        let color_Shadow_SignIn = UIColor (red: 166.0/255.0, green: 226.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        view_Shadow_SignIn.layer.shadowColor = color_Shadow_SignIn.cgColor
        
        view_Credentials.layer.cornerRadius = 4
        view_Credentials.layer.shadowOpacity = 30.0
        // shadow opacity ---> uper uthane k liye
        view_Credentials.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view_Credentials.layer.shadowRadius = 30.0
        let color_Shadow = UIColor .lightGray
        view_Credentials.layer.shadowColor = color_Shadow.cgColor
    }
    
}
