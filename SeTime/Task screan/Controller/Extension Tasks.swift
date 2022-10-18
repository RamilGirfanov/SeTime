//
//  Extension Tasks.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 25.07.2022.
//

import UIKit

extension TaskViewController {
    
    func setupButton() {
        startButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
    @objc private func addTask() {
        
//        Проверка на введеное название задачи
        guard let newTask = taskName.text, !newTask.isEmpty else { return }
        
//        Меняет видимости кнопки и вью задачи на главном экране
        ViewController.addTaskButton.isHidden = true
        ViewController.taskTimerView.isHidden = false
        
//        Устанавливает в лейбл задачи ее название
        ViewController.taskTimeTextLabel.text = newTask

//        Устанавливает название и описание задачи
        task.taskName = newTask
        task.definition = definition.text ?? ""
        
//        Запускает таймер и устанавливает время начала задачи
        ViewController.startTaskTimer()
        task.startTime = getTime()
        
//        Скрывает текущий экран
        self.dismiss(animated: true)

    }
    
}

