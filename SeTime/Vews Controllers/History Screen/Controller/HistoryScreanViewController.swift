//
//  HistoryScreanViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit
import RealmSwift

class HistoryScreenViewController: UIViewController {
    
    var date = Date()
        
//    MARK: - Экземпляр HistoryScreen

    private lazy var historyScreen: HistoryScreen = {
        let view = HistoryScreen()
        view.delegate = self
        view.historyLabel.text = getStringDate(date: date)
        return view
    }()
    
    
//    MARK: - Экземпляр модели
    
    private var day = Day()
    
    
//    MARK: - Настройка данных
    
    func setupData() {
        
        if (RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first) != nil {
            
            day = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first!
            
            historyScreen.viewForTimeReview.totalTimeDataLabel.text = timeIntToString(time: day.totalTime)
            historyScreen.viewForTimeReview.workTimeDataLabel.text = timeIntToString(time: day.workTime)
            historyScreen.viewForTimeReview.breakTimeDataLabel.text = timeIntToString(time: day.breakTime)
        } else {
            historyScreen.viewForTimeReview.totalTimeDataLabel.text = "00:00:00"
            historyScreen.viewForTimeReview.workTimeDataLabel.text = "00:00:00"
            historyScreen.viewForTimeReview.breakTimeDataLabel.text = "00:00:00"
        }
    }
    
    
//    MARK: - Жизненный цикл
            
    override func loadView() {
        view = historyScreen
        setupData()
        historyScreen.tasksTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: MainScreenViewController.notificationTaskTableView, object: nil)
    }
}


//MARK: - Протокол делегата HistoryScreen

extension HistoryScreenViewController: HistoryManager {
    func getDay() -> Day {
        day
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
    
    func deleteTask(index: Int) {
        RealmManager.shared.deleteTask(date: date, index: index)
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
