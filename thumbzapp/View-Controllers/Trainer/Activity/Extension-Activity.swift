//
//  Extension-Activity.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 18/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar



extension Activity_ViewController {
    
    func func_Set_Design() {

    }
    
    func func_Set_Gradient_Color() {
        let gradientView = UIView(frame: CGRect(x: 0, y:222, width: self.view.frame.size.width, height: 30))
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.frame
        
        let color_First = UIColor (red: 109.0/255.0, green: 194.0/255.0, blue: 227.0/255.0, alpha: 1.0)
        let color_Second = UIColor (red: 241.0/255.0, green: 124.0/255.0, blue: 130.0/255.0, alpha: 1.0)
        
        gradientLayer.colors = [color_First.cgColor,color_Second.cgColor]
        gradientView.layer.addSublayer(gradientLayer)
        view.addSubview(gradientView)
        view.bringSubview(toFront: gradientView)
        
//        view.sendSubview(toBack: gradientView)
    }

    
    func func_get_exercise_list() {
        func_ShowHud()
        Model_Activity.shared.func_API_get_workout_client { (status) in
            DispatchQueue.main.async {
                self.func_HideHud()
//                if status == "success" {
                
                if Model_Activity.shared.arr_exercise_1.count > 0 {
                    self.tbl_exercise.isHidden=false
                } else {
                    self.tbl_exercise.isHidden = true
                }
                self.tbl_exercise.reloadData()
//                }
            }
        }
    }
    
}



//  MARK:- UICollectionView methods
extension Activity_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(btn_Day.frame.size.width)
        
//        return CGSize (width:50, height: 50)

        return CGSize (width: collectionView.frame.size.width/7, height: collectionView.frame.size.width/7)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell_Dates = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_Dates", for: indexPath)
        
        let lbl_Dates = cell_Dates.viewWithTag(1) as! UILabel
        lbl_Dates.text = "\(indexPath.row+1)"
        
        if indexPath.row == 0 {
            lbl_Dates.backgroundColor = UIColor (red: 56.0/255.0, green: 168.0/255.0, blue: 212.0/255.0, alpha: 1.0)
            lbl_Dates.layer.cornerRadius = lbl_Dates.frame.size.height/2
            lbl_Dates.clipsToBounds = true
        } else {
            lbl_Dates.backgroundColor = UIColor .white
            lbl_Dates.layer.cornerRadius = lbl_Dates.frame.size.height/2
            lbl_Dates.clipsToBounds = true
        }
        
        return cell_Dates
    }
}


extension Activity_ViewController :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Activity.shared.arr_exercise_1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_Exercise_Details = tableView.dequeueReusableCell(withIdentifier: "cell_Exercise_Details", for:indexPath) as! Activity_TableViewCell
        
        let model = Model_Activity.shared.arr_exercise_1[indexPath.row]
        cell_Exercise_Details.lbl_exercise.text = model.str_exercise
        
        return cell_Exercise_Details
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}



extension Activity_ViewController : FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let date_selected = date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        Model_Activity.shared.str_date = formatter.string(from: date_selected)
        Model_Shared_trainer.shared.str_date = date
        
        func_get_exercise_list()
    }
    
}





