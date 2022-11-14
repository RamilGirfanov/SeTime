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
        mainVC.view.backgroundColor = .systemBackground
        mainVC.title = "Сегодня"
        viewControllers.append(mainVC)
        
//        Настройка кнопки вызова экрана истории
        var barButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(tap))
        mainVC.navigationItem.leftBarButtonItem = barButton
        
        mainVC.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    @objc private func tap() {
        var calendarVC = DatePickerScreenViewController()
        calendarVC.title = "Выбор даты"
        present(calendarVC, animated: true)
    }
}
