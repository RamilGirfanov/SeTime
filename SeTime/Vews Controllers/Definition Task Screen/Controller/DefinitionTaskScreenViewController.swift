//
//  DefinitionTaskScreenViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 18.11.2022.
//

import UIKit

protocol EditTasksProtocol: AnyObject {
    func editTask(name: String, definition: String)
}

class DefinitionTaskScreenViewController: UIViewController {
    
//    MARK: - Хранимые свойства для настройки экрана
    
    var name = ""
    
    var definition = ""
    
    
//    MARK: - Экземпляр DefinitionTaskScreen
    
    private lazy var taskDefinitionScreen: DefinitionTaskScreen = {
        let view = DefinitionTaskScreen()
        view.name.text = self.name
        view.definition.text = self.definition
        view.delegate = self
        return view
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: EditTasksProtocol?
    
    
//    MARK: - Жизненный цикл
    
    override func loadView() {
        view = taskDefinitionScreen
    }
}


//MARK: - Протокол делегата

extension DefinitionTaskScreenViewController: EditTaskProtocol {
    func editTask() {
        dismiss(animated: true)
        delegate?.editTask(name: self.name, definition: self.definition)
    }
}
