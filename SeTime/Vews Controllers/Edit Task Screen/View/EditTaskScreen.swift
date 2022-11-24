//
//  EditTaskScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 20.11.2022.
//

import UIKit

protocol SaveTaskProtocol: AnyObject {
    func saveTask(name: String, definition: String)
}

class EditTaskScreen: AddTaskScreen {
    
    var delegate2: SaveTaskProtocol?
    
    override func tap() {
        guard let newTaskName = taskName.text, !newTaskName.isEmpty else { return }
        delegate2?.saveTask(name: newTaskName, definition: taskDefinition.text ?? "")
    }
    func overrideClass() {
        screenLabel.text = NSLocalizedString("editTaskScreenTitle", comment: "")
        button.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        overrideClass()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
