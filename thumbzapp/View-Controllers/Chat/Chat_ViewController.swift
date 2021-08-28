//
//  Chat_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit
import FSCalendar


class Chat_ViewController: UIViewController {
    //    MARK:- IBOutlets
            @IBOutlet weak var view_TextContainer:UIView!
            @IBOutlet weak var btn_Send:UIButton!
            @IBOutlet weak var tbl_chat:UITableView!
            @IBOutlet weak var txt_msg:UITextField!
    
    //    MARK:- vars
    
    //    MARK:- VC's life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func_Set_Design()
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_refresh_on_notification), name: Notification.Name("chat"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        func_ShowHud()
        Model_chat.shared.func_API_get_user_chat { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                self.tbl_chat.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK:- IBActions
    @IBAction func btn_Back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_send_msg(_ sender:Any) {
        func_ShowHud()
        Model_chat.shared.str_send_msg = txt_msg.text!
        Model_chat.shared.func_API_send_msg { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                self.txt_msg.text = ""
                
                self.func_ShowHud()
                Model_chat.shared.func_API_get_user_chat { (status) in
                    DispatchQueue.main.async {
                        self.func_HideHud()
                        self.tbl_chat.reloadData()
                    }
                }
                
            }
        }
    }
    
    //    MARK:- Custom functions
    @objc func func_refresh_on_notification()  {
        self.func_ShowHud()
        Model_chat.shared.func_API_get_user_chat { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                self.tbl_chat.reloadData()
            }
        }
    }
    
    //    MARK:- Finish
}
