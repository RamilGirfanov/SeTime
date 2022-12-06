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
            
//            Очистка строк от переносов строк лишних пробелов
            let name = clearString(string: addTaskScreen.taskName.text)
            let definition = clearString(string: addTaskScreen.taskDefinition.text ?? "")
            
            delegate?.addTask(name: name, definition: definition)
            dismiss(animated: true)
        } else {
            addTaskScreen.worningLabel.text = NSLocalizedString("emptyFieldWarning", comment: "")
        }
    }
}
