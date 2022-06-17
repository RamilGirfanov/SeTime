//
//  Day.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 14.06.2022.
//

import Foundation

//Структура дня

struct Day {
    
    // Свойство - ключь для записи дня в архив. Пример "2022-06-17"
    let data: String = {
            // Календарь для вычисления даты и времени
            let calendar = Calendar.current
            // Текущая дата
            let todayDate = Date()

            // Извлечение компонентов из сегодняшней даты при помощи Calendar
            let yyyy = calendar.component(.year, from: todayDate)
            let mm = calendar.component(.month, from: todayDate)
            let dd = calendar.component(.day, from: todayDate)

            lazy var dayDate = "\(yyyy)-\(mm)-\(dd)"
        return dayDate
    }()
        
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
    
//    Массив с типом данных кортеж, в кортеже продолжительность и задача
    var tasks: [(task: String, lasting: Int)]?
    
}
