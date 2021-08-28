//
//  Extension-Excersize_List.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 20/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit



extension Excersize_List_ViewController :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Activity.shared.arr_exercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_calendar = tableView.dequeueReusableCell(withIdentifier: "cell_calendar", for:indexPath)
        
        let model = Model_Activity.shared.arr_exercise[indexPath.row]
        
        let lbl_date = cell_calendar.viewWithTag(1) as! UILabel
        lbl_date.text = Model_Schedule_Workout.shared.str_workout_date
        
        let lbl_workout_name = cell_calendar.viewWithTag(2) as! UILabel
        lbl_workout_name.text = model.str_exercise
        
        return cell_calendar
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}

