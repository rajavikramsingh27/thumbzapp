//
//  CV_Calender_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 22/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit
//import CVCalendarView
import FSCalendar

class FS_Calender_ViewController: UIViewController  {
    
    
    @IBOutlet weak var cal : FSCalendar!
    
    override func viewDidLoad() {
        let scope: FSCalendarScope = .week
        self.cal.setScope(scope, animated: true)
        

        
    }
    
}
