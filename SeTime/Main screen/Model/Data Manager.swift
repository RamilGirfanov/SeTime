//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 04.06.2022.
//

import Foundation

//MARK: - Структура управления

class DataManager {
    
    var stopwatch = Stopwatch()
    
    var day = Day()
    
    var launched = false
        
}

//MARK: - Протокол для управления

protocol TimeTasksManagement {
        
    func startWorkTimer()
    func startBreakTimer()
        
    func pauseWorkTimer()
    func pauseBreakTimer()
    
    func stop()
    
    func newTask()
    
    func endOfDay()

}

//MARK: - Расширение для структуры управления

extension DataManager: TimeTasksManagement {
    
//    Запускает таймер работы
    func startWorkTimer() {
        stopwatch.workTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeOfWork), userInfo: nil, repeats: true)
        
        launched = true
    }
    
    @objc func updateTimeOfWork() {
        stopwatch.timeOfWork += 1
        day.workTime = String(stopwatch.timeOfWork)
    }
    
//    Запускает таймер перерывов
    func startBreakTimer() {
        stopwatch.breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeOfBreak), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimeOfBreak() {
        stopwatch.timeOfBreak += 1
    }
    
//    Пауза для таймера работы
    func pauseWorkTimer() {
        stopwatch.workTimer.invalidate()
    }
    
//    Пауза для таймера перерывов
    func pauseBreakTimer() {
        stopwatch.breakTimer.invalidate()
    }

//    Пауза для обоих таймеров
    func stop() {
        stopwatch.workTimer.invalidate()
        stopwatch.breakTimer.invalidate()
        
        launched = false
    }
    
    func newTask() {
        
    }
    
    func endOfDay() {
        
    }
    
}
























/*
var timerForWork = Timer()
func createWorkTimer() {
    timerForWork = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: Data(), repeats: true)
}

@objc func updateTimer() {
    let time = Int(-(self.timerForWork.userInfo as! Date).timeIntervalSinceNow)
    
    if time < 60 {
        workTime = String(format: "%.0f", time)
    } else if time < 3600 {
        workTime = String(format: "%.0f:%.0f", time / 60, time % 60)
    } else {
        workTime = String(format: "%.0f:%.0f:%.0f", time / 3600, time % 60, time % 3600)
    }
    
}
*/
