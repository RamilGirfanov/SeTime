//
//  ext AddTaskScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation


//MARK: - Протокол делегата AddTaskScreen

extension AddTaskScreenVC: AddTaskProtocol {
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
