//
//  EditTaskScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 20.11.2022.
//

import UIKit

protocol SaveTaskProtocol: AnyObject {
    func saveTask()
}

class EditTaskScreen: AddTaskScreen {
    
    var delegate2: SaveTaskProtocol?
    
    override func tap() {
        delegate2?.saveTask()
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
