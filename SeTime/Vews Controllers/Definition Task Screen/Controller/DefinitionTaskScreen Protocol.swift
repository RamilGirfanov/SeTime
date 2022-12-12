//
//  DefinitionTaskScreen Protocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation

//MARK: - Протокол делегата DefinitionTaskScreen

extension DefinitionTaskScreenViewController: EditTaskProtocol {
    func editTask() {
        dismiss(animated: true)
        delegate?.editTask(taskIndex: taskIndex)
    }
}
