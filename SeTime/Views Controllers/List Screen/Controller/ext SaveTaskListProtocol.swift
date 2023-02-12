//
//  ext SaveTaskListProtocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 23.01.2023.
//

import Foundation

// MARK: - Протокол делегата EditTaskScreen

extension TaskListScreenVC: SaveTasksProtocol {
    func saveTask(taskIndex: Int, name: String, definition: String) {
        RealmManager.shared.updateTaskList(
            index: taskIndex,
            name: name,
            definition: definition
        )
        tasks = RealmManager.shared.getTaskList()
        taskListScreen.tasksTableView.reloadData()
    }
}
