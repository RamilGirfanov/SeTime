//
//  ext HistoryScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import UIKit
import RealmSwift

//MARK: - Протокол делегата HistoryScreen

extension HistoryScreenVC {
    func showTaskDifinition(index: Int) {
        let taskDefinitionVC = DefinitionTaskScreenVC()
        
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


//    MARK: - Расширение UITableViewDataSource

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


//    MARK: - Расширение UITableViewDelegate

extension HistoryScreenVC: UITableViewDelegate {
    //    Возвращает динамическую высоту ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTaskDifinition(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("delete", comment: "")) {_,_,_ in
            self.deleteTask(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeActions
    }
}
