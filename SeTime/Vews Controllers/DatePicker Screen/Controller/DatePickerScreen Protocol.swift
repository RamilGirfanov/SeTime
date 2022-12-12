//
//  DatePickerScreen Protocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation

//MARK: - Протокол делегата DatePickerScreen

extension DatePickerScreenViewController: PresentHistory {
    func pushScreen() {
        let historyVC = HistoryScreenViewController()
        historyVC.date = getShortDate(date: datePickerScreen.datePicker.date)
        present(historyVC, animated: true)
    }
}
