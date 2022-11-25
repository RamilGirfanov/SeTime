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
        
        let mainVC = MainScreenViewController()
        mainVC.title = NSLocalizedString("mainScreenTitle", comment: "")
        viewControllers.append(mainVC)
        
//        Настройка кнопки вызова экрана истории
        let barButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(tap))
        mainVC.navigationItem.leftBarButtonItem = barButton
        
        mainVC.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    @objc private func tap() {
        let calendarVC = DatePickerScreenViewController()
        calendarVC.title = NSLocalizedString("datePickerScreenTitle", comment: "")
        present(calendarVC, animated: true)
    }
}
