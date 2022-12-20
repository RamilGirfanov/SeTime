//
//  ext SettingsScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation
import UserNotifications

//MARK: - Протокол делегата SettingsScreen

extension SettingsScreenVC: SetupsProtocol {
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
