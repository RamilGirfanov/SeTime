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
    
    private lazy var settingsScreen: SettingsScreen = {
       var view = SettingsScreen()
        view.delegate = self
        view.workDatePicker.date = timeToDate(time: UserDefaults.standard.integer(forKey: "workTimeToNotice"))
        view.breakDatePicker.date = timeToDate(time: UserDefaults.standard.integer(forKey: "breakTimeToNotice"))
        return view
    }()
    
    
//    MARK: - Жизненный цикл
    
    override func loadView() {
        view = settingsScreen
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let workTime = timeDateToInt(date: settingsScreen.workDatePicker.date)
        UserDefaults.standard.set(workTime, forKey: "workTimeToNotice")
        
        let breakTime = timeDateToInt(date: settingsScreen.breakDatePicker.date)
        UserDefaults.standard.set(breakTime, forKey: "breakTimeToNotice")
    }
}


//MARK: - Протокол делегата

extension SettingsScreenViewController: SetupsProtocol {
    func allowNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            guard granted else { return }
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                guard settings.authorizationStatus == .authorized else { return }
                UserDefaults.standard.set(true, forKey: "notificationTolerance")
            }
        }
    }
    
    func changeWorkSwitch() {
        if settingsScreen.workSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "notificationWorkTolerance")
        } else {
            UserDefaults.standard.set(false, forKey: "notificationWorkTolerance")
        }
    }
    
    func changeBreakSwitch() {
        if settingsScreen.breakSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "notificationBreakTolerance")
        } else {
            UserDefaults.standard.set(false, forKey: "notificationBreakTolerance")
        }
    }
}
