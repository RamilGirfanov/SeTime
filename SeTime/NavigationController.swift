//
//  NavigationController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNC()
    }
    
    private func setupNC() {
        let mainVC = MainScreenVC()
        mainVC.title = NSLocalizedString("mainScreenTitle", comment: "")
        mainVC.navigationItem.largeTitleDisplayMode = .automatic
        
//        Настройка кнопок вызова экрана истории
        let barButtonCalendar = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(datePickerScreen))
        
        let barButtonSettings = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsScreen))
        
        mainVC.navigationItem.leftBarButtonItem = barButtonCalendar
        mainVC.navigationItem.rightBarButtonItem = barButtonSettings
        
        viewControllers.append(mainVC)
    }
    
    @objc private func datePickerScreen() {
        let calendarVC = DatePickerScreenVC()
        calendarVC.title = NSLocalizedString("datePickerScreenTitle", comment: "")
        present(calendarVC, animated: true)
    }
    
    @objc private func settingsScreen() {
        let settingsSC = SettingsScreenVC()
        settingsSC.title = NSLocalizedString("settings", comment: "")
        present(settingsSC, animated: true)
    }
}
