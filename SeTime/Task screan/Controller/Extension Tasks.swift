//
//  Extension Tasks.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 25.07.2022.
//

import UIKit

extension TaskViewController {
    
    func setupButton() {
        startButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
    @objc private func addTask() {
        
        guard let newTask = taskName.text, !newTask.isEmpty else { return }
        
        ViewController.addTaskButton.isHidden = true
        
        ViewController.taskTimerView.isHidden = false
        
        
        task.taskName = newTask
        
        task.definition = definition.text ?? ""
        
        ViewController.taskTimeTextLabel.text = newTask
        
        self.dismiss(animated: true)
        
        taskTimeManager.startTaskTimer()
        
        task.addStartTime()
        
    }
    
}

