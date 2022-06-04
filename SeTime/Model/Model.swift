//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 04.06.2022.
//

import UIKit

//В этом файле будет бизнес-логика

//Структура описывающая данные дня
struct Day {
    let data: Int?
    var workTime: Int?
    var breakTime: Int?
    
//    Свойства, которые будут использоваться для наполнения массива задач за день
    var taskName: String
    var taskLasting: Int
    
//    Массив с типом данных кортеж, в кортеже продолжительность и задача
    var tasks: [(task: String, lasting: Int)]?
    
//    Добавить функцию запуска таймера времени работы
    
//    Добавить функцию запуска таймера времени отдыха
    
//    Добавить функцию остановки всех таймеров
    
//    Добавить функцию для запуска задачи
    
//    Функция добавления задачи в массив задач
    mutating func addTasks() {
        tasks?.append((task: taskName, lasting: taskLasting))
    }
    
}
