//
//  DefinitionTaskScreenVC2 Protocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation
import RealmSwift

//MARK: - Протокол делегата DefinitionTaskScreen

extension HistoryScreenViewController: EditTasksProtocol {
    func editTask(taskIndex: Int) {
        
        let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first!.tasks[taskIndex]
        
        let taskEditVC = EditTaskScreenViewController()
        taskEditVC.taskIndex = taskIndex
        taskEditVC.name = task.name
        taskEditVC.definition = task.definition
        taskEditVC.delegate = self
        present(taskEditVC, animated: true)
    }
}
