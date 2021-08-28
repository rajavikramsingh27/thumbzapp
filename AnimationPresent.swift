//
//  AnimationPresent.swift
//  Freeceive
//
//  Created by Amar Sharma on 05/02/18.
//  Copyright © 2018 Appiqo. All rights reserved.
//

import UIKit

class AnimationPresent: UIViewController,UIViewControllerTransitioningDelegate {
    
    let transition = CircularTransition()
    
    public var centerPoint:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = centerPoint
        transition.circleColor = UIColor.clear
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = centerPoint
        transition.circleColor = UIColor.clear
        
        return transition
    }
  
    
    func alertLocal(alertTitle:String,maessageTitle:String ,yesTitle:String, noTitle:String, yesFunction: @escaping (_ alert: UIAlertController) -> (), noFunction: @escaping (_ alert: UIAlertController) -> ()){
    
    
        let alert = UIAlertController(title: "\(alertTitle)", message: "\(maessageTitle)", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "\(yesTitle)", style: .default, handler: {(action:UIAlertAction!) in
            
            yesFunction(alert)
           
            
        })
        
        let noAction = UIAlertAction(title: "\(noTitle)", style: .default, handler: {(action:UIAlertAction!) in
            
           noFunction(alert)
            
            
        })
        
        alert.view.tintColor = UIColor.green
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        self.present(alert, animated: true, completion: nil)
    
    
    }
    
    
    func viewPresent(centerPoint:CGPoint,storyBoard:String,viewId:String){
    
    
        self.centerPoint = centerPoint
        let storyboard = UIStoryboard(name: "\(storyBoard)", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "\(viewId)")
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true, completion: nil)
    
    
    
    }
    
    

}
