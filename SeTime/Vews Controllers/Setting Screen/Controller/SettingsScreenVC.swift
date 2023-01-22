//
//  SettingsScreenViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 03.12.2022.
//

import UIKit
import UserNotifications

final class SettingsScreenVC: UIViewController {
    
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
