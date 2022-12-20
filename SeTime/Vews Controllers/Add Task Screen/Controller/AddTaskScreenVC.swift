//
//  AddTaskScreenVC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 22.07.2022.
//

import UIKit

protocol AddTasksProtocol: AnyObject {
    func addTask (name: String, definition: String)
}

class AddTaskScreenVC: UIViewController {

//    MARK: - Экземпляр AddTaskScreen
    
    lazy var addTaskScreen: AddTaskScreen = {
        let view = AddTaskScreen()
        view.delegate = self
        return view
    }()
    
    
    //    MARK: - Delegate

    weak var delegate: AddTasksProtocol?
    
    
    //    MARK: - Lifecycle
    
    override func loadView() {
        view = addTaskScreen
        setupToHideKeyboardOnTapOnView()
    }
}
