//
//  File for refactoring and modernise.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 17.06.2022.
//

import Foundation

// свойство календарь для корректного извлечения значений из типа Date
let calendar = Calendar.current

// Дата начала отсчета
let date = Date()

print(date)
print(calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))

// Извлечение компонентов из Data при помощи Calendar
let y = calendar.component(.year, from: date)
let m = calendar.component(.month, from: date)
let d = calendar.component(.day, from: date)

print("\(y)-\(m)-\(d)")



//Дата окончания отсчета
let stopTime = Date()

print(stopTime)

// Расчет разницы в датах
let timeDifference = calendar.dateComponents([.hour, .minute, .second], from: stopTime, to: date)
// Извлечение значений и распечатка
print(-timeDifference.second!)
print(-timeDifference.minute!)
print(-timeDifference.hour!)

