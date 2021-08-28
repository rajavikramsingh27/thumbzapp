//
//  Calendar_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit
import FSCalendar


class Calendar_ViewController: UIViewController {
    //    MARK:- IBOutlets
        @IBOutlet weak var view_Calendar:FSCalendar!
        @IBOutlet weak var btn_Plus:UIButton!
        @IBOutlet weak var btn_Back:UIButton!
        
        @IBOutlet weak var view_ForGradientColor:UIView!
    
    
//        @IBOutlet weak var view_Down:UIView!
    
    //    MARK:- vars
    
    //    MARK:- VC's life Cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func_Set_Gradient_Color()
        func_Set_Design()
        
//        view_Upper.isHidden = true
        
        if Model_SignUp.shared.userType == "2" {
            btn_Back.isHidden = true
            btn_Plus.isHidden = true
        } else {
            btn_Back.isHidden = false
            btn_Plus.isHidden = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK:- IBActions
    @IBAction func btn_Plus(_ sender:UIButton) {
        if Model_SignUp.shared.userType == "1" {
            let storyBoard = UIStoryboard (name: "Trainer", bundle: nil)
            let schedule_Workout_VC = storyBoard.instantiateViewController(withIdentifier: "Schedule_Workout_ViewController")
            present(schedule_Workout_VC, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_Back(_ sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //    MARK:- Custom functions
    
    //    MARK:- Finish
}
