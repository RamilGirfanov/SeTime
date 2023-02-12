//
//  ext SaveTasksProtocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation
import RealmSwift

// MARK: - Протокол делегата EditTaskScreen

extension MainScreenVC: SaveTasksProtocol {
    func saveTask(taskIndex: Int, name: String, definition: String) {
        RealmManager.shared.updateTask(date: Model.shared.date, index: taskIndex, name: name, definition: definition)
        mainScreen.tasksTableView.reloadData()
    }
}
