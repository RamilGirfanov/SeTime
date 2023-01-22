//
//  TaskListScreenVC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 22.01.2023.
//

import UIKit

class TaskListScreenVC: UIViewController {
    
//    MARK: - Экземпляр TaskListScreen
    
    lazy var taskListScreen: TaskListScreen = {
        let taskListScreen = TaskListScreen()
        taskListScreen.delegate = self
        taskListScreen.tasksTableView.dataSource = self
        taskListScreen.tasksTableView.delegate = self
        return taskListScreen
    }()
    
//    MARK: - Массив задач
    
    var tasks = RealmManager.shared.getTaskList()
    
    
//    MARK: - Lifecycle
    
    override func loadView() {
        view = taskListScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
