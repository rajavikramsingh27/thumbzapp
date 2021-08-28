//
//  Workout_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit

class Workout_ViewController: UIViewController {
//        MARK:- IBOutlets
            @IBOutlet weak var view_ImageContainer:UIView!
            @IBOutlet weak var lbl_Current_Date:UILabel!
            @IBOutlet weak var tbl_Workout:UITableView!
    
            @IBOutlet weak var lbl_name:UILabel!
    
            @IBOutlet weak var img_UserImage:UIImageView!

    
    //    MARK:- vars
    
    
    //    MARK:- VC's life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date_Current = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyy"
        lbl_Current_Date.text = dateFormatter.string(from: date_Current)
        
        Model_Activity.shared.str_date = lbl_Current_Date.text!
        
        func_Set_Design()
        func_Set_Shadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        func_get_exercise_list()
    }
        
    func func_get_exercise_list() {
        func_ShowHud()
        Model_Activity.shared.func_API_get_workout_client { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if Model_Activity.shared.arr_exercise.count == Model_Activity.shared.arr_exercise_1.count {
                    self.tbl_Workout.isHidden = true
                } else {
                    self.tbl_Workout.isHidden = false
                }
                self.tbl_Workout.reloadData()
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK:- IBActions
    @IBAction func btn_Back(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Mark_as_Completed(_ sender:UIButton) {
        
        let alertController = UIAlertController(title: "", message: "Are you sure ?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.tbl_Workout.reloadData()
        }))
        
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: { (alert) in
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    //    MARK:- Custom functions
    
    //    MARK:- Finish
}


