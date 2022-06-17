//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 04.06.2022.
//

import Foundation

//MARK: - Структура управления

class DataManager {
    
//    Календарь для вычисления даты и времени
    let calendar = Calendar.current
        
//    Свойства, которые будут использоваться для наполнения времени работы и перерывов за день
    var workTimer = Timer()
    var breakTimer = Timer()
    
//    Время начала отсчета. Будет обновляться после каждого вызова функции
    var startTime = Date()
    
    
    var hoursOfWork = 0
    var minutesOfWork = 0
    var secondsOfWork = 0

    var hoursOfBreak = 0
    var minutesOfBreak = 0
    var secondsOfBreak = 0
    
    var hoursOfTotalTime: Int {
        hoursOfWork + hoursOfBreak
    }
    var minutesOfTotalTime: Int {
        minutesOfWork + minutesOfBreak
    }
    var secondsOfTotalTime: Int {
        secondsOfWork + secondsOfBreak
    }

//    Свойства, которые будут использоваться для наполнения массива задач за день
    var taskName: String?
    var taskLasting: Int?
    
}
