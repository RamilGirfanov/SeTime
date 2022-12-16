//
//  ext EditTaskScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation

//MARK: - Протокол делегата EditTaskScreen

extension EditTaskScreenVC: SaveTaskProtocol {
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
