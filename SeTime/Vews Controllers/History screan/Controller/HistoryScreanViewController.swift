//
//  HistoryScreanViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit

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
    
    
//    MARK: - Жизненный цикл
            
    override func loadView() {
        view = historyScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupData()
    }
    
    
//    MARK: - Настройка данных
    
    func setupData() {
        guard let time = archiveOfDays[date]?.totalTime else { return }
        historyScreen.totalTimeDataLabel.text = timeIntToString(time: time)
        
        guard let time = archiveOfDays[date]?.workTime else { return }
        historyScreen.workTimeDataLabel.text = timeIntToString(time: time)
        
        guard let time = archiveOfDays[date]?.breakTime else {return}
        historyScreen.breakTimeDataLabel.text = timeIntToString(time: time)
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
