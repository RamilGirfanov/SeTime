//
//  ext MainScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import UIKit
import RealmSwift

//    MARK: - Расширение UITableViewDataSource

extension MainScreenVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentDate = getShortDate(date: Date())
        return RealmManager.shared.getTasks(date: currentDate).count
        //        RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", getShortDate(date: Date())).first?.tasks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        
        //        var tasks: [Task] = []
        //        RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", getShortDate(date: Date())).first?.tasks.forEach { tasks.append($0) }
        let currentDate = getShortDate(date: Date())
        var tasks = RealmManager.shared.getTasks(date: currentDate)
        
        cell.pullCell(taskData: tasks[indexPath.row])
        
        return cell
    }
}


//    MARK: - Расширение UITableViewDelegate

extension MainScreenVC: UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let restart = UIContextualAction(style: .normal, title: "") {action, view, completionHandler in
            self.restartTask(index: indexPath.row)
            completionHandler(true)
        }
        
        restart.backgroundColor = mainColorTheme
        restart.image = UIImage(systemName: "play.fill")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [restart])
        
        return swipeActions
    }
}

//MARK: - Протокол делегата MainScreen

extension MainScreenVC: ManageTimers {
    func startWorkTimer() {
        Model.shared.startWorkTimer()
        
        if Model.shared.task.duration != 0 {
            Model.shared.startTaskTimer()
        }
        
        Model.shared.pauseBreakTimer()
        
//        Уведоления
        notificationWorkTime()
        cancelNotification(notificationType: .breakNotice)
        
        mainScreen.addTaskButton.activeButton()
        mainScreen.stopButton.activeButton()
        
//        Работа с View
        mainScreen.workButton.isHidden = true
        mainScreen.breakButton.isHidden = false
        
        mainScreen.stopTaskButton.isEnabled = true
    }
    
    func startBreakTimer() {
        Model.shared.startBreakTimer()
        Model.shared.pauseWorkTimer()
        
//        Уведоления
        notificationBreakTime()
        cancelNotification(notificationType: .workNotice)
        
//        Работа с View
        mainScreen.addTaskButton.inactiveButton()
        
        mainScreen.workButton.isHidden = false
        mainScreen.breakButton.isHidden = true
    }
    
    func stop() {
        Model.shared.stop()
        
//        Уведоления
        cancelNotification(notificationType: .allNotice)
        
//        Работа с View
        mainScreen.addTaskButton.inactiveButton()
        mainScreen.stopButton.inactiveButton()
        
        mainScreen.workButton.isHidden = false
        mainScreen.breakButton.isHidden = true
        
        mainScreen.taskTimeTextLabel.text = NSLocalizedString("name", comment: "")
        mainScreen.taskTimeDataLabel.text = "00:00:00"
        
        mainScreen.addTaskButton.isHidden = false
        mainScreen.taskTimerView.isHidden = true
        
        mainScreen.tasksTableView.reloadData()
        
        checkDay()
    }
        
    func stopTaskTimer() {
        Model.shared.stopTaskTimer()
        
//        Работа с View
        mainScreen.taskTimeTextLabel.text = NSLocalizedString("name", comment: "")
        mainScreen.taskTimeDataLabel.text = ""
        
        mainScreen.addTaskButton.isHidden = false
        mainScreen.taskTimerView.isHidden = true
        
        mainScreen.tasksTableView.reloadData()
    }
    
    func addTask() {
        let taskAddVC = AddTaskScreenVC()
        taskAddVC.delegate = self
        present(taskAddVC, animated: true)
    }
}


//MARK: - Расширение функционала для MainScreen

extension MainScreenVC {
    func showTaskDifinition(index: Int) {
        let currentDate = getShortDate(date: Date())

        let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first!.tasks[index]
        
        let definitionTaskVC = DefinitionTaskScreenVC()
        definitionTaskVC.taskIndex = index
        definitionTaskVC.name = task.name
        definitionTaskVC.startTime = task.startTime
        definitionTaskVC.duration = timeIntToString(time: task.duration)
        definitionTaskVC.definition = task.definition
        definitionTaskVC.delegate = self
        present(definitionTaskVC, animated: true)
    }
    
    func deleteTask(index: Int) {
        RealmManager.shared.deleteTask(date: Model.shared.date,
                                       index: index)
    }
    
    func restartTask(index: Int) {
//        Получает Задачу из архива
        let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", Model.shared.date).first!.tasks[index]

//        Управляет запуском и остановкой таймеров
        if Model.shared.taskTimer.isValid {
            stopTaskTimer()
        }
        
        if !Model.shared.workTimer.isValid {
            startWorkTimer()
        }
        
//        Передает задачу в модель
        Model.shared.restartTaskTimer(index: index,
                               duration: task.duration)

//        Меняет видимости кнопки и вью задачи на главном экране
        mainScreen.addTaskButton.isHidden = true
        mainScreen.taskTimerView.isHidden = false

//        Устанавливает в лейбл задачи ее название
        mainScreen.taskTimeTextLabel.text = task.name
        mainScreen.taskTimeDataLabel.text = timeIntToString(time: task.duration)
    }

//    func getTasksData() -> [Task] {
//        var tasksArray: [Task] = []
//        RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", getShortDate(date: Date())).first?.tasks.forEach { tasksArray.append($0) }
//        return tasksArray
//    }
}
