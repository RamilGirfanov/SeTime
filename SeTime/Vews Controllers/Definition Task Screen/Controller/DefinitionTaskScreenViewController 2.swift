//
//  DefinitionTaskScreenViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 18.11.2022.
//

import UIKit

protocol EditTasksProtocol: AnyObject {
    func editTask(taskIndex: Int)
}

class DefinitionTaskScreenViewController: UIViewController {
    
//    MARK: - Хранимые свойства для настройки экрана
    
    var taskIndex = 0
    
    var name = ""
    var startTime = ""
    var duration = ""
    var definition = ""
    
    
//    MARK: - Экземпляр DefinitionTaskScreen
    
    private lazy var taskDefinitionScreen: DefinitionTaskScreen = {
        let view = DefinitionTaskScreen()
        view.name.text = name
        view.startTime.text = startTime
        view.duration.text = duration
        view.definition.text = definition
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
        delegate?.editTask(taskIndex: taskIndex)
    }
}
