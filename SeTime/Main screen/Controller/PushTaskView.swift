//
//  PushTaskView.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 24.07.2022.
//

import UIKit

extension ViewController {
    
    func pushTaskScreen() {
        ViewController.addTaskButton.addTarget(self, action: #selector(tapForTask), for: .touchUpInside)
    }
 
    @objc func tapForTask() {
        let taskVC = TaskViewController()
        present(taskVC, animated: true)
    }
}
