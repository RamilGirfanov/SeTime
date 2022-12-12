//
//  AddTaskScreenVC Protocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation

//MARK: - Протокол делегата AddTaskScreen

extension MainScreenViewController: AddTasksProtocol {
    func addTask(name: String, definition: String) {
        
//        Меняет видимости кнопки и вью задачи на главном экране
        mainScreen.addTaskButton.isHidden = true
        mainScreen.taskTimerView.isHidden = false
        
//        Устанавливает в лейбл задачи ее название
        mainScreen.taskTimeTextLabel.text = name
        
//        Устанавливает название и описание задачи в объект задачи
        model.task.name = name
        model.task.definition = definition
        
//        Запускает таймер задачи
        model.startTaskTimer()
        model.task.startTime = getTime()
    }
}
