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
        return view
    }()
    
    
//    MARK: - Жизненный цикл
    
    override func loadView() {
        view = settingsScreen
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
