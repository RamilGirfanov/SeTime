//
//  MainScreenVC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 16.12.2022.
//

import UIKit
import RealmSwift
import UserNotifications

final class MainScreenVC: UIViewController {
    
//    MARK: - Экземпляр MainScreen
    
    lazy var mainScreen: MainScreen = {
        let view = MainScreen()
        view.delegate = self
        view.tasksTableView.dataSource = self
        view.tasksTableView.delegate = self
        return view
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
    
    override func viewWillAppear(_ animated: Bool) {
        mainScreen.tasksTableView.reloadData()
    }
}
