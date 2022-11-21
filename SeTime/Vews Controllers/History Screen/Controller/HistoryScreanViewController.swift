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
}


//MARK: - Протокол делегата HistoryScreen

extension HistoryScreenViewController: HistoryManager {
    func getDay() -> Day {
        day
    }
    
    func getDate() -> String {
        return date
    }
    
    func showTaskDifinition(index: Int) {
        let taskDefinitionVC = DefinitionTaskScreenViewController()
        
        let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first!.tasks[index]
        
        taskDefinitionVC.taskIndex = index
        
        taskDefinitionVC.name = task.name
        taskDefinitionVC.startTime = task.startTime
        taskDefinitionVC.duration = timeIntToString(time: task.duration)
        taskDefinitionVC.definition = task.definition
        taskDefinitionVC.delegate = self
        present(taskDefinitionVC, animated: true)
    }
}


//MARK: - Протокол делегата DefinitionTaskScreen

extension HistoryScreenViewController: EditTasksProtocol {
    func editTask(taskIndex: Int) {
        
        let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first!.tasks[taskIndex]
        
        let taskEditVC = EditTaskScreenViewController()
        taskEditVC.taskIndex = taskIndex
        taskEditVC.name = task.name
        taskEditVC.definition = task.definition
        taskEditVC.delegate = self
        present(taskEditVC, animated: true)
    }
}


//MARK: - Протокол делегата EditTaskScreen

extension HistoryScreenViewController: SaveTasksProtocol {
    func saveTask(taskIndex: Int, name: String, definition: String) {
        RealmManager.shared.updateTask(date: date, index: taskIndex, name: name, definition: definition)
        historyScreen.tasksTableView.reloadData()
    }
}
