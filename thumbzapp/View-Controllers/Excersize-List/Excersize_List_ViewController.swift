//
//  Excersize_List_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 20/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit

class Excersize_List_ViewController: UIViewController {
    //    MARK:- IBOutlets
        @IBOutlet weak var tbl_exercise:UITableView!

    //    MARK:- vars
    
    //    MARK:- VC's life Cycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func_get_exercise_list()
    }
    
    func func_get_exercise_list() {
        func_ShowHud()
        Model_Activity.shared.func_API_get_workout_client { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                
                if Model_Activity.shared.arr_exercise.count > 0 {
                    self.tbl_exercise.isHidden = false
                } else {
                    self.tbl_exercise.isHidden = true
                }
                self.tbl_exercise.reloadData()
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

    //    MARK:- Custom functions
    
    //    MARK:- Finish
}
