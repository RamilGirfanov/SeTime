//
//  Task.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 25.07.2022.
//

import Foundation

struct Task {
    var taskName = ""
    var definition = ""
    var duration = 0
    
    var startTime = ""
    var stopTime = ""
    
    /*
    mutating func addStartTime() {
        
        // Календарь для вычисления даты и времени
        let calendar = Calendar.current
        // Текущая дата
        let todayDate = Date()
        
        // Извлечение компонентов из сегодняшней даты при помощи Calendar
        lazy var time: [String] = []

        if calendar.component(.hour, from: todayDate) < 10 {
            time.append("0\(calendar.component(.hour, from: todayDate))")
        } else {
            time.append("\(calendar.component(.hour, from: todayDate))")
        }
        
        if calendar.component(.minute, from: todayDate) < 10 {
            time.append("0\(calendar.component(.minute, from: todayDate))")
        } else {
            time.append("\(calendar.component(.minute, from: todayDate))")
        }
        
        startTime = time.joined(separator: ":")
        
    }
    
    mutating func addStopTime() {
        
        // Календарь для вычисления даты и времени
        let calendar = Calendar.current
        // Текущая дата
        let todayDate = Date()
        
        // Извлечение компонентов из сегодняшней даты при помощи Calendar
        lazy var time: [String] = []

        if calendar.component(.hour, from: todayDate) < 10 {
            time.append("0\(calendar.component(.hour, from: todayDate))")
        } else {
            time.append("\(calendar.component(.hour, from: todayDate))")
        }
        
        if calendar.component(.minute, from: todayDate) < 10 {
            time.append("0\(calendar.component(.minute, from: todayDate))")
        } else {
            time.append("\(calendar.component(.minute, from: todayDate))")
        }
        
        stopTime = time.joined(separator: ":")
        
    }
 */
}
