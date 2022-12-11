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
        view.workTimeDataLabel.text = timeIntToStringShort(time: UserDefaults.standard.integer(forKey: "workTimeToNotice"))
        view.breakTimeDataLabel.text = timeIntToStringShort(time: UserDefaults.standard.integer(forKey: "breakTimeToNotice"))
        return view
    }()
    
    
//    MARK: - Методы VC
    
    private func showiPhoneSetups() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    
    private func workSwitch() {
        if self.settingsScreen.workSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "notificationWorkTolerance")
        } else {
            UserDefaults.standard.set(false, forKey: "notificationWorkTolerance")
        }
    }
    
    private func breakSwitch() {
        if settingsScreen.breakSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "notificationBreakTolerance")
        } else {
            UserDefaults.standard.set(false, forKey: "notificationBreakTolerance")
        }
    }
    
    private func allowNotifications() {
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


//MARK: - Протокол делегата

extension SettingsScreenViewController: SetupsProtocol {
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
        let workTime = timeDateToInt(date: settingsScreen.workDatePicker.date)
        UserDefaults.standard.set(workTime, forKey: "workTimeToNotice")
        settingsScreen.workTimeDataLabel.text = timeIntToStringShort(time: workTime)
        
        let breakTime = timeDateToInt(date: settingsScreen.breakDatePicker.date)
        UserDefaults.standard.set(breakTime, forKey: "breakTimeToNotice")
        settingsScreen.breakTimeDataLabel.text = timeIntToStringShort(time: breakTime)
    }
}
