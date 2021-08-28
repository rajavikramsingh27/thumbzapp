//
//  Full_Image_Trainer_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 16/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit
import SDWebImage


class Full_Image_Trainer_ViewController: UIViewController {
    //    MARK:- IBOutlets
            @IBOutlet weak var img_exercise:UIImageView!
    //    MARK:- vars
    
    //    MARK:- VC's life Cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.img_exercise.downloadedFrom(link: Model_Shared_trainer.shared.shared_file)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK:- IBActions
    @IBAction func btn_Done(_ sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //    MARK:- Custom functions
    
    //    MARK:- Finish
}
