//
//  Day.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 14.06.2022.
//

import Foundation

//Структура дня

struct Day {
    let data = NSData()
    var workTime = 0
    var breakTime = 0
    
//    Массив с типом данных кортеж, в кортеже продолжительность и задача
    var tasks: [(task: String, lasting: Int)]?
    
}
