//
//  Choose_Client_ViewController.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 18/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit
import SVProgressHUD



class Choose_Client_ViewController: UIViewController {
    //    MARK:- IBOutlets
        @IBOutlet weak var btn_Search:UIButton!
        @IBOutlet weak var collectionView: UICollectionView!
        @IBOutlet weak var trainerName: UILabel!
    
        @IBOutlet weak var view_search: UIView!
        @IBOutlet weak var txt_search:UITextField!
    
    
    //    MARK:- vars
        var checkboxImagev = [String]()
        var arrayList = [[String:Any]]()
        var return_Response = [[String:Any]]()
        var boolIsFilterd = false

    //    MARK:- VC's life Cycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        
        txt_search.layer.cornerRadius = 20
        txt_search.layer.borderWidth = 1
        txt_search.layer.borderColor = UIColor .lightGray.cgColor
        txt_search.clipsToBounds = true
        
        view_search.isHidden = true
        btn_Search.setImage(UIImage (named: "search"), for: .normal)

        getAllClients()
        func_Set_Design()
        
        trainerName.text = ThumbzappUserDefaults.sharedInstance.user_name
    }
    
//    MARK:- IBActions
    @IBAction func btn_Back(_ sender:Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //    MARK:- Custom functions
    
    //    MARK:- Finish
}
