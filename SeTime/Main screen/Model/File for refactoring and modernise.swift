//
//  File for refactoring and modernise.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 17.06.2022.
//

import UIKit


//MARK: - Для сохраниения даты

/*

let calendar = Calendar.current

let todayDate = Date()

// Извлечение компонентов из Data при помощи Calendar
let yyyy = calendar.component(.year, from: todayDate)
let mm = calendar.component(.month, from: todayDate)
let dd = calendar.component(.day, from: todayDate)


let dayDate = "\(yyyy)-\(mm)-\(dd)"

 */

//MARK: - Для подсчета времени

/*

let calendar = Calendar.current

// Дата начала отсчета
let startTime = Date()

//Дата окончания отсчета
let stopTime = Date()

// Расчет разницы в датах
let timeDifference = calendar.dateComponents([.hour, .minute, .second], from: startTime, to: stopTime)

// Извлечение значений и распечатка
var seconds = timeDifference.second!
var minutes = timeDifference.minute!
var hours = timeDifference.hour!

*/
