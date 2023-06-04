//
//  HistoryScreenVC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit
import RealmSwift

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
            self.day = day
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

// MARK: - HistoryScreen Delegate

extension HistoryScreenVC {
    func showTaskDifinition(index: Int) {
        let taskDefinitionVC = DefinitionTaskScreenVC()
        
        guard let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first?.tasks[index] else { return }
        
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

// MARK: - UITableViewDataSource

extension HistoryScreenVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        day.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell
        
        guard let tableViewCell = cell else { return UITableViewCell() }
        
        tableViewCell.pullCell(taskData: day.tasks[indexPath.row])
        return tableViewCell
    }
}


// MARK: - UITableViewDelegate

extension HistoryScreenVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTaskDifinition(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") {_, _, _ in
            self.deleteTask(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}

// MARK: - DefinitionTaskScreen Delegate

extension HistoryScreenVC: EditTasksProtocol {
    func editTask(taskIndex: Int) {
        guard let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first?.tasks[taskIndex] else { return }
        
        let taskEditVC = EditTaskScreenVC()
        taskEditVC.taskIndex = taskIndex
        taskEditVC.name = task.name
        taskEditVC.definition = task.definition
        taskEditVC.delegate = self
        present(taskEditVC, animated: true)
    }
}

// MARK: - EditTaskScreen Delegate

extension HistoryScreenVC: SaveTasksProtocol {
    func saveTask(taskIndex: Int, name: String, definition: String) {
        RealmManager.shared.updateTask(
            date: date,
            index: taskIndex,
            name: name,
            definition: definition
        )
        historyScreen.tasksTableView.reloadData()
    }
}
