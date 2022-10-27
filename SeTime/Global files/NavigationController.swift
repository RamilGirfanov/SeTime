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
        lazy var barButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(tap))
        navigationItem.leftBarButtonItem = barButton
        
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    @objc private func tap() {
        lazy var calendarVC = DatePickerViewController()
        calendarVC.title = "Выбор даты"
        present(calendarVC, animated: true)
    }
}
