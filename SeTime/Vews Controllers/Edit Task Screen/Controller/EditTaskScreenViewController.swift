//
//  EditTaskScreenViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 20.11.2022.
//

import UIKit

protocol SaveTasksProtocol: AnyObject {
    func saveTask (taskIndex: Int, name: String, definition: String)
}

class EditTaskScreenViewController: UIViewController {
    
//    MARK: - Хранимые свойства для настройки экрана
    
    var taskIndex = 0
    
    var name = ""
    var definition = ""
    
    
//    MARK: - Экземпляр TaskAddScreen
    
    private lazy var editTaskScreen: EditTaskScreen = {
        let view = EditTaskScreen()
        view.taskName.text = name
        view.taskDefinition.text = definition
        view.delegate2 = self
        return view
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: SaveTasksProtocol?
    
    
//    MARK: - Жизненный цикл
    
    override func loadView() {
        view = editTaskScreen
        setupToHideKeyboardOnTapOnView()
    }
}


//MARK: - Протокол делегата

extension EditTaskScreenViewController: SaveTaskProtocol {
    func saveTask() {
        
//        Проверка на введеное название задачи
        if !editTaskScreen.taskName.text.isEmpty {
            delegate?.saveTask(taskIndex: taskIndex, name: editTaskScreen.taskName.text, definition: editTaskScreen.taskDefinition.text ?? "")
            dismiss(animated: true)
        } else {
            editTaskScreen.worningLabel.text = NSLocalizedString("emptyFieldWarning", comment: "")
        }
    }
}
