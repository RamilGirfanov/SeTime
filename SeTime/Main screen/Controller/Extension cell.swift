//
//  Extension for cell management.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 20.06.2022.
//

/// В этом файле: расширяется кастомная ячейка для управления таймером для задачи

import Foundation

protocol CellManagement {
    
    func startTaskTimer()
    
    func stopTaskTimer()
    
}

extension TaskCell: CellManagement {
    
    func startTaskTimer() {
        
        taskTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in
            taskTime += 1
            day.tasks[numberOfCell].lasting = taskTime
            
            if taskTime < 60 {
                timeLabel.text = "\(taskTime)с"
            } else if taskTime < 3600 {
                timeLabel.text = "\(taskTime / 60)м \(taskTime % 60)с"
            } else {
                timeLabel.text = "\(taskTime / 3600)ч \((taskTime % 3600) / 60)м"
            }
        })
    }
    
    func stopTaskTimer() {
        taskTimer.invalidate()
        pauseButton.isHidden = true
    }
    
}
