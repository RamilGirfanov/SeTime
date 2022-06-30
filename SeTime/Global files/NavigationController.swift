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
        
        let mainVC = ViewController()
        viewControllers.append(mainVC)
        mainVC.title = "Сегодня"
    }
}
