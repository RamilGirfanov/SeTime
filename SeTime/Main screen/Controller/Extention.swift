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
        dataManager.startTime = Date()
        
        dataManager.workTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeOfWork), userInfo: nil, repeats: true)
        
        dataManager.secondsOfWork = day.secondsOfWork
        dataManager.minutesOfWork = day.minutesOfWork
        dataManager.hoursOfWork = day.hoursOfWork
    }
    
    @objc func updateTimeOfWork() {
        
        let stopTime = Date()

        let deltaOfTime = dataManager.calendar.dateComponents([.hour, .minute, .second], from: dataManager.startTime, to: stopTime)

        dataManager.secondsOfWork = deltaOfTime.second ?? 0
        dataManager.minutesOfWork = deltaOfTime.minute ?? 0
        dataManager.hoursOfWork = deltaOfTime.hour ?? 0
        
        workTimeLabel.text = "\(dataManager.hoursOfWork)ч \(dataManager.minutesOfWork)м \(dataManager.secondsOfWork)с"
        totalTimeLabel.text = "\(dataManager.hoursOfTotalTime)ч \(dataManager.minutesOfTotalTime)м \(dataManager.secondsOfTotalTime)с"
    }
    
//    Запускает таймер перерывов
    func startBreakTimer() {
        dataManager.startTime = Date()

        dataManager.breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeOfBreak), userInfo: nil, repeats: true)
        
        dataManager.secondsOfBreak = day.secondsOfBreak
        dataManager.minutesOfBreak = day.minutesOfBreak
        dataManager.hoursOfBreak = day.hoursOfBreak
    }
    
    @objc func updateTimeOfBreak() {
        let stopTime = Date()

        let deltaOfTime = dataManager.calendar.dateComponents([.hour, .minute, .second], from: dataManager.startTime, to: stopTime)

        dataManager.secondsOfBreak = deltaOfTime.second ?? 0
        dataManager.minutesOfBreak = deltaOfTime.minute ?? 0
        dataManager.hoursOfBreak = deltaOfTime.hour ?? 0
                
        breakTimeLabel.text = "\(dataManager.hoursOfBreak)ч \(dataManager.minutesOfBreak)м \(dataManager.secondsOfBreak)с"
        totalTimeLabel.text = "\(dataManager.hoursOfTotalTime)ч \(dataManager.minutesOfTotalTime)м \(dataManager.secondsOfTotalTime)с"
    }
    
//    Пауза для таймера работы
    func pauseWorkTimer() {
        dataManager.workTimer.invalidate()
        
        day.secondsOfWork += dataManager.secondsOfWork
        day.minutesOfWork += dataManager.minutesOfWork
        day.hoursOfWork += dataManager.hoursOfWork
    }
    
//    Пауза для таймера перерывов
    func pauseBreakTimer() {
        dataManager.breakTimer.invalidate()
        
        day.secondsOfBreak += dataManager.secondsOfBreak
        day.minutesOfBreak += dataManager.minutesOfBreak
        day.hoursOfBreak += dataManager.hoursOfBreak
    }

//    Пауза для обоих таймеров
    func stop() {
        dataManager.workTimer.invalidate()
        
        day.secondsOfWork += dataManager.secondsOfWork
        day.minutesOfWork += dataManager.minutesOfWork
        day.hoursOfWork += dataManager.hoursOfWork

        dataManager.breakTimer.invalidate()
        
        day.secondsOfBreak += dataManager.secondsOfBreak
        day.minutesOfBreak += dataManager.minutesOfBreak
        day.hoursOfBreak += dataManager.hoursOfBreak
    }
    
    func newTask() {
        
    }
    
    func endOfDay() {
        
    }
    
}

