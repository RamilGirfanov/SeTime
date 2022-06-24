//
//  TabBarController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 24.06.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
//    Экраны
    let mainVC = ViewController()
    
//    Настройка контроллера и добавление экранов
    private func setupTabBarController() {
        
//        Цвет значка
        tabBar.tintColor = mainColorTheme
        
//        let secondNC = UINavigationController(rootViewController: mainVC)
        mainVC.tabBarItem.title = "Сегодня"
        mainVC.tabBarItem.image = UIImage(systemName: "hourglass")
        
        viewControllers = [mainVC]
    }
    
}
