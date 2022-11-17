//
//  TaskViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 22.07.2022.
//

import UIKit

protocol AddTasksProtocol: AnyObject {
    func addTask (name: String, definition: String)
}

class TaskAddScreenViewController: UIViewController {

//    MARK: - Экземпляр TaskAddScreen
    
    private lazy var taskScreen: TaskAddScreen = {
        let view = TaskAddScreen()
        view.delegate = self
        return view
    }()
    
    
    //    MARK: - Delegate

    weak var delegate: AddTasksProtocol?
    
    
    //    MARK: - Жизненный цикл
    
    override func loadView() {
        view = taskScreen
    }
}


//MARK: - Протокол делегата

extension TaskAddScreenViewController: AddTaskProtocol {
    func addTask() {
        
//        Проверка на введеное название задачи
        guard let newTask = taskScreen.taskName.text, !newTask.isEmpty else { return }
        delegate?.addTask(name: newTask, definition: taskScreen.taskDefinition.text ?? "")
        dismiss(animated: true)
    }
}
