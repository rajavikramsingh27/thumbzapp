//
//  Activity_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 18/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit
import FSCalendar


class Activity_ViewController: UIViewController {
    //    MARK:- IBOutlets
        @IBOutlet weak var collection_View:UICollectionView!
    
        @IBOutlet weak var calender: FSCalendar!
        @IBOutlet weak var tbl_exercise:UITableView!
        
        @IBOutlet weak var btn_Day:UIButton!
        @IBOutlet weak var btn_Plus:UIButton!

        var arr_exercise = [Model_Activity]()

    //    MARK:- vars
            
    //    MARK:- VC's life Cycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scope: FSCalendarScope = .week
        self.calender.setScope(scope, animated: true)
        
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd MMM yyy"
        Model_Activity.shared.str_date = dateformatter.string(from: date)
        Model_Shared_trainer.shared.str_date = date
        
        func_Set_Design()
        func_get_exercise_list()
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_refresh_on_notification), name: Notification.Name("Workout Complete"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK:- IBActions
    @IBAction func btn_Back(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //    MARK:- Custom functions
    @objc func func_TapGesture() {
//        view_Shadow.isHidden = true
    }
    
    @objc func func_refresh_on_notification()  {
       func_get_exercise_list()
    }
    

    
    //    MARK:- Finish
}
