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
    
    
    //    MARK: - Жизненный цикл
    
    override func loadView() {
        view = taskScreen
    }
    
}


//MARK: - Протокол делегата

extension TaskScreenViewController: TaskScreenProtocol {
    func dismiss() {
        
//        Проверка на введеное название задачи
        guard let newTask = taskScreen.taskName.text, !newTask.isEmpty else { return }
        delegate?.addTask(name: newTask, definition: taskScreen.definition.text ?? "")
        dismiss(animated: true)
    }
}
