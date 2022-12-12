//
//  MainScreen Protocol.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 12.12.2022.
//

import Foundation
import RealmSwift

//MARK: - Протокол делегата MainScreen

extension MainScreenViewController: ManageTimers {
    
    func startWorkTimer() {
        model.startWorkTimer()
        
        if model.task.duration != 0 {
            model.startTaskTimer()
        }
        
        model.pauseBreakTimer()
        
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
        model.startBreakTimer()
        model.pauseWorkTimer()
        
//        Уведоления
        notificationBreakTime()
        cancelNotification(notificationType: .workNotice)
        
//        Работа с View
        mainScreen.addTaskButton.inactiveButton()
        
        mainScreen.workButton.isHidden = false
        mainScreen.breakButton.isHidden = true
    }
    
    func stop() {
        model.stop()
        
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
    }
        
    func stopTaskTimer() {
        model.stopTaskTimer()
        
//        Работа с View
        mainScreen.taskTimeTextLabel.text = NSLocalizedString("name", comment: "")
        mainScreen.taskTimeDataLabel.text = ""
        
        mainScreen.addTaskButton.isHidden = false
        mainScreen.taskTimerView.isHidden = true
        
        mainScreen.tasksTableView.reloadData()
    }
    
    func addTask() {
        let taskAddVC = AddTaskScreenViewController()
        taskAddVC.delegate = self
        present(taskAddVC, animated: true)
    }
    
    func showTaskDifinition(index: Int) {
        let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", model.date).first!.tasks[index]
        
        let definitionTaskVC = DefinitionTaskScreenViewController()
        definitionTaskVC.taskIndex = index
        definitionTaskVC.name = task.name
        definitionTaskVC.startTime = task.startTime
        definitionTaskVC.duration = timeIntToString(time: task.duration)
        definitionTaskVC.definition = task.definition
        definitionTaskVC.delegate = self
        present(definitionTaskVC, animated: true)
    }
    
    func getTasksData() -> [Task] {
        var tasksArray: [Task] = []
        RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", getShortDate(date: Date())).first?.tasks.forEach { tasksArray.append($0) }
        return tasksArray
    }
    
    func deleteTask(index: Int) {
        RealmManager.shared.deleteTask(date: model.date, index: index)
    }
    
    func restartTask(index: Int) {
//        Получает Задачу из архива
        let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", model.date).first!.tasks[index]

//        Управляет запуском и остановкой таймеров
        if model.taskTimer.isValid {
            stopTaskTimer()
        }
        
        if !model.workTimer.isValid {
            startWorkTimer()
        }
        
//        Передает задачу в модель
        model.restartTaskTimer(index: index, duration: task.duration)

//        Меняет видимости кнопки и вью задачи на главном экране
        mainScreen.addTaskButton.isHidden = true
        mainScreen.taskTimerView.isHidden = false

//        Устанавливает в лейбл задачи ее название
        mainScreen.taskTimeTextLabel.text = task.name
        mainScreen.taskTimeDataLabel.text = timeIntToString(time: task.duration)
    }
}
