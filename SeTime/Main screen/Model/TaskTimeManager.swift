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
            
            lazy var taskSeconds = task.duration % 60
            lazy var taskMinutes = task.duration / 60 % 60
            lazy var taskHours = task.duration / 3600

            lazy var fullTaskTime: [String] = []
            
            switch taskHours {
            case 1...9:
                fullTaskTime.append("0\(taskHours)")
            case 10...24:
                fullTaskTime.append("\(taskHours)")
            default:
                fullTaskTime.append("00")
            }
            
            switch taskMinutes {
            case 1...9:
                fullTaskTime.append("0\(taskMinutes)")
            case 10...59:
                fullTaskTime.append("\(taskMinutes)")
            default:
                fullTaskTime.append("00")
            }
            
            switch taskSeconds {
            case 1...9:
                fullTaskTime.append("0\(taskSeconds)")
            case 10...59:
                fullTaskTime.append("\(taskSeconds)")
            default:
                fullTaskTime.append("00")
            }
            
            ViewController.taskTimeDataLabel.text = fullTaskTime.joined(separator: ":")
                        
        })
    }
    
    func pauseTaskTimer() {
        taskTimer.invalidate()
    }
    
}
