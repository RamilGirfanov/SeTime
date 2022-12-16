//
//  ext HistoryScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation
import RealmSwift

//MARK: - Протокол делегата HistoryScreen

extension HistoryScreenVC: HistoryManager {
    func getDay() -> Day {
        day
    }
        
    func showTaskDifinition(index: Int) {
        let taskDefinitionVC = DefinitionTaskScreenVC()
        
        let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first!.tasks[index]
        
        taskDefinitionVC.taskIndex = index
        
        taskDefinitionVC.name = task.name
        taskDefinitionVC.startTime = task.startTime
        taskDefinitionVC.duration = timeIntToString(time: task.duration)
        taskDefinitionVC.definition = task.definition
        taskDefinitionVC.delegate = self
        present(taskDefinitionVC, animated: true)
    }
    
    func deleteTask(index: Int) {
        RealmManager.shared.deleteTask(date: date, index: index)
    }
}
