//
//  ext UNC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 17.12.2022.
//

import UIKit

extension SettingsScreenVC: UNUserNotificationCenterDelegate {
    
    func showiPhoneSetups() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }
    
    func startWorkSwitch() {
        DispatchQueue.main.async {
            if self.settingsScreen.startWorkSwitch.isOn {
                UserDefaults.standard.set(true, forKey: "notificationStartWorkTolerance")
                self.notificationStartWorkTime()
            } else {
                UserDefaults.standard.set(false, forKey: "notificationStartWorkTolerance")
                self.cancelStartWorkNotification()
            }
        }
    }
    
    func workSwitch() {
        DispatchQueue.main.async {
            if self.settingsScreen.workSwitch.isOn {
                UserDefaults.standard.set(true, forKey: "notificationWorkTolerance")
            } else {
                UserDefaults.standard.set(false, forKey: "notificationWorkTolerance")
            }
        }
    }
    
    func breakSwitch() {
        DispatchQueue.main.async {
            if self.settingsScreen.breakSwitch.isOn {
                UserDefaults.standard.set(true, forKey: "notificationBreakTolerance")
            } else {
                UserDefaults.standard.set(false, forKey: "notificationBreakTolerance")
            }
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
    
    
//    MARK: - Уведомление о времени работы
    
    func notificationStartWorkTime() {
        if UserDefaults.standard.bool(forKey: "notificationStartWorkTolerance") {
            let content: UNMutableNotificationContent = {
                let content = UNMutableNotificationContent()
                content.title = "SeTime"
                content.body = NSLocalizedString("startWorkTime", comment: "")
                content.sound = UNNotificationSound.default
                content.badge = 1
                return content
            }()
            
            var date = DateComponents()
            date.calendar = Calendar.current
            let time = UserDefaults.standard.integer(forKey: "startTimeNotice")
            date.hour = time / 3600
            date.minute = time / 60 % 60
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            
            let startWorkTimeRequest = UNNotificationRequest(identifier: "Start work notification",
                                                             content: content,
                                                             trigger: trigger)
            UNUserNotificationCenter.current().add(startWorkTimeRequest)
        }
    }
    
    func cancelStartWorkNotification() {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Start work notification"])
        }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
