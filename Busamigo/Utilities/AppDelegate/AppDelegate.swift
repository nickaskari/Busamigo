//
//  AppDelegate.swift
//  Busamigo
//
//  Created by Nick Askari on 13/04/2022.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseMessaging
import UserNotifications
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
        
    static var orientationLock = UIInterfaceOrientationMask.all
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
            FirebaseApp.configure()
            Messaging.messaging().delegate = self
            GADMobileAds.sharedInstance().start(completionHandler: nil)

           if #available(iOS 10.0, *) {
             // For iOS 10 display notification (sent via APNS)
             UNUserNotificationCenter.current().delegate = self

             let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
             UNUserNotificationCenter.current().requestAuthorization(
               options: authOptions,
               completionHandler: {_, _ in })
           } else {
             let settings: UIUserNotificationSettings =
             UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
             application.registerUserNotificationSettings(settings)
           }

           application.registerForRemoteNotifications()
           return true
       }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Did Register For Remote Notifications With Device Token")
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications")
        print(error.localizedDescription)
    }
}
