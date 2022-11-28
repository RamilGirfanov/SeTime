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

class AddTaskScreenViewController: UIViewController {

//    MARK: - Экземпляр AddTaskScreen
    
    private lazy var addTaskScreen: AddTaskScreen = {
        let view = AddTaskScreen()
        view.delegate = self
        return view
    }()
    
    
    //    MARK: - Delegate

    weak var delegate: AddTasksProtocol?
    
    
    //    MARK: - Жизненный цикл
    
    override func loadView() {
        view = addTaskScreen
        setupToHideKeyboardOnTapOnView()
    }
}


//MARK: - Протокол делегата

extension AddTaskScreenViewController: AddTaskProtocol {
    func addTask() {
        
//        Проверка на введеное название задачи
        if !addTaskScreen.taskName.text.isEmpty {
            delegate?.addTask(name: addTaskScreen.taskName.text!, definition: addTaskScreen.taskDefinition.text ?? "")
            dismiss(animated: true)
        } else {
            addTaskScreen.worningLabel.text = NSLocalizedString("emptyFieldWarning", comment: "")

        }
    }
}
