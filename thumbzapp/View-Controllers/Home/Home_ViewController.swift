//
//  Home_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 20/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit
import SDWebImage


class Home_ViewController: UIViewController  {
//    MARK:- IBOutlets
        @IBOutlet weak var btn_Profile: UIButton!
        @IBOutlet weak var tbl_home: UITableView!
        @IBOutlet weak var coll_video_shared: UICollectionView!

    //    MARK:- vars
        var arr_shared_videos = [Model_Shared_trainer]()
    
    //    MARK:- VC's life Cycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func_Set_Design()
        
        Model_chat.shared.str_current_user_image = ThumbzappUserDefaults.sharedInstance.user_image
        
        Model_chat.shared.str_user_id = ThumbzappUserDefaults.sharedInstance.userId
        Model_chat.shared.str_fri_id = ThumbzappUserDefaults.sharedInstance.trainer_id
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd MMM yyy"
        Model_Activity.shared.str_date = dateformatter.string(from: date)
        Model_Shared_trainer.shared.str_date = date
        
        func_get_exercise_list()
        func_get_share_files()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func func_get_exercise_list() {
        func_ShowHud()
        Model_Home.shared.func_API_get_latest_workout_client { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                self.tbl_home.reloadData()
            }
        }
    }
    
    func func_get_share_files() {
        func_ShowHud()
        Model_Shared_trainer.shared.func_API_get_share_files { (status) in
            DispatchQueue.main.async {
                for model in Model_Shared_trainer.shared.arr_shared_files {
                    if model.shared_file_type == "2" {
                        self.arr_shared_videos.append(model)
                    }
                }
                self.tbl_home.reloadData()
                self.func_HideHud()
            }
        }
        
    }

    
    //    MARK:- IBActions
    @IBAction func btn_Profile(_ sender: Any) {
        let settings_VC = storyboard?.instantiateViewController(withIdentifier: "Settings_ViewController")
        present(settings_VC!, animated: true, completion: nil)
    }
    
    //    MARK:- Custom functions
    
    //    MARK:- Finish
}
