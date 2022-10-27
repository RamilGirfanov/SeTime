//
//  Day.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 14.06.2022.
//

/// В этом файле: создается структура модели для управления данными актуального дня

import Foundation

//Структура дня

struct Day {
    
//    Свойство - ключ для записи дня в архив. Пример "17.06.2022"
    let date: String = {
        getDate()
    }()

    var workTime = 0
    var breakTime = 0
    var totalTime: Int {workTime + breakTime}
    
//    Массив с типом данных кортеж, в кортеже название и продолжительность
    var tasks: [Task] = []
}
