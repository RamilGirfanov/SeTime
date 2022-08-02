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
    let data: String = {
        // Календарь для вычисления даты и времени
        let calendar = Calendar.current
        // Текущая дата
        let todayDate = Date()
        
        // Извлечение компонентов из сегодняшней даты при помощи Calendar
        lazy var date: [String] = []
        
        if calendar.component(.day, from: todayDate) < 10 {
            date.append("0\(calendar.component(.day, from: todayDate))")
        } else {
            date.append("\(calendar.component(.day, from: todayDate))")
        }
        
        if calendar.component(.month, from: todayDate) < 10 {
            date.append("0\(calendar.component(.month, from: todayDate))")
        } else {
            date.append("\(calendar.component(.month, from: todayDate))")
        }
        
        date.append("\(calendar.component(.year, from: todayDate))")
        
        lazy var dayDate = date.joined(separator: ".")
        return dayDate
    }()

    var workTime = 0
    var breakTime = 0
    var totalTime: Int {workTime + breakTime}
    
//    Массив с типом данных кортеж, в кортеже название и продолжительность
    var tasks: [Task] = []
    
}
