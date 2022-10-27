//
//  TaskViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 22.07.2022.
//

import UIKit

class TaskScreenViewController: UIViewController {

//    MARK: - Экземпляр TaskScreen
        
    private lazy var taskScreen: TaskScreen = {
        let view = TaskScreen()
        view.delegate = self
        return view
    }()
    
    
    //    MARK: - Экземпляр модели
    var model: Model?
    
}


//MARK: - Протокол делегата

extension TaskScreenViewController: TaskScreenProtocol {
    func dismiss() {
        
//        Проверка на введеное название задачи

        guard let newTask = taskScreen.taskName.text, !newTask.isEmpty else { return }
        
//        Устанавливает название и описание задачи
        model?.task.taskName = newTask
        model?.task.definition = taskScreen.definition.text ?? ""
                
//        Запускает таймер и устанавливает время начала задачи
        model?.startTaskTimer()
        model?.task.startTime = getTime()
        
        dismiss(animated: true)
    }
}
