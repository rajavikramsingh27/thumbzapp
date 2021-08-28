//
//  Schedule_Workout_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 18/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit

class Schedule_Workout_ViewController: UIViewController
{
//        MARK:- IBOutlets
        @IBOutlet weak var tbl_schedule_workouts:UITableView!
        @IBOutlet weak var btn_done:UIButton!
    
    
    
//    MARK:- vars
        var str_selected_workout_id = ""
        var arr_schedule_workout = [String]()
    
    
    
//    MARK:- VC's life Cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_done.layer.cornerRadius = 2
        btn_done.layer.shadowOpacity = 1.0
        btn_done.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        btn_done.layer.shadowRadius = 3.0
        btn_done.layer.shadowColor = UIColor .lightGray.cgColor
        
        func_ShowHud()
        Model_Schedule_Workout.shared.func_API_get_workout { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
                if status == "success" {
                    for i in 0..<Model_Schedule_Workout.shared.arr_Schedule_Workout.count {
                        self.arr_schedule_workout .append("0")
                    }
                    self.tbl_schedule_workouts.reloadData()
                }
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Model_Schedule_Workout.shared.arr_Schedule_Workout.removeAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK:- IBActions
    @IBAction func btn_Back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_Done(_ sender:UIButton) {
        let alertController = UIAlertController(title: "", message: "Are you sure?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            
            if Model_Schedule_Workout.shared.str_workout_id.isEmpty {
                self.func_ShowHude_Error(with: "select excersize")
                DispatchQueue.main.asyncAfter(deadline:.now()+1, execute: {
                    self.func_HideHud()
                })
                return
            } else {                
                self.func_ShowHud()
                Model_Schedule_Workout.shared.func_API_assign_workout(completionHandler: { (status) in
                    DispatchQueue.main.async {
                        self.func_HideHud()
                        if status == "success" {
                            self.func_ShowHude_Success(with: Model_Schedule_Workout.shared.str_MSG)
                            DispatchQueue.main.asyncAfter(deadline:.now()+1, execute: {
                                self.func_HideHud()
                                Model_Schedule_Workout.shared.str_workout_id = ""
                                self.dismiss(animated: true, completion:nil)
                            })
                        }
                    }
                })
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
            
        }))

        present(alertController, animated: true, completion: nil)
    }
    
    //    MARK:- Custom functions
    
    //    MARK:- Finish
}
