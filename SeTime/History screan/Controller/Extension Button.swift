//
//  Extension Button.swift
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
        lazy var yyyy = calendar.component(.year, from: datePicker.date)
        lazy var mm = calendar.component(.month, from: datePicker.date)
        lazy var dd = calendar.component(.day, from: datePicker.date)

        chosenDate = "\(yyyy)-\(mm)-\(dd)"
        
        print("Выбранная дата:", chosenDate)
        
        lazy var historyVC = HistoryScreanViewController()
        historyVC.title = chosenDate
        present(historyVC, animated: true)
    }
}
