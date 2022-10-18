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
        mainVC.view.backgroundColor = .systemBackground
        mainVC.title = "Сегодня"
        viewControllers.append(mainVC)

    }
}
