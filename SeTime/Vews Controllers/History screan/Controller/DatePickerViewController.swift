//
//  DatePickerViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit

class DatePickerScreenViewController: UIViewController {

//    MARK: - Экземпляр MainScreen
        
    private lazy var datePickerScreen: DatePickerScreen = {
        let view = DatePickerScreen()
        view.delegate = self
        return view
    }()
    

//    MARK: - Жизненный цикл
        
    override func loadView() {
        view = datePickerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension DatePickerScreenViewController: PresentHistory {
    func pushScreen() {
        // Календарь для вычисления даты и времени
        lazy var calendar = Calendar.current

        // Извлечение компонентов из выбранной даты при помощи Calendar
        
        lazy var date: [String] = []
        
        if calendar.component(.day, from: datePickerScreen.datePicker.date) < 10 {
            date.append("0\(calendar.component(.day, from: datePickerScreen.datePicker.date))")
        } else {
            date.append("\(calendar.component(.day, from: datePickerScreen.datePicker.date))")
        }
        
        if calendar.component(.month, from: datePickerScreen.datePicker.date) < 10 {
            date.append("0\(calendar.component(.month, from: datePickerScreen.datePicker.date))")
        } else {
            date.append("\(calendar.component(.month, from: datePickerScreen.datePicker.date))")
        }
        
        date.append("\(calendar.component(.year, from: datePickerScreen.datePicker.date))")
        
        let chosenDate = date.joined(separator: ".")
        
        lazy var historyVC = HistoryScreanViewController()
        historyVC.date = chosenDate
        present(historyVC, animated: true)
    }
}
