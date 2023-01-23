//
//  ext EditTaskListProtocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 23.01.2023.
//

import Foundation

//MARK: - Протокол делегата DefinitionTaskScreen

extension TaskListScreenVC: EditTasksProtocol {
    func editTask(taskIndex: Int) {
        let editTaskVC = EditTaskScreenVC()
        editTaskVC.taskIndex = taskIndex
        editTaskVC.name = tasks[taskIndex].name
        editTaskVC.definition = tasks[taskIndex].definition
        editTaskVC.delegate = self
        present(editTaskVC, animated: true)
    }
}
