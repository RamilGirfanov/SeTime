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
