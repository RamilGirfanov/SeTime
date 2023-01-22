//
//  ext AddTasksProtocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation

//MARK: - Протокол делегата AddTaskScreen

extension MainScreenVC: AddTasksProtocol {
    func addTask(name: String, definition: String) {
        
//        Меняет видимости кнопки и вью задачи на главном экране
        mainScreen.addTaskButton.isHidden = true
        mainScreen.taskTimerView.isHidden = false
        
//        Устанавливает в лейбл задачи ее название
        mainScreen.taskTimeTextLabel.text = name
        
//        Устанавливает название и описание задачи в объект задачи
        Model.shared.task.name = name
        Model.shared.task.definition = definition
        
//        Запускает таймер задачи
        Model.shared.startTaskTimer()
        Model.shared.task.startTime = getTime()
    }
}
