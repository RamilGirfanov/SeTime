//
//  SettingsScreenViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 03.12.2022.
//

import UIKit
import UserNotifications

class SettingsScreenViewController: UIViewController {
    
    //    MARK: - Экземпляр AddTaskScreen
    
    lazy var settingsScreen: SettingsScreen = {
        var view = SettingsScreen()
        view.delegate = self
        view.workDatePicker.date = timeToDate(time: UserDefaults.standard.integer(forKey: "workTimeToNotice"))
        view.breakDatePicker.date = timeToDate(time: UserDefaults.standard.integer(forKey: "breakTimeToNotice"))
        view.workTimeDataLabel.text = timeIntToStringShort(time: UserDefaults.standard.integer(forKey: "workTimeToNotice"))
        view.breakTimeDataLabel.text = timeIntToStringShort(time: UserDefaults.standard.integer(forKey: "breakTimeToNotice"))
        return view
    }()
    
    
//    MARK: - Методы VC
    
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
    
    
    //    MARK: - Жизненный цикл
    
    override func loadView() {
        view = settingsScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allowNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateTimeToNotice()
    }
}
