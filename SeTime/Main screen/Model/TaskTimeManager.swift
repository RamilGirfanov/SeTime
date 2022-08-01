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
                fullTaskTime.append("0\(taskHours)ч")
            case 10...24:
                fullTaskTime.append("\(taskHours)ч")
            default:
                fullTaskTime.append("")
            }
            
            switch taskMinutes {
            case 1...9:
                fullTaskTime.append("0\(taskMinutes)м")
            case 10...59:
                fullTaskTime.append("\(taskMinutes)м")
            default:
                fullTaskTime.append("")
            }
            
            switch taskSeconds {
            case 1...9:
                fullTaskTime.append("0\(taskSeconds)с")
            case 10...59:
                fullTaskTime.append("\(taskSeconds)с")
            default:
                fullTaskTime.append("")
            }
            
            ViewController.taskTimeDataLabel.text = fullTaskTime.joined(separator: " ")
            
//            if task.duration < 60 {
//                ViewController.taskTimeDataLabel.text = "\(task.duration)с"
//            } else if task.duration < 3600 {
//                ViewController.taskTimeDataLabel.text = "\(task.duration / 60)м \(task.duration % 60)с"
//            } else {
//                ViewController.taskTimeDataLabel.text = "\(task.duration / 3600)ч \((task.duration % 3600) / 60)м"
//            }
            
        })
        RunLoop.current.add(taskTimer, forMode: .common)
        taskTimer.tolerance = 0.1
    }
    
    func pauseTaskTimer() {
        taskTimer.invalidate()
    }
    
}
