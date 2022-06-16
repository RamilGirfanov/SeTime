//
//  Extention.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 15.06.2022.
//

import UIKit

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

//MARK: - Расширение для управления

extension ViewController: TimeTasksManagement {
    
//    Запускает таймер работы
    func startWorkTimer() {
        
        dataManager.workTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeOfWork), userInfo: nil, repeats: true)
        
        dataManager.launched = true
        
    }
    
    @objc func updateTimeOfWork() {
        dataManager.timeOfWork += 1
        day.workTime += dataManager.timeOfWork
        
        if dataManager.timeOfWork < 60 {
            workTimeLabel.text = "00:00:\(dataManager.timeOfWork)"
        } else if dataManager.timeOfWork < 3600 {
            workTimeLabel.text = "00:\(dataManager.timeOfWork / 60):\(dataManager.timeOfWork % 60)"
        } else {
            workTimeLabel.text = "\(dataManager.timeOfWork / 3600):\((dataManager.timeOfWork % 3600) / 60):\((dataManager.timeOfWork % 3600) % 60)"
        }
        
    }
    
//    Запускает таймер перерывов
    func startBreakTimer() {
        dataManager.breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeOfBreak), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimeOfBreak() {
        dataManager.timeOfBreak += 1
        day.breakTime += dataManager.timeOfBreak
        
        if dataManager.timeOfBreak < 60 {
            breakTimeLabel.text = "00:00:\(dataManager.timeOfBreak)"
        } else if dataManager.timeOfWork < 3600 {
            breakTimeLabel.text = "00:\(dataManager.timeOfBreak / 60):\(dataManager.timeOfBreak % 60)"
        } else {
            breakTimeLabel.text = "\(dataManager.timeOfBreak / 3600):\((dataManager.timeOfBreak % 3600) / 60):\((dataManager.timeOfBreak % 3600) % 60)"
        }
        
    }
    
//    Пауза для таймера работы
    func pauseWorkTimer() {
        dataManager.workTimer.invalidate()
    }
    
//    Пауза для таймера перерывов
    func pauseBreakTimer() {
        dataManager.breakTimer.invalidate()
    }

//    Пауза для обоих таймеров
    func stop() {
        dataManager.workTimer.invalidate()
        dataManager.breakTimer.invalidate()
        
        dataManager.launched = false
    }
    
    func newTask() {
        
    }
    
    func endOfDay() {
        
    }
    
}

