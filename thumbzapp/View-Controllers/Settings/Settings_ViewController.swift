//
//  Settings_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 10/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit

class Settings_ViewController: UIViewController {
//    MARK:- IBOutlets
        @IBOutlet weak var txt_name:UITextField!
        @IBOutlet weak var txt_email:UITextField!
        @IBOutlet weak var txt_password:UITextField!
    
        @IBOutlet weak var img_profile:UIImageView!

        @IBOutlet weak var view_Settings:UIView!

    //    MARK:- vars
        var img_selected = UIImage()
    
    
    //    MARK:- VC's life Cycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img_profile.layer.cornerRadius = img_profile.frame.size.height/2
        img_profile.clipsToBounds = true
        
        txt_name.text = ThumbzappUserDefaults.sharedInstance.user_name
        txt_email.text = ThumbzappUserDefaults.sharedInstance.user_email
        txt_password.text = ThumbzappUserDefaults.sharedInstance.user_password
        img_profile.downloadedFrom(link: ThumbzappUserDefaults.sharedInstance.user_image)
        
        view_Settings.isUserInteractionEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK:- IBActions
    @IBAction func btn_LogOut (_ sender:UIButton) {
        let alertController = UIAlertController(title: "", message: "Do you want to logout ?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: { (alert) in
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            ThumbzappUserDefaults.sharedInstance.user_type = ""
            ThumbzappUserDefaults.sharedInstance.retriveUserFromUserDefaults()
            
            let sign_In_VC = self.storyboard?.instantiateViewController(withIdentifier: "Sign_In_ViewController")
            self.present(sign_In_VC!, animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btn_Back (_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //    MARK:- Custom functions
    
    //    MARK:- Finish
}
