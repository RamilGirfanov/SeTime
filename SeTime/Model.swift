//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 04.06.2022.
//

import UIKit

//В этом файле будет бизнес-логика

struct Day {
    let data: Int?
    var workTime: Int?
    var breakTime: Int?
    
//    Массив с типом данных кортеж, в кортеже продолжительность и задача
    var tasks: [(task: String, lasting: Int)]?
}
