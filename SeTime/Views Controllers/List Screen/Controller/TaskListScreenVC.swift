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
        taskListScreen.tasksTableView.dragDelegate = self
        taskListScreen.tasksTableView.dropDelegate = self
        return taskListScreen
    }()
    
//    MARK: - Массив задач
    
    var tasks: [TaskList] = []
    
    private func setupData() {
        tasks = RealmManager.shared.getTaskList()
    }
    
    
//    MARK: - Lifecycle
    
    override func loadView() {
        view = taskListScreen
        setupData()
        taskListScreen.tasksTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
