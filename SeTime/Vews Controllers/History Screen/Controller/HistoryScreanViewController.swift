//
//  HistoryScreanViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit
import RealmSwift

class HistoryScreenViewController: UIViewController {
    
    var date = ""
    
    
//    MARK: - Экземпляр HistoryScreen

    private lazy var historyScreen: HistoryScreen = {
        let view = HistoryScreen()
        view.delegate = self
        view.historyLabel.text = date
        return view
    }()
    
    
//    MARK: - Экземпляр модели
    
    private var day = Day()
    
    
//    MARK: - Настройка данных
    
    func setupData() {
        
        if (RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first) != nil {
            
            day = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first!
            
            historyScreen.totalTimeDataLabel.text = timeIntToString(time: day.totalTime)
            historyScreen.workTimeDataLabel.text = timeIntToString(time: day.workTime)
            historyScreen.breakTimeDataLabel.text = timeIntToString(time: day.breakTime)
        } else {
            historyScreen.totalTimeDataLabel.text = "-"
            historyScreen.workTimeDataLabel.text = "-"
            historyScreen.breakTimeDataLabel.text = "-"
        }
    }
    
    
//    MARK: - Жизненный цикл
            
    override func loadView() {
        view = historyScreen
        setupData()
        historyScreen.tasksTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

extension HistoryScreenViewController: GetData {
    func getDay() -> Day {
        day
    }
    
    func getDate() -> String {
        return date
    }
}
