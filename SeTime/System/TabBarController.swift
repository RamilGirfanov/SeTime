//
//  TabBarController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 22.01.2023.
//

import UIKit

class TabBarController: UITabBarController {
    private func setupVC() {
        let datePickerVC = DatePickerScreenVC()
        datePickerVC.tabBarItem.image = UIImage(systemName: "calendar")
        
        let listScreenVC = TaskListScreenVC()
        listScreenVC.tabBarItem.image = UIImage(systemName: "list.bullet")
        
        let mainScreenVC = MainScreenVC()
        mainScreenVC.tabBarItem.image = UIImage(systemName: "hourglass")
        
        let settingsScreenVC = SettingsScreenVC()
        settingsScreenVC.tabBarItem.image = UIImage(systemName: "gear")
        
        viewControllers = [datePickerVC, listScreenVC, mainScreenVC, settingsScreenVC]
        selectedViewController = mainScreenVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
}
