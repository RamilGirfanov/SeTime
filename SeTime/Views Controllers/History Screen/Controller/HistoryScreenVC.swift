//
//  HistoryScreenVC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit

final class HistoryScreenVC: UIViewController {
    var date = Date()
    
    // MARK: - Экземпляр HistoryScreen
    
    lazy var historyScreen: HistoryScreen = {
        let view = HistoryScreen()
        view.tasksTableView.dataSource = self
        view.tasksTableView.delegate = self
        view.historyLabel.text = getStringDate(date: date)
        return view
    }()
    
    
    // MARK: - Экземпляр модели
    
    var day = Day()
    
    
    // MARK: - Настройка данных
    
    func setupData() {
        if let day = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first {
            historyScreen.viewForTimeReview.totalTimeDataLabel.text = timeIntToString(time: day.totalTime)
            historyScreen.viewForTimeReview.workTimeDataLabel.text = timeIntToString(time: day.workTime)
            historyScreen.viewForTimeReview.breakTimeDataLabel.text = timeIntToString(time: day.breakTime)
        } else {
            historyScreen.viewForTimeReview.totalTimeDataLabel.text = "00:00:00"
            historyScreen.viewForTimeReview.workTimeDataLabel.text = "00:00:00"
            historyScreen.viewForTimeReview.breakTimeDataLabel.text = "00:00:00"
        }
    }
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = historyScreen
        setupData()
        historyScreen.tasksTableView.reloadData()
    }
}
