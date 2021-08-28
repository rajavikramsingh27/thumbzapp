//
//  Extension-Choose_Client.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 18/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD



extension Choose_Client_ViewController {
    func func_Set_Design() {
        btn_Search.layer.cornerRadius = btn_Search.frame.size.height/2
        btn_Search.clipsToBounds = true
    }
    
    func getAllClients() {
        checkboxImagev = [String]()
        model_Client_All.shared.client_device_token = [String]()
        model_Client_All.shared.client_device_type = [String]()
        model_Client_All.shared.client_email = [String]()
        model_Client_All.shared.client_id = [String]()
        model_Client_All.shared.client_name = [String]()
        model_Client_All.shared.client_password = [String]()
        model_Client_All.shared.client_profile = [String]()
        model_Client_All.shared.client_social = [String]()
        model_Client_All.shared.client_status = [String]()
        model_Client_All.shared.trainer_id = [String]()

        APIFunc.getAPI(url: ALL_CLIENT_GET, parameters: ["":""]) { (response) in
            let status = "\(response["status"]!)"
            if status == "success" {
                let result : NSArray = response["result"] as! NSArray
                self.arrayList = result as! [[String:Any]]
                print(self.arrayList)
                
                for i in 0..<result.count {
                    let dict : NSDictionary = result[i] as! NSDictionary
                    
                    model_trainer_clients.shared.client_device_token.append("\(dict["client_device_token"]!)")
                    model_trainer_clients.shared.client_device_type.append("\(dict["client_device_type"]!)")
                    model_Client_All.shared.client_email.append("\(dict["client_email"]!)")
                    model_Client_All.shared.client_id.append("\(dict["client_id"]!)")
                    model_Client_All.shared.client_name.append("\(dict["client_name"]!)")
                    model_Client_All.shared.client_password.append("\(dict["client_password"]!)")
                    model_Client_All.shared.client_profile.append("\(dict["client_profile"]!)")
                    model_Client_All.shared.client_social.append("\(dict["client_social"]!)")
                    model_Client_All.shared.client_status.append("\(dict["client_status"]!)")
                    model_Client_All.shared.trainer_id.append("\(dict["trainer_id"]!)")
                    
                    var yes = false
                    for j in 0..<model_trainer_clients.shared.client_id.count{
                        if model_Client_All.shared.client_id[i] != model_trainer_clients.shared.client_id[j]{
                            yes = false
                        } else {
                            self.checkboxImagev.append("success.png")
                            yes = true
                            break
                        }
                    }
                    
                    if yes{
                        yes = false
                    }
                    else{
                        yes = true
                        self.checkboxImagev.append("oval.png")
                    }
                    
                    if model_trainer_clients.shared.client_id.count == 0{
                         self.checkboxImagev.append("oval.png")
                    }
                        
                }
               
                SVProgressHUD.dismiss()
                self.collectionView.reloadData()
            }
            else{

               SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus: "Error In Fetching Clients")
                self.collectionView.reloadData()

            }
            
        }
    }
    
}


//  MARK:- UICollectionView methods
extension Choose_Client_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width:collectionView.frame.size.width/2-3, height: 266)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model_Client_All.shared.client_id.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell_Choose_Client = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_Choose_Client", for: indexPath) as! Choose_Client_CollectionViewCell
        
        cell_Choose_Client.img_Client.layer.cornerRadius = cell_Choose_Client.img_Client.frame.size.height/2
        cell_Choose_Client.img_Client.clipsToBounds = true
        cell_Choose_Client.img_Client.downloadedFrom(link: model_Client_All.shared.client_profile[indexPath.row])
        cell_Choose_Client.checkBoxImage.tag = indexPath.row
        cell_Choose_Client.checkBoxImage.image = UIImage(named: checkboxImagev[indexPath.row])
        cell_Choose_Client.NAME.text = model_Client_All.shared.client_name[indexPath.row]
        return cell_Choose_Client
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.checkboxImagev[indexPath.row] == "oval.png"{
            self.checkboxImagev[indexPath.row] = "success.png"
            add_Client(clientID: model_Client_All.shared.client_id[indexPath.row])

        }
        else if self.checkboxImagev[indexPath.row] == "success.png"{
            self.checkboxImagev[indexPath.row] = "oval.png"
            remove_Client(clientID: model_Client_All.shared.client_id[indexPath.row])
        }
        
//        if cell_Choose_Client.checkBoxImage.tag == indexPath.row{
////            if cell_Choose_Client.checkBoxImage.
//        }
//        if cell_Choose_Client
        
        
//        let activityViewController = self.storyboard?.instantiateViewController(withIdentifier: "Activity_ViewController")
//        self.present(activityViewController!, animated: true, completion: nil)
    }
    
    /*
     1=add,2=remove
     type:1
     trainer_id:4
     client_id:19
     */
    func add_Client(clientID : String){
        SVProgressHUD.show()
        let param : [String:Any] = ["type":"1","trainer_id":ThumbzappUserDefaults.sharedInstance.userId,"client_id":clientID]
        APIFunc.postAPI(url: SELECT_CLIENT, parameters: param) { (response) in
            let status = "\(response["status"]!)"
            if status == "success"{
                SVProgressHUD.dismiss()
                self.collectionView.reloadData()
                SVProgressHUD.showSuccess(withStatus: "Added Client Successfully")
            }
            else{
                SVProgressHUD.dismiss()
                self.collectionView.reloadData()
                SVProgressHUD.showError(withStatus: "Error In Adding Client")
            }
        }
    }
    
    func remove_Client(clientID : String){
        SVProgressHUD.show()
        let param : [String:Any] = ["type":"2","trainer_id":ThumbzappUserDefaults.sharedInstance.userId,"client_id":clientID]
        APIFunc.postAPI(url: SELECT_CLIENT, parameters: param) { (response) in
            let status = "\(response["status"]!)"
            if status == "success"{
                SVProgressHUD.dismiss()
                self.collectionView.reloadData()
                SVProgressHUD.showSuccess(withStatus: "Removed Client Successfully")
            }
            else{
                SVProgressHUD.dismiss()
                self.collectionView.reloadData()
                SVProgressHUD.showError(withStatus: "Error In removing Client")
            }
        }
    }
    
}


extension Choose_Client_ViewController {
    @IBAction func btn_search (_ sender:UIButton) {
        if sender.tag == 1 {
            sender.tag = 2
            view_search.isHidden = false
            txt_search.becomeFirstResponder()
            btn_Search.setImage(UIImage (named: "cancel"), for: .normal)
        } else {
            sender.tag = 1
            view_search.isHidden = true
            self.view.endEditing(true)
            btn_Search.setImage(UIImage (named: "search"), for: .normal)
            func_search_result(arr_search: arrayList)
        }
    }
    
    @IBAction func txt_Search(_ sender: UITextField) {
        return_Response = [[String:Any]]()
        for i in 0..<arrayList.count
        {
            let dict = arrayList[i]
            let target = dict["client_name"] as? String
            if ((target as NSString?)?.range(of:txt_search.text!, options: .caseInsensitive))?.location == NSNotFound
            {
                boolIsFilterd=true
            } else {
                return_Response.append(dict)
            }
        }
        
        if (txt_search.text! == "")
        {
            return_Response = arrayList
            boolIsFilterd=false
        }
        func_search_result(arr_search: return_Response)
    }
    
    func func_search_result(arr_search : [[String:Any]]) {
        model_Client_All.shared.client_device_token = [String]()
        model_Client_All.shared.client_device_type = [String]()
        model_Client_All.shared.client_email = [String]()
        model_Client_All.shared.client_id = [String]()
        model_Client_All.shared.client_name = [String]()
        model_Client_All.shared.client_password = [String]()
        model_Client_All.shared.client_profile = [String]()
        model_Client_All.shared.client_social = [String]()
        model_Client_All.shared.client_status = [String]()
        model_Client_All.shared.trainer_id = [String]()
        
        for i in 0..<arr_search.count {
            let dict : NSDictionary = arr_search[i] as NSDictionary
            
            model_Client_All.shared.client_device_token.append("\(dict["device_token"]!)")
            model_Client_All.shared.client_device_type.append("\(dict["device_type"]!)")
            model_Client_All.shared.client_email.append("\(dict["client_email"]!)")
            model_Client_All.shared.client_id.append("\(dict["client_id"]!)")
            model_Client_All.shared.client_name.append("\(dict["client_name"]!)")
            model_Client_All.shared.client_password.append("\(dict["client_password"]!)")
            model_Client_All.shared.client_profile.append("\(dict["client_profile"]!)")
            model_Client_All.shared.client_social.append("\(dict["client_social"]!)")
            model_Client_All.shared.client_status.append("\(dict["client_status"]!)")
            model_Client_All.shared.trainer_id.append("\(dict["trainer_id"]!)")
            
            var yes = false
            for j in 0..<model_trainer_clients.shared.client_id.count{
                if model_Client_All.shared.client_id[i] != model_trainer_clients.shared.client_id[j]{
                    yes = false
                } else {
                    self.checkboxImagev.append("success.png")
                    yes = true
                    
                    break
                }
            }
            
            if yes{
                yes = false
            }
            else{
                yes = true
                self.checkboxImagev.append("oval.png")
            }
            
            if model_trainer_clients.shared.client_id.count == 0{
                self.checkboxImagev.append("oval.png")
            }
            
        }
        
        collectionView.reloadData()
    }
    
}



