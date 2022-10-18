//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 04.06.2022.
//

/// В этом файле: создается класс модели для управления таймером работы и перерывов

import Foundation

//MARK: - Структура управления

class WorkTimeManager {
        
//    Свойства, которые будут использоваться для наполнения времени работы и перерывов за день
    var workTimer = Timer()
    var breakTimer = Timer()
    
    var workTime = 0
    var breakTime = 0
    var totalTime = 0
}
