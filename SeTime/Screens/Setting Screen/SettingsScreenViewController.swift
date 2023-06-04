//
//  SettingsScreenViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 03.12.2022.
//

import UIKit
import UserNotifications

final class SettingsScreenVC: UIViewController {
    // MARK: - Экземпляр SettingScreen
    
    lazy var settingsScreen: SettingsScreen = {
        var view = SettingsScreen()
        view.delegate = self
        view.startWorkTimeDatePicker.date = timeToDate(time: UserDefaults.standard.integer(forKey: "startTimeNotice"))
        view.startWorkTimeDataLabel.text = timeIntToStringShort(time: UserDefaults.standard.integer(forKey: "startTimeNotice"))
        view.workDatePicker.date = timeToDate(time: UserDefaults.standard.integer(forKey: "workTimeToNotice"))
        view.workTimeDataLabel.text = timeIntToStringShort(time: UserDefaults.standard.integer(forKey: "workTimeToNotice"))
        view.breakDatePicker.date = timeToDate(time: UserDefaults.standard.integer(forKey: "breakTimeToNotice"))
        view.breakTimeDataLabel.text = timeIntToStringShort(time: UserDefaults.standard.integer(forKey: "breakTimeToNotice"))
        return view
    }()
    
    
    // MARK: - Lifecykle
    
    override func loadView() {
        view = settingsScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allowNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateTimeToNotice()
    }
}

// MARK: - SettingsScreen Delegate

extension SettingsScreenVC: SetupsProtocol {
    func changeStartWorkSwitch() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            if settings.authorizationStatus == .authorized {
                self.startWorkSwitch()
            } else {
                self.showiPhoneSetups()
            }
        }
    }
    
    func changeWorkSwitch() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            if settings.authorizationStatus == .authorized {
                self.workSwitch()
            } else {
                self.showiPhoneSetups()
            }
        }
    }
    
    func changeBreakSwitch() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            if settings.authorizationStatus == .authorized {
                self.breakSwitch()
            } else {
                self.showiPhoneSetups()
            }
        }
    }
    
    func updateTimeToNotice() {
        let startTime = timeDateToInt(date: settingsScreen.startWorkTimeDatePicker.date)
        
        UserDefaults.standard.set(startTime, forKey: "startTimeNotice")
        settingsScreen.startWorkTimeDataLabel.text = timeIntToStringShort(time: startTime)
        notificationStartWorkTime()
        
        var workTime = timeDateToInt(date: settingsScreen.workDatePicker.date)
        
        if workTime == 0 {
            workTime = 2400
        }
        
        UserDefaults.standard.set(workTime, forKey: "workTimeToNotice")
        settingsScreen.workTimeDataLabel.text = timeIntToStringShort(time: workTime)
        
        
        var breakTime = timeDateToInt(date: settingsScreen.breakDatePicker.date)
        
        if breakTime == 0 {
            breakTime = 900
        }
        
        UserDefaults.standard.set(breakTime, forKey: "breakTimeToNotice")
        settingsScreen.breakTimeDataLabel.text = timeIntToStringShort(time: breakTime)
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension SettingsScreenVC: UNUserNotificationCenterDelegate {
    func showiPhoneSetups() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl) { _ in
            }
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
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            guard granted else { return }
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
    }
    
    
    // MARK: - Уведомление о времени работы
    
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
            
            let startWorkTimeRequest = UNNotificationRequest(
                identifier: "Start work notification",
                content: content,
                trigger: trigger
            )
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
