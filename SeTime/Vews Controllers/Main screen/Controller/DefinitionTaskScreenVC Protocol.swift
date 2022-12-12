//
//  DefinitionTaskScreenVC Protocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation
import RealmSwift

//MARK: - Протокол делегата DefinitionTaskScreen

extension MainScreenViewController: EditTasksProtocol {
    func editTask(taskIndex: Int) {
        
        let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", model.date).first!.tasks[taskIndex]
        
        let editTaskVC = EditTaskScreenViewController()
        editTaskVC.taskIndex = taskIndex
        editTaskVC.name = task.name
        editTaskVC.definition = task.definition
        editTaskVC.delegate = self
        present(editTaskVC, animated: true)
    }
}
