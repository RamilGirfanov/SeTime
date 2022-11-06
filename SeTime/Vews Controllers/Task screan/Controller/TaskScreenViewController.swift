//
//  TaskViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 22.07.2022.
//

import UIKit

protocol ManageTasks: AnyObject {
    func addTask (name: String, definition: String)
}

class TaskScreenViewController: UIViewController {

//    MARK: - Экземпляр TaskScreen
        
    private lazy var taskScreen: TaskScreen = {
        let view = TaskScreen()
        view.delegate = self
        return view
    }()
    
    
    //    MARK: - Delegate

    weak var delegate: ManageTasks?
    
}


//MARK: - Протокол делегата

extension TaskScreenViewController: TaskScreenProtocol {
    func dismiss() {
        
//        Проверка на введеное название задачи

        guard let newTask = taskScreen.taskName.text, !newTask.isEmpty else { return }
                
        delegate?.addTask(name: newTask, definition: taskScreen.definition.text ?? "")
        
//        Меняет видимости кнопки и вью задачи на главном экране
//        mainScreen?.addTaskButton
        
//        mainScreen.addTaskButton.isHidden = true
//        ViewController.taskTimerView.isHidden = false
        
//        Устанавливает в лейбл задачи ее название
//        ViewController.taskTimeTextLabel.text = newTask
        
//        Устанавливает название и описание задачи
//        model?.task.taskName = newTask
//        model?.task.definition = taskScreen.definition.text ?? ""
                
//        Запускает таймер и устанавливает время начала задачи
//        model?.startTaskTimer()
//        model?.task.startTime = getTime()
        
        dismiss(animated: true)
    }
}
