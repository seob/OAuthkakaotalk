//
//  AppDelegate.swift
//  OAuthexample
//
//  Created by seob on 2018. 7. 26..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initalizeApp()
        return true
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        KOSession.handleDidEnterBackground()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }
    
    func application(_ app: UIApplication, open url: URL, options:
        [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return false
    }
    
    private func initalizeApp() {
        setupSessionChangedNotification()
        setupRootViewController()
    }
    
    private func setupSessionChangedNotification () {
        NotificationCenter.default.addObserver(forName: Notification.Name.KOSessionDidChange, object: nil, queue: .main) { [unowned self] (noti) in
            guard let session = noti.object as? KOSession else { return }
            session.isOpen() ? print("Login") : print("Logout")
            self.setupRootViewController()
        }
    }
    
    func setupRootViewController() {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = stroyboard.instantiateInitialViewController() as! UINavigationController
        
        let storyboardID = KOSession.shared().isOpen() ? "MainViewController" : "LoginViewController"
        let vc = stroyboard.instantiateViewController(withIdentifier: storyboardID)
        navigationController.viewControllers = [vc]
        window?.rootViewController = navigationController
        
    }
}
