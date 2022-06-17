//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 04.06.2022.
//

import Foundation

//MARK: - Структура управления

class DataManager {
        
//    Свойства, которые будут использоваться для наполнения времени работы и перерывов за день
    var workTimer = Timer()
    var breakTimer = Timer()
    
    var timeOfWork = 0
    var timeOfBreak = 0
    var totalTime = 0

//    Свойства, которые будут использоваться для наполнения массива задач за день
    var taskName: String?
    var taskLasting: Int?
    
}
