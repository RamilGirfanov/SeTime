//
//  EditTaskScreenViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 20.11.2022.
//

import UIKit

protocol SaveTasksProtocol: AnyObject {
    func saveTask (name: String, definition: String)
}

class EditTaskScreenViewController: UIViewController {
    
//    MARK: - Хранимые свойства для настройки экрана
    
    var name = ""
    
    var definition = ""
    
    
//    MARK: - Экземпляр TaskAddScreen
    
    private lazy var editTaskScreen: EditTaskScreen = {
        let view = EditTaskScreen()
        view.taskName.text = self.name
        view.taskDefinition.text = self.definition
        view.delegate = self
        return view
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: SaveTasksProtocol?
    
    
//    MARK: - Жизненный цикл
    
    override func loadView() {
        view = editTaskScreen
    }
}


//MARK: - Протокол делегата

extension EditTaskScreenViewController: SaveTaskProtocol {
    func saveTask(name: String, definition: String) {
        delegate?.saveTask(name: name, definition: definition)
        dismiss(animated: true)
    }
}
