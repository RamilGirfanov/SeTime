//
//  TaskTimeManager.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 25.07.2022.
//

import Foundation

class TaskTimeManager {
    
    var taskTimer = Timer()
    
    func startTaskTimer() {
        
        taskTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            
            task.duration += 1
            
            if task.duration < 60 {
                ViewController.taskTimeDataLabel.text = "\(task.duration)с"
            } else if task.duration < 3600 {
                ViewController.taskTimeDataLabel.text = "\(task.duration / 60)м \(task.duration % 60)с"
            } else {
                ViewController.taskTimeDataLabel.text = "\(task.duration / 3600)ч \((task.duration % 3600) / 60)м"
            }
            
        })
    }
    
    func pauseTaskTimer() {
        taskTimer.invalidate()
    }
    
}
