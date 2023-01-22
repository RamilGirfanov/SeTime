//
//  ext DatePickerScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation

//MARK: - Протокол делегата DatePickerScreen

extension DatePickerScreenVC: PresentHistory {
    func pushScreen() {
        let historyVC = HistoryScreenVC()
        historyVC.date = getShortDate(date: datePickerScreen.datePicker.date)
        present(historyVC, animated: true)
    }
}
