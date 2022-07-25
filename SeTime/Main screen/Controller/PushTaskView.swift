//
//  PushTaskView.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 24.07.2022.
//

import UIKit

extension ViewController {
    
    func setupPushTaskScrean() {
        ViewController.addTaskButton.addTarget(self, action: #selector(tapForTask), for: .touchUpInside)
    }
 
    @objc func tapForTask() {
        
        if day.workTime != 0 {
            lazy var taskVC = TaskViewController()
            present(taskVC, animated: true)
        }
    }
}
