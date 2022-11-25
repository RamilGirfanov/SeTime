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
}

extension DatePickerScreenViewController: PresentHistory {
    func pushScreen() {        
        let historyVC = HistoryScreenViewController()
        historyVC.date = getShortDate(date: datePickerScreen.datePicker.date)
        present(historyVC, animated: true)
    }
}
