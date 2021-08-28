//
//  Extension-Schedule-Workouts.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 16/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit



extension Schedule_Workout_ViewController :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Schedule_Workout.shared.arr_Schedule_Workout.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_Workout = tableView.dequeueReusableCell(withIdentifier: "cell_Workout", for:indexPath) as! Schedule_Workouts_TableViewCell
        
        let model = Model_Schedule_Workout.shared.arr_Schedule_Workout[indexPath.row]
        cell_Workout.lbl_name_workout.text = " \(model.str_workout_name)"
        cell_Workout.lbl_description_workout.text = model.str_workout_description
        
        if arr_schedule_workout[indexPath.row] == "0" {
            cell_Workout.img_tick_mark.image = UIImage (named: "")
        } else {
            cell_Workout.img_tick_mark.image = UIImage (named: "tick-Blue")
        }
        
        return cell_Workout
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if arr_schedule_workout[indexPath.row] == "0"{
            for i in 0..<arr_schedule_workout.count{
                arr_schedule_workout[i] = "0"
            }

            arr_schedule_workout[indexPath.row] = "1"
            tbl_schedule_workouts.reloadData()
        }
        else{
            for i in 0..<arr_schedule_workout.count{
                arr_schedule_workout[i] = "0"
            }

            tbl_schedule_workouts.reloadData()

        }

        
        
        let model = Model_Schedule_Workout.shared.arr_Schedule_Workout[indexPath.row]
        Model_Schedule_Workout.shared.str_workout_id = model.str_workout_id
    }

    
    
}
