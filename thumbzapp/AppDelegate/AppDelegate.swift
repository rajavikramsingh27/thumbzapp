//
//  AppDelegate.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 11/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseMessaging
import Firebase
import UserNotifications
import FirebaseInstanceID
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    let requestIdentifier = "SampleRequest"
    var window: UIWindow?
//    let d_T = UserDefaults.standard.object(forKey: "device_token")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GIDSignIn.sharedInstance().clientID = "746202406410-rmgh3vv2bghjadcdlkp3fg2f6ed2opue.apps.googleusercontent.com"
        
        askForNotificationPermission(application)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: NSNotification.Name.InstanceIDTokenRefresh,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(self.fcmConnectionStateChange), name:
            NSNotification.Name.MessagingConnectionStateChanged, object: nil)
        
        let mtoken = InstanceID.instanceID().token()
        
        print("FCM token: \(mtoken ?? "")")
        
        let token = Messaging.messaging().fcmToken
        
        print("FCM token: \(token ?? "")")

        if let is_RemeberMe = UserDefaults.standard.object(forKey: "rememberMe") as? Bool {
            if is_RemeberMe {
                if let str_User_Type = ThumbzappUserDefaults.sharedInstance.user_type as? String {
                    if !(str_User_Type.isEmpty) {
                        Model_SignUp.shared.userType = str_User_Type
                        if str_User_Type == "2" {
                            let storyboard = UIStoryboard (name: "Main", bundle: nil)
                            let request_VC = storyboard.instantiateViewController(withIdentifier: "tabbar")
                            self.window?.rootViewController = request_VC
                            self.window!.makeKeyAndVisible()
                        } else {
                            let storyboard = UIStoryboard (name: "Trainer", bundle: nil)
                            let request_VC = storyboard.instantiateViewController(withIdentifier: "myClientsVC") as! myClientsVC
                            self.window?.rootViewController = request_VC
                            self.window!.makeKeyAndVisible()
                        }
                    }
                }
            }
        }
        
        return true
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let fbHandler : Bool = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url as URL?,
                                                                sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                                annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        return fbHandler || googleDidHandle
    }
    

    //    MARK: notification
    
    func openNotificationInSettings() {
        let alertController = UIAlertController(title: "Notification Alert", message: "Please enable Notification from Settings to never miss a text.", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    })
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        DispatchQueue.main.async {
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func askForNotificationPermission(_ application: UIApplication) {
        let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
        if !isRegisteredForRemoteNotifications {
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                    (granted, error) in
                    if error == nil {
                        if !granted {
                            self.openNotificationInSettings()
                        } else {
                            UNUserNotificationCenter.current().delegate = self
                        }
                    }
                }
            } else {
                // Fallback on earlier versions
                let settings: UIUserNotificationSettings =
                    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
            }
        } else {
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().delegate = self
            } else {
                // Fallback on earlier versions
            }
        }
        
        application.registerForRemoteNotifications()
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        } else {
            application.cancelAllLocalNotifications()
        }
        
    }
    
    
    @objc func fcmConnectionStateChange() {
        if Messaging.messaging().isDirectChannelEstablished {
            
            print("Connected to FCM.")
            
        } else {
            
            print("Disconnected from FCM.")
            
        }
    }
    
    func connectFcm(){
        
        guard InstanceID.instanceID().token() != nil else {
            return;
        }
        
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        
        print("Firebase registration token: \(fcmToken)")
        
        UserDefaults.standard.set("\(fcmToken)", forKey: "deviceToken")
        
        UserDefaults.standard.set("\(fcmToken)", forKey: "device_token")

        
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        
        
        Messaging.messaging().apnsToken = deviceToken
        
        let deviceTokenString = deviceToken.reduce("") { $0 + String(format: "%02X", $1) }
        
        print("APNs device token: \(deviceTokenString)")
        UserDefaults.standard.set("\(deviceTokenString)", forKey: "deviceToken")
        //        UserDefaults.standard.set("\(deviceTokenString)", forKey: "device_token")
        
    }
    
    @objc func tokenRefreshNotification(_ notification: Notification) {
        
        if let refreshedToken = InstanceID.instanceID().token() {
            
            print("InstanceID !token: \(refreshedToken)")
            UserDefaults.standard.set("\(refreshedToken)", forKey: "device_token")
            
        }
        
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print(error)
        
        print("InstanceID token: \(error)")
        
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        
        
        print("Firebase registration token: \(fcmToken)")
        
        UserDefaults.standard.set("\(fcmToken)", forKey: "FCM")
    }
    
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        
        Messaging.messaging().apnsToken = deviceToken as Data
        
        
    }
    
    var applicationStateString: String {
        if UIApplication.shared.applicationState == .active {
            
            return "active"
            
        } else if UIApplication.shared.applicationState == .background {
            
            return "background"
            
        }else {
            
            return "inactive"
        }
    }
    
    
    
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}
    @available(iOS 10, *)
    
    
    
    extension AppDelegate : UNUserNotificationCenterDelegate {
        
        // Receive displayed notifications for iOS 10 devices.
        
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .badge, .sound])
            
            print(notification.request.content.userInfo)
            
            if notification.request.identifier == requestIdentifier{
                
                completionHandler( [.alert,.sound,.badge])
                
                print(notification.request.content.userInfo)
                
                
                
            }else{
                let userInfo = notification.request.content.userInfo
                let hj = userInfo as NSDictionary
                
                print(hj)
                
                let requestName = hj["aps"] as! [String:Any]
                let title = requestName["alert"] as! [String:Any]
                let requstTitle = title["title"] as! String
                print(requstTitle)
                
                if requstTitle == "chat" {
                        NotificationCenter.default.post(name: Notification.Name("chat"), object: nil)
                } else if requstTitle == "Workout Complete" {
                    NotificationCenter.default.post(name: Notification.Name("Workout Complete"), object: nil)
                } else if requstTitle == "chat" {
                    NotificationCenter.default.post(name: Notification.Name("chat"), object: nil)
                } else if requstTitle == "chat" {
                    NotificationCenter.default.post(name: Notification.Name("chat"), object: nil)
                }
                
            }
            
        }
        
        
        @available(iOS 10, *)
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            
            let userInfo = response.notification.request.content.userInfo
            
            let hj = userInfo as NSDictionary
            
            print(hj)
            
            let requestName = hj["aps"] as! [String:Any]
            
            let title = requestName["alert"] as! [String:Any]
            
            let requstTitle = title["title"] as! String
            
           
            
        }
        
    }
    extension AppDelegate : MessagingDelegate {
        
        func application(received remoteMessage: MessagingRemoteMessage) {
            
            print("Media Message %@", remoteMessage.appData)
            
        }
        
        func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
            
            
            if UIApplication.shared.applicationState == .active {
                
                print("foreFround")
                
            }else{
                
                
            }
        }
        
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {

            print("[RemoteNotification] applicationState: \(applicationStateString) didReceiveRemoteNotification for iOS9: \(userInfo)")
            
            if UIApplication.shared.applicationState == .active {
                let hj = userInfo as NSDictionary
                print(hj)
            }else{
                let hj = userInfo as NSDictionary
                print(hj)
            }
        }
}










