//
//  PushHistoryScrean.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 02.07.2022.
//

import UIKit


//    MARK: - Настройка таргета кнопки

extension DatePickerViewController {
    
    func setupButton() {
        showButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @objc private func tap() {
        
        // Календарь для вычисления даты и времени
        lazy var calendar = Calendar.current

        // Извлечение компонентов из выбранной даты при помощи Calendar
        
        lazy var date: [String] = []
        
        if calendar.component(.day, from: datePicker.date) < 10 {
            date.append("0\(calendar.component(.day, from: datePicker.date))")
        } else {
            date.append("\(calendar.component(.day, from: datePicker.date))")
        }
        
        if calendar.component(.month, from: datePicker.date) < 10 {
            date.append("0\(calendar.component(.month, from: datePicker.date))")
        } else {
            date.append("\(calendar.component(.month, from: datePicker.date))")
        }
        
        date.append("\(calendar.component(.year, from: datePicker.date))")
        
        chosenDate = date.joined(separator: ".")
                
        lazy var historyVC = HistoryScreanViewController()
        historyVC.historyLabel.text = chosenDate
        present(historyVC, animated: true)
    }
}
