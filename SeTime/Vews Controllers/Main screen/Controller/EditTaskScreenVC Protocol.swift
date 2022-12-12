//
//  EditTaskScreenVC Protocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation
import RealmSwift

//MARK: - Протокол делегата EditTaskScreen

extension MainScreenViewController: SaveTasksProtocol {
    func saveTask(taskIndex: Int, name: String, definition: String) {
        RealmManager.shared.updateTask(date: model.date, index: taskIndex, name: name, definition: definition)
        mainScreen.tasksTableView.reloadData()
    }
}
