//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 04.06.2022.
//

import UIKit

//MARK: - Класс модели

class Model {
    var timet = Timer()
}

//MARK: - Протокол и расширение для модели

protocol TimerDayManagement {
    func createNewDay() -> Day
    
    func startWorkTimer()
    func startBreakTimer()
    
    func pauseWorkTimer()
    func pauseBreakTimer()
    
    func stop()
    
    func endOfDay()

}

extension Model: TimerDayManagement {
    func createNewDay() -> Day {
        let day = Day()
        return day
    }
    
    func startWorkTimer() {
        
    }
    
    func startBreakTimer() {
        
    }
    
    func pauseWorkTimer() {
        
    }
    
    func pauseBreakTimer() {
        
    }

    func stop() {
        
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
