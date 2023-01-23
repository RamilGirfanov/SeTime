//
//  ext TaskListScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 23.01.2023.
//

import UIKit

//    MARK: - Расширение UITableViewDataSource

extension TaskListScreenVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskListCell.identifier, for: indexPath) as? TaskListCell
        
        guard let tableViewCell = cell else { return UITableViewCell() }
        
        tableViewCell.pullCell(taskData: tasks[indexPath.row])
        
        return tableViewCell
    }
}

//    MARK: - Расширение UITableViewDelegate

extension TaskListScreenVC: UITableViewDelegate {
    //    Возвращает динамическую высоту ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTaskDifinition(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") {_,_,_ in
            self.deleteTask(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let restart = UIContextualAction(style: .normal, title: "") {action, view, completionHandler in
            self.startTask(index: indexPath.row)
            completionHandler(true)
        }
        
        restart.backgroundColor = mainColorTheme
        restart.image = UIImage(systemName: "play.fill")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [restart])
        
        return swipeActions
    }
}

extension TaskListScreenVC {
    func showTaskDifinition(index: Int) {
        let definitionTaskVC = DefinitionTaskScreenVC()
        definitionTaskVC.taskIndex = index
        definitionTaskVC.name = tasks[index].name
        definitionTaskVC.definition = tasks[index].definition
        definitionTaskVC.delegate = self
        present(definitionTaskVC, animated: true)
    }
    
    func startTask(index: Int) {
        let task = tasks[index]
        NotificationCenter.default.post(name: MainScreenVC.notificationStartTask, object: nil, userInfo: ["task": task])
        RealmManager.shared.deleteTaskList(index: index)
        tasks = RealmManager.shared.getTaskList()
        taskListScreen.tasksTableView.reloadData()
    }
    
    func deleteTask(index: Int) {
        RealmManager.shared.deleteTaskList(index: index)
        tasks = RealmManager.shared.getTaskList()
    }
}


extension TaskListScreenVC: TaskListProtocol {
    func addTask() {
        let taskAddVC = AddTaskScreenVC()
        taskAddVC.delegate = self
        present(taskAddVC, animated: true)
    }
}


