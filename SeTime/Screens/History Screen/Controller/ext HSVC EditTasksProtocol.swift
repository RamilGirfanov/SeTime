//
//  ext HSVC EditTasksProtocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation
import RealmSwift

// MARK: - Протокол делегата DefinitionTaskScreen

extension HistoryScreenVC: EditTasksProtocol {
    func editTask(taskIndex: Int) {
        guard let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first?.tasks[taskIndex] else { return }
        
        let taskEditVC = EditTaskScreenVC()
        taskEditVC.taskIndex = taskIndex
        taskEditVC.name = task.name
        taskEditVC.definition = task.definition
        taskEditVC.delegate = self
        present(taskEditVC, animated: true)
    }
}
