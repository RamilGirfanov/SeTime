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
    var workTime: String?
    var breakTime: String?
    
//    Свойства, которые будут использоваться для наполнения массива задач за день
    var taskName: String?
    var taskLasting: Int?
    
//    Массив с типом данных кортеж, в кортеже продолжительность и задача
    var tasks: [(task: String, lasting: Int)]?
    
}
