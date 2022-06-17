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
    }
    
    @objc func updateTimeOfWork() {
        day.workTime += 1
        
        if day.workTime < 60 {
            workTimeLabel.text = "\(day.workTime)с"
        } else if day.workTime < 3600 {
            workTimeLabel.text = "\(day.workTime / 60)м \(day.workTime % 60)с"
        } else {
            workTimeLabel.text = "\(day.workTime / 3600)ч \((day.workTime % 3600) / 60)м \((day.workTime % 3600) % 60)с"
        }
        
        if day.totalTime < 60 {
            totalTimeLabel.text = "\(day.totalTime)с"
        } else if day.totalTime < 3600 {
            totalTimeLabel.text = "\(day.totalTime / 60)м \(day.totalTime % 60)с"
        } else {
            totalTimeLabel.text = "\(day.totalTime / 3600)ч \((day.totalTime % 3600) / 60)м \((day.totalTime % 3600) % 60)с"
        }
        
    }
    
//    Запускает таймер перерывов
    func startBreakTimer() {
        dataManager.breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeOfBreak), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimeOfBreak() {
        day.breakTime += 1
        
        if day.breakTime < 60 {
            breakTimeLabel.text = "\(day.breakTime)с"
        } else if day.breakTime < 3600 {
            breakTimeLabel.text = "\(day.breakTime / 60)м \(day.breakTime % 60)с"
        } else {
            breakTimeLabel.text = "\(day.breakTime / 3600)ч \((day.breakTime % 3600) / 60)м \((day.breakTime % 3600) % 60)с"
        }
        
        if day.totalTime < 60 {
            totalTimeLabel.text = "\(day.totalTime)с"
        } else if day.totalTime < 3600 {
            totalTimeLabel.text = "\(day.totalTime / 60)м \(day.totalTime % 60)с"
        } else {
            totalTimeLabel.text = "\(day.totalTime / 3600)ч \((day.totalTime % 3600) / 60)м \((day.totalTime % 3600) % 60)с"
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
    }
    
    func newTask() {
        
    }
    
    func endOfDay() {
        
    }
    
}

