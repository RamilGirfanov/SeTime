//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 04.06.2022.
//

import UIKit

//MARK: - Структура дня

struct Day {
    let data = NSData()
    var workTime: String?
    var breakTime: String?
    
//    Свойства, которые будут использоваться для наполнения массива задач за день
    var taskName: String?
    var taskLasting: Int?
    
//    Массив с типом данных кортеж, в кортеже продолжительность и задача
    var tasks: [(task: String, lasting: Int)]?
    
}

//MARK: - Класс модели

struct Model {
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
        <#code#>
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

//MARK: - Созданная модель
//Будет постоянно создана?

var model = Model()

























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
