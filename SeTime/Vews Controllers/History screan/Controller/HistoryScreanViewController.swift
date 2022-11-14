//
//  HistoryScreanViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit
import RealmSwift

class HistoryScreanViewController: UIViewController {
    
    var date = ""
    
    
//    MARK: - Экземпляр HistoryScreen

    private lazy var historyScreen: HistoryScrean = {
        let view = HistoryScrean()
        view.delegate = self
        return view
    }()
    
    
//    MARK: - Экземпляр модели
    
    private var model = Model()
    
    
//    MARK: - Настройка данных
    
    func setupData() {
        
        if (RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first) != nil {
            
            model.day = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first!
            
            historyScreen.totalTimeDataLabel.text = timeIntToString(time: model.day.totalTime)
            historyScreen.workTimeDataLabel.text = timeIntToString(time: model.day.workTime)
            historyScreen.breakTimeDataLabel.text = timeIntToString(time: model.day.breakTime)
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

extension HistoryScreanViewController: GetData {
    func getDay() -> Day {
        model.day
    }
    
    func getDate() -> String {
        return date
    }
}
