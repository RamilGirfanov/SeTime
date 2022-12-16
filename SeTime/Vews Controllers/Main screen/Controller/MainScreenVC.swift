//
//  MainScreenVC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 16.12.2022.
//

import UIKit
import RealmSwift
import UserNotifications

class MainScreenVC: UIViewController {
    
//    MARK: - Экземпляры MainScreen и Model
    
    lazy var mainScreen: MainScreen = {
        let view = MainScreen()
        view.delegate = self
        view.tasksTableView.dataSource = self
        view.tasksTableView.delegate = self
        return view
    }()
    
    lazy var model: Model = {
        let model = Model()
        model.delegate = self
        return model
    }()

//    MARK: - Lifecycle
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNC()
        checkDay()
        UNUserNotificationCenter.current().delegate = self
    }
}
