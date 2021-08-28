//
//  File_Shared_Trainer_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit

class File_Shared_Trainer_ViewController: UIViewController {
    //    MARK:- IBOutlets
        @IBOutlet weak var view_ImageContainer:UIView!
    
        @IBOutlet weak var tbl_shared_files:UITableView!
    
        @IBOutlet weak var img_UserImage:UIImageView!

        @IBOutlet weak var btn_Back:UIButton!
        @IBOutlet weak var btn_Uplaod_Video_Image:UIButton!
    
        @IBOutlet weak var constaint_Bottom:NSLayoutConstraint!

        @IBOutlet weak var lbl_name:UILabel!

    
    //    MARK:- vars
        var img_share = UIImage()

    
        var file_Type = 0
        var url_Video_Path = URL (string: "")
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //    MARK:- VC's life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Model_SignUp.shared.userType == "2" {
            btn_Back.isHidden = true
            btn_Uplaod_Video_Image.isHidden = true
            constaint_Bottom.constant = 30
        } else {
            btn_Back.isHidden = false
            btn_Uplaod_Video_Image.isHidden = false
            constaint_Bottom.constant = 70
        }
        
        func_Set_Shadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        func_get_share_files()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK:- IBActions
    @IBAction func btn_Done(_ sender:UIButton) {
        
    }
    
    @IBAction func btn_Back(_ sender:Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_Upload_Video_Image(_ sender:UIButton) {
        func_ChooseImage()
    }
        
    //    MARK:- Custom functions
    
    //    MARK:- Finish
}
