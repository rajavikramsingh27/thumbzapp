//
//  myClientsVC.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 02/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//



import UIKit
import SVProgressHUD

class myClientsVC: UIViewController {
    
    @IBOutlet weak var btn_Search:UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var trainerName: UILabel!
    
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var txt_search:UITextField!

    @IBOutlet weak var lbl_Add_Your_Client_First: UILabel!

    
    //    MARK:- vars
    var arrayList = [[String:Any]]()
    var return_Response = [[String:Any]]()
    var boolIsFilterd = false
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Model_chat.shared.str_user_id = ThumbzappUserDefaults.sharedInstance.userId
        Model_chat.shared.str_current_user_image = ThumbzappUserDefaults.sharedInstance.user_image
        
        func_Set_Design()
        
        lbl_Add_Your_Client_First.isHidden = true
        lbl_Add_Your_Client_First.text = "Hey \(ThumbzappUserDefaults.sharedInstance.user_name) Kindly add your clients first!"
        trainerName.text = ThumbzappUserDefaults.sharedInstance.user_name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txt_search.layer.cornerRadius = 20
        txt_search.layer.borderWidth = 1
        txt_search.layer.borderColor = UIColor .lightGray.cgColor
        txt_search.clipsToBounds = true
        
        view_search.isHidden=true
        btn_Search.setImage(UIImage (named: "search"), for: .normal)
        
        Get_All_Selected_Clients()
    }

    func func_Set_Design() {
        btn_Search.layer.cornerRadius = btn_Search.frame.size.height/2
        btn_Search.clipsToBounds = true
    }
    
    func Get_All_Selected_Clients() {
        func_ShowHud()

        APIFunc.postAPI(url: GET_TRAINER_CLIENT, parameters: ["trainer_id":ThumbzappUserDefaults.sharedInstance.userId]) { (response) in
            
            model_trainer_clients.shared.client_device_token = [String]()
            model_trainer_clients.shared.client_device_type = [String]()
            model_trainer_clients.shared.client_email = [String]()
            model_trainer_clients.shared.client_id = [String]()
            model_trainer_clients.shared.client_name = [String]()
            model_trainer_clients.shared.client_password = [String]()
            model_trainer_clients.shared.client_profile = [String]()
            model_trainer_clients.shared.client_social = [String]()
            model_trainer_clients.shared.client_status = [String]()
            model_trainer_clients.shared.trainer_id = [String]()
            
            let status = "\(response["status"]!)"
            if status == "success" {
                let result : NSArray = response["result"] as! NSArray
                self.arrayList = result as! [[String : Any]]
                self.lbl_Add_Your_Client_First.isHidden = false
                
                for i in 0..<result.count{
                    self.lbl_Add_Your_Client_First.isHidden = true
                    
                    let dict : NSDictionary = result[i] as! NSDictionary
                    
                    model_trainer_clients.shared.client_device_token.append("\(dict["client_device_token"]!)")
                    model_trainer_clients.shared.client_device_type.append("\(dict["client_device_type"]!)")
                    model_trainer_clients.shared.client_email.append("\(dict["client_email"]!)")
                    model_trainer_clients.shared.client_id.append("\(dict["client_id"]!)")
                    model_trainer_clients.shared.client_name.append("\(dict["client_name"]!)")
                    model_trainer_clients.shared.client_password.append("\(dict["client_password"]!)")
                    model_trainer_clients.shared.client_profile.append("\(dict["client_profile"]!)")
                    model_trainer_clients.shared.client_social.append("\(dict["client_social"]!)")
                    model_trainer_clients.shared.client_status.append("\(dict["client_status"]!)")
                    model_trainer_clients.shared.trainer_id.append("\(dict["trainer_id"]!)")
                }
                self.func_HideHud()
                self.collectionView.reloadData()
            } else {
                self.collectionView.reloadData()
                self.func_ShowHude_Error(with:"No client found")
            }
        }
//        SVProgressHUD.dismiss()
         self.func_HideHud()
    }
    
    @IBAction func select_Client_Button(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Choose_Client_ViewController")
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func btn_LogOut (_ sender:UIButton) {
        
        let alertController = UIAlertController(title: "", message: "Do you want to logout ?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: { (alert) in
            
        }))
        alertController.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: { (alert) in
            
            ThumbzappUserDefaults.sharedInstance.user_type = ""
            ThumbzappUserDefaults.sharedInstance.retriveUserFromUserDefaults()
            
            let storyboard = UIStoryboard (name: "Main", bundle: nil)
            let sign_In_VC = storyboard.instantiateViewController(withIdentifier: "Sign_In_ViewController")
            self.present(sign_In_VC, animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
}




//  MARK:- UICollectionView methods
extension myClientsVC:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width:collectionView.frame.size.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model_trainer_clients.shared.client_id.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell_Choose_Client = collectionView.dequeueReusableCell(withReuseIdentifier: "myClientCellCollectionViewCell", for: indexPath) as! myClientCellCollectionViewCell
        
        cell_Choose_Client.view_Client.layer.cornerRadius = 2
        cell_Choose_Client.view_Client.layer.shadowOpacity = 1.0
        cell_Choose_Client.view_Client.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell_Choose_Client.view_Client.layer.shadowRadius = 3.0
        cell_Choose_Client.view_Client.layer.shadowColor = UIColor .lightGray.cgColor
        
        cell_Choose_Client.lbl_blue_red.layer.cornerRadius = cell_Choose_Client.lbl_blue_red.frame.size.height/2
        cell_Choose_Client.lbl_blue_red.clipsToBounds = true
        
        cell_Choose_Client.image.layer.cornerRadius = cell_Choose_Client.image.frame.size.height/2
        cell_Choose_Client.image.clipsToBounds = true
        cell_Choose_Client.image.downloadedFrom(link: model_trainer_clients.shared.client_profile[indexPath.row])
        cell_Choose_Client.name.text = model_trainer_clients.shared.client_name[indexPath.row]
        
        return cell_Choose_Client
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Model_Schedule_Workout.shared.str_client_id = model_trainer_clients.shared.client_id[indexPath.row]

        Model_chat.shared.str_fri_id = Model_Schedule_Workout.shared.str_client_id

        UserDefaults.standard.set(model_trainer_clients.shared.client_name[indexPath.row], forKey: "trainer_name")
        UserDefaults.standard.set(model_trainer_clients.shared.client_profile[indexPath.row], forKey: "trainer_profile")
        
        let activityViewController = self.storyboard?.instantiateViewController(withIdentifier: "Activity_ViewController")
        self.present(activityViewController!, animated: true, completion: nil)
    }

}
