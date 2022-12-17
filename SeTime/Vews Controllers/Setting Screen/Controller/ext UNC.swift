//
//  ext UNC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 17.12.2022.
//

import UIKit

extension SettingsScreenVC {
        
    func showiPhoneSetups() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    
    func workSwitch() {
        if self.settingsScreen.workSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "notificationWorkTolerance")
        } else {
            UserDefaults.standard.set(false, forKey: "notificationWorkTolerance")
        }
    }
    
    func breakSwitch() {
        if settingsScreen.breakSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "notificationBreakTolerance")
        } else {
            UserDefaults.standard.set(false, forKey: "notificationBreakTolerance")
        }
    }
    
    func allowNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            guard granted else { return }
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
    }
}
