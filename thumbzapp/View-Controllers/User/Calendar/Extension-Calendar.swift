//
//  Extension-Calendar.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import FSCalendar



extension Calendar_ViewController {
    func func_Set_Design() {
        
//        view_Calendar.appearance.separators = .interRows
        
        btn_Plus.layer.cornerRadius = btn_Plus.frame.size.height/2
        btn_Plus.layer.shadowOpacity = 1.0
        btn_Plus.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        btn_Plus.layer.shadowRadius = 3.0
        btn_Plus.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    func func_Set_Diagonal_CutOnView(view_For_Grdient:UIView) {
            let size = view_For_Grdient.bounds.size
            //get 4 points for the shape layer
            let p1 = view_For_Grdient.bounds.origin
            let p2 = CGPoint(x: p1.x + size.width, y: p1.y)
            let p3 = CGPoint(x: p2.x, y: size.height)
            let p4 = CGPoint(x: p1.x, y: size.height - 70)
        
            //create the path
            let path = UIBezierPath () //(rect: CGRect (x: p1.x, y: p2.y, width: 100, height: 100))
            path.move(to: p1)
            path.addLine(to: p2)
            path.addLine(to: p3)
            path.addLine(to: p4)
            path.close()
            path.fill()
            (UIColor .clear ).set()
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
        
            view_For_Grdient.layer.mask = shapeLayer
        }
    
    func func_Set_Gradient_Color()  {
//        view_Calendar.backgroundColor = UIColor .clear
        
        var gradientView = UIView()
        let gradientLayer = CAGradientLayer()
        
//        if let tabbar = self.tabBarController?.tabBar {
//            gradientView = UIView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height:500))
//            gradientLayer.frame = gradientView.frame
//        } else {
            gradientView = UIView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height:500))
            gradientLayer.frame = gradientView.frame
//        }
        
//        var frame_GradientView = gradientLayer.frame
//        frame_GradientView.origin.y = view.frame.origin.y
//        frame_GradientView.origin.y = 0
//        gradientView.frame = frame_GradientView
        
        let color_First = UIColor (red: 109.0/255.0, green: 194.0/255.0, blue: 227.0/255.0, alpha: 1.0)
        let color_Second = UIColor (red: 241.0/255.0, green: 124.0/255.0, blue: 130.0/255.0, alpha: 1.0)
        
        gradientLayer.colors = [color_First.cgColor,color_Second.cgColor]
        gradientView.layer.addSublayer(gradientLayer)
        view.addSubview(gradientView)
        view.sendSubview(toBack: gradientView)
        
        func_Set_Diagonal_CutOnView(view_For_Grdient: gradientView)
    }
}


extension Calendar_ViewController : FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let date_selected = date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        Model_Schedule_Workout.shared.str_workout_date = formatter.string(from: date_selected)
        Model_Activity.shared.str_date = formatter.string(from: date_selected)
        if Model_SignUp.shared.userType == "2" {
            btn_Back.isHidden = true
            
            let storyBoard = UIStoryboard (name: "Main", bundle: nil)
            let excersize_List_VC = storyBoard.instantiateViewController(withIdentifier: "Excersize_List_ViewController") as! Excersize_List_ViewController
            present(excersize_List_VC, animated: true, completion: nil)
            
//            let alertController = UIAlertController(title: "", message: "No Exercise assigned by coach", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
//                
//            }))
//            present(alertController, animated: true, completion: nil)
            
        } else {

        }
    }

}

