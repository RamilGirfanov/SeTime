//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 04.06.2022.
//

import Foundation

//MARK: - Структура управления

class DataManager {
        
    var launched = false

//    Свойства, которые будут использоваться для наполнения времени работы и перерывов за день
    var workTimer = Timer()
    var breakTimer = Timer()
    
    var timeOfWork = 0
    var timeOfBreak = 0

//    Свойства, которые будут использоваться для наполнения массива задач за день
    var taskName: String?
    var taskLasting: Int?
    
}























/*

@objc func updateTimer() {

    if time < 60 {
        workTime = String(format: "%.0f", time)
    } else if time < 3600 {
        workTime = String(format: "%.0f:%.0f", time / 60, time % 60)
    } else {
        workTime = String(format: "%.0f:%.0f:%.0f", time / 3600, time % 60, time % 3600)
    }
    
}
*/
