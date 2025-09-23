//
//  AppDelegate.swift
//  PuHaHang
//
//  Created by 디해 on 7/14/25.
//

import ComposableArchitecture
import Foundation
import Firebase
import Login
import UIKit
import UserNotifications
import FacebookCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        return true
    }
}

extension AppDelegate {
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.shared.activateApp()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner])
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        guard let token = fcmToken else { return }
        
        Task {
            @Dependency(\.loginManager) var loginManager
            guard let userToken = loginManager.loadLocalToken() else { return }
            try await loginManager.update(fcmToken: token, for: userToken)
        }
    }
}
