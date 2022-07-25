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
    
    
    mutating func addStartTime() {
        
        // Календарь для вычисления даты и времени
        let calendar = Calendar.current
        // Текущая дата
        let todayDate = Date()
        
        // Извлечение компонентов из сегодняшней даты при помощи Calendar
        let hh = calendar.component(.hour, from: todayDate)
        let mm = calendar.component(.minute, from: todayDate)
        
        startTime = "\(hh):\(mm)"
    }
    
    mutating func addStopTime() {
        
        // Календарь для вычисления даты и времени
        let calendar = Calendar.current
        // Текущая дата
        let todayDate = Date()
        
        // Извлечение компонентов из сегодняшней даты при помощи Calendar
        let hh = calendar.component(.hour, from: todayDate)
        let mm = calendar.component(.minute, from: todayDate)
        
        stopTime = "\(hh):\(mm)"
    }
    
}
