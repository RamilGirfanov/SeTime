//
//  ext HSVC SaveTasksProtocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation
import RealmSwift

// MARK: - Протокол делегата EditTaskScreen

extension HistoryScreenVC: SaveTasksProtocol {
    func saveTask(taskIndex: Int, name: String, definition: String) {
        RealmManager.shared.updateTask(
            date: date,
            index: taskIndex,
            name: name,
            definition: definition
        )
        historyScreen.tasksTableView.reloadData()
    }
}
