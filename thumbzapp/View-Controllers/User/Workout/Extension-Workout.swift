//
//  Extension-Workout.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit



extension Workout_ViewController {

    
    func func_Set_Design() {
        view_ImageContainer.layer.borderColor = UIColor .white.cgColor
        view_ImageContainer.layer .borderWidth = 1
        view_ImageContainer.layer.cornerRadius = view_ImageContainer.frame.size.height/2
        view_ImageContainer.clipsToBounds = true
        
        img_UserImage.layer.cornerRadius = img_UserImage.frame.size.height/2
        img_UserImage.clipsToBounds = true
        
        let img_trainer = UserDefaults.standard.object(forKey: "trainer_profile") as! String
        
        img_UserImage.downloadedFrom(link:img_trainer)
        
        lbl_name.text = UserDefaults.standard.object(forKey: "trainer_name") as? String
    }
    
    func func_Set_Shadow() {
        
    }
}



extension Workout_ViewController :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Activity.shared.arr_exercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_Workout = tableView.dequeueReusableCell(withIdentifier: "cell_Workout", for:indexPath) as! Workout_TableViewCell
        
        let model = Model_Activity.shared.arr_exercise[indexPath.row]
        cell_Workout.lbl_exercise_name.text = model.str_exercise
        
        if model.str_assign_status == "0" {
            cell_Workout.btn_Mark_as_Completed.setTitle("Mark as completed", for: .normal)
            cell_Workout.img_TickMark.tintColor = UIColor.red
        } else {
            cell_Workout.btn_Mark_as_Completed.setTitle("Completed", for: .normal)
            cell_Workout.img_TickMark.tintColor = UIColor.green
        }
        
        cell_Workout.btn_Mark_as_Completed.tag = indexPath.row
        cell_Workout.btn_Mark_as_Completed.addTarget(self, action: #selector(func_complete_workout(_:)), for: .touchUpInside)
        
        return cell_Workout
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func func_complete_workout (_ sender:UIButton) {
        let model = Model_Activity.shared.arr_exercise[sender.tag]
        Model_Activity.shared.str_assign_id = model.str_assign_id
        Model_Activity.shared.str_trainer_id = model.str_trainer_id
        Model_Activity.shared.str_assign_status = model.str_assign_status
        
        if Model_Activity.shared.str_assign_status == "0" {
            func_ShowHud()
            Model_Activity.shared.func_API_complete_workout { (status) in
                DispatchQueue.main.async {
                    self.func_HideHud()
                    
                    if status == "success" {
                        self.func_ShowHude_Success(with: "Successfully completed")
                        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                            self.func_HideHud()
                            self.func_get_exercise_list()
                        })
                    } else {
                        
                    }
                }
            }
        }
    }
    
}




