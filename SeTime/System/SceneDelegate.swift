//
//  SceneDelegate.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = TabBarController()
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Останавливает все таймеры
        NotificationCenter.default.post(name: NotifiCenter.notificationSceneDidDisconnect, object: nil)
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        NotificationCenter.default.post(name: NotifiCenter.notificationCheckDay, object: nil)
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
