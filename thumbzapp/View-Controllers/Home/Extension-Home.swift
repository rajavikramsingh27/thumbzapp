//
//  Extension-Home.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 20/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit
import AVKit

extension Home_ViewController :UITableViewDelegate,UITableViewDataSource {
    
    func func_Set_Design() {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if arr_shared_videos.count > 0 {
                return 400
            } else {
                return 150
            }
        } else if indexPath.row == 1 {
            return 49
        } else {
            return 91
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model_Home.shared.arr_exercise.count+2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell_SharedVideo = tableView.dequeueReusableCell(withIdentifier: "cell_SharedVideo", for:indexPath) as! Home_TableViewCell
            
            if self.arr_shared_videos.count > 0 {
                cell_SharedVideo.lbl_videos_shared.text = "Videos Shared by Coach"
            } else {
                cell_SharedVideo.lbl_videos_shared.text = "Welcome"
            }
            
            cell_SharedVideo.img_user.downloadedFrom(link:ThumbzappUserDefaults.sharedInstance.user_image)
            
            if arr_shared_videos.count == 0 {
                cell_SharedVideo.coll_Home.isHidden = true
            } else {
                cell_SharedVideo.coll_Home.isHidden = false
            }
            
            cell_SharedVideo.coll_Home.reloadData()
            
            return cell_SharedVideo
        } else if indexPath.row == 1 {
            let cell_Workout_Header = tableView.dequeueReusableCell(withIdentifier: "cell_Workout_Header", for:indexPath)
            
            let lbl_workouts = cell_Workout_Header.viewWithTag(1) as! UILabel
            
            
            if Model_Home.shared.arr_exercise.count == 0 {
                lbl_workouts.text = "No new workouts"
            } else {
                lbl_workouts.text = "New Wokouts"
            }
            
            return cell_Workout_Header
        } else {
            let cell_WorkoutList = tableView.dequeueReusableCell(withIdentifier: "cell_WorkoutList", for:indexPath) as! WorkoutList_TableViewCell
            
            let model = Model_Home.shared.arr_exercise[indexPath.row-2]
            cell_WorkoutList.lbl_exercise_name.text = model.str_exercise
            cell_WorkoutList.lbl_date.text = model.str_date
            
            return cell_WorkoutList
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row > 0 {
            let model = Model_Home.shared.arr_exercise[indexPath.row-2]
            Model_Schedule_Workout.shared.str_workout_date = model.str_date
            
            let storyBoard = UIStoryboard (name: "Main", bundle: nil)
            let excersize_List_VC = storyBoard.instantiateViewController(withIdentifier: "Excersize_List_ViewController") as! Excersize_List_ViewController
            present(excersize_List_VC, animated: true, completion: nil)
        }
    }
}



//  MARK:- UICollectionView methods
extension Home_ViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionviewwidth = collectionView.frame.size.width 
        
        return CGSize (width: collectionviewwidth, height: 235)
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_shared_videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell_Home = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_Home", for: indexPath) as! Home_CollectionViewCell
        
        cell_Home.img_Profile.layer.cornerRadius = 10
        cell_Home.img_Profile.clipsToBounds = true
        
        return cell_Home
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = arr_shared_videos[indexPath.row]
        Model_Shared_trainer.shared.shared_file = model.shared_file
        
        func_Video()
    }
    
    func func_Video() {
        let url = URL(string: Model_Shared_trainer.shared.shared_file)
        let player = AVPlayer(url: url!)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            playerController.player?.play()
        }
    }

}
