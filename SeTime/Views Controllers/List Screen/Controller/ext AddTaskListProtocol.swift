//
//  ext AddTaskListProtocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 23.01.2023.
//

import Foundation

//MARK: - Протокол делегата AddTaskScreen

extension TaskListScreenVC: AddTasksProtocol {
    func addTask(name: String, definition: String) {
        let taskList = TaskList()
        taskList.name = name
        taskList.definition = definition
        RealmManager.shared.addTaskList(task: taskList)
        tasks = RealmManager.shared.getTaskList()
        taskListScreen.tasksTableView.reloadData()
    }
}
