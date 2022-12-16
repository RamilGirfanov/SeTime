//
//  ext SettingsScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation
import UserNotifications

//MARK: - Протокол делегата SettingsScreen

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
