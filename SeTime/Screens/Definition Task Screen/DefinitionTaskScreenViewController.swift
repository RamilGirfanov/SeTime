//
//  DefinitionTaskScreenVC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 18.11.2022.
//

import UIKit

protocol EditTasksProtocol: AnyObject {
    func editTask(taskIndex: Int)
}

final class DefinitionTaskScreenVC: UIViewController {
    // MARK: - Хранимые свойства для настройки экрана
    
    var taskIndex = 0
    
    var name = ""
    var startTime = ""
    var duration = ""
    var definition = ""
    
    
    // MARK: - Экземпляр DefinitionTaskScreen
    
    lazy var taskDefinitionScreen: DefinitionTaskScreen = {
        let view = DefinitionTaskScreen()
        view.name.text = name
        view.startTime.text = startTime
        view.duration.text = duration
        view.definition.text = definition
        view.delegate = self
        return view
    }()
    
    
    // MARK: - Delegate
    
    weak var delegate: EditTasksProtocol?
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = taskDefinitionScreen
    }
}

// MARK: - DefinitionTaskScreen Delegate

extension DefinitionTaskScreenVC: EditTaskProtocol {
    func editTask() {
        dismiss(animated: true)
        delegate?.editTask(taskIndex: taskIndex)
    }
}
