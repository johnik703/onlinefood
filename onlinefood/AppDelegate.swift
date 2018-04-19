//
//  AppDelegate.swift
//  onlinefood
//
//  Created by John Nik on 18/04/2018.
//  Copyright © 2018 John Nik. All rights reserved.
//

import UIKit
import SVProgressHUD
import OneSignal
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    var notificationReceivedBlock: OSHandleNotificationReceivedBlock?
    var notificationOpenedBlock: OSHandleNotificationActionBlock?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setNavBar()
        setupSVProgressHUD()
        ReachabilityManager.setup()
        self.launchOptions = launchOptions
        self.setupOneSignal(launchOptions: launchOptions)
        setupInitialController()
        
        application.statusBarStyle = .lightContent
        
        
        return true
    }


}

extension AppDelegate {
    
    fileprivate func setupOneSignal(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "738bc245-0457-4e93-8df5-b3829cff9551",
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
    
}

extension AppDelegate {
    
    fileprivate func setupSVProgressHUD() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.gradient)
    }
    
    fileprivate func setNavBar() {
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor.defaultColor
        }
        
        UINavigationBar.appearance().barTintColor = UIColor.defaultColor
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .medium)]
    }
    
    fileprivate func setupInitialController() {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        let _ = UINavigationController(rootViewController: HomeController())
        window?.rootViewController = HomeController()
    }
}
