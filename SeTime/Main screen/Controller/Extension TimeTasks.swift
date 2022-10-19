//
//  Extention.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 15.06.2022.
//

/// В этом файле: расширяется ViewController для управления таймерами в объекте модели и для создания новой задачи

import UIKit

//MARK: - Протокол для управления

protocol TimeTasksManagement {
    
    func checkDay()
        
    func startWorkTimer()
    func startBreakTimer()
        
    func pauseWorkTimer()
    func pauseBreakTimer()
    
    func stop()
        
    func stopTaskTimer()
}

//MARK: - Расширение для управления

extension ViewController: TimeTasksManagement {
    
    private func oldDay(date: String) {
        
        let currentDay = archiveOfDays[date]!
        
        day = currentDay
        
        workTimeDataLabel.text = timeIntToString(time: currentDay.workTime)
        breakTimeDataLabel.text = timeIntToString(time: currentDay.breakTime)
        totalTimeDataLabel.text = timeIntToString(time: currentDay.totalTime)
        tasksTableView.reloadData()
    }
    
    private func newDay(date: String) {
        
//        Проверка на пустое значение времени начала задачи, если пусто - не добавлять в таблицу
        if task.startTime.isEmpty == false {
            stopTaskTimer()
        }
                
//        Инициирование нового дня
        workTimeManager = WorkTimeManager()
        taskTimeManager = TaskTimeManager()
        task = Task()
        day = Day()
        lastDate = date
        
//        Настройка видимости кнопок "Работа", "Отдых", "Добавить задачу"
        workButton.isHidden = false
        breakButton.isHidden = true
        ViewController.addTaskButton.isEnabled = false
        
//        Очистка экрана от данных
        workTimeDataLabel.text = "-"
        breakTimeDataLabel.text = "-"
        totalTimeDataLabel.text = "-"
        
        tasksTableView.reloadData()
    }
    
    func checkDay() {
        guard !workTimeManager.workTimer.isValid && !workTimeManager.breakTimer.isValid else { return }
        
        let currentDate = getDate()

        if currentDate == lastDate {
            oldDay(date: currentDate)
        } else {
            newDay(date: currentDate)
        }
    }
   
    private func saveData() {
        if archiveOfDays[day.date] == nil {
            addDayToArchive(day: day)
        } else {
            var archiveDay = archiveOfDays[day.date]!
            archiveDay.workTime = day.workTime
            archiveDay.breakTime = day.breakTime
            archiveDay.tasks = day.tasks
            archiveOfDays[day.date] = archiveDay
        }
    }
    
    
//    MARK: - Функции для управления WorkTimeManager
    
    func startWorkTimer() {
        let creationDate = Date()
        workTimeManager.workTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            workTimeManager.workTime = Int(Date().timeIntervalSince(creationDate))
            workTimeManager.workTime += day.workTime
            workTimeManager.totalTime = Int(Date().timeIntervalSince(creationDate))
            workTimeManager.totalTime += day.totalTime
            
            self.workTimeDataLabel.text = timeIntToString(time: workTimeManager.workTime)
            self.totalTimeDataLabel.text = timeIntToString(time: workTimeManager.totalTime)
        }
        workTimeManager.workTimer.tolerance = 0.2
        RunLoop.current.add(workTimeManager.workTimer, forMode: .common)
    }
    
    func startBreakTimer() {
        let creationDate = Date()
        workTimeManager.breakTimer = Timer(timeInterval: 1, repeats: true) { _ in
            
            workTimeManager.breakTime = Int(Date().timeIntervalSince(creationDate))
            workTimeManager.breakTime += day.breakTime
            workTimeManager.totalTime = Int(Date().timeIntervalSince(creationDate))
            workTimeManager.totalTime += day.totalTime
            
            self.breakTimeDataLabel.text = timeIntToString(time: workTimeManager.breakTime)
            self.totalTimeDataLabel.text = timeIntToString(time: workTimeManager.totalTime)
        }
        workTimeManager.breakTimer.tolerance = 0.2
        RunLoop.current.add(workTimeManager.breakTimer, forMode: .common)
    }

    func pauseWorkTimer() {
        workTimeManager.workTimer.invalidate()
        day.workTime = workTimeManager.workTime
        pauseTaskTimer()
    }
    
    func pauseBreakTimer() {
        workTimeManager.breakTimer.invalidate()
        day.breakTime = workTimeManager.breakTime
    }

    func stop() {
        pauseWorkTimer()
        pauseBreakTimer()
        stopTaskTimer()
        saveData()
    }

    
//    MARK: - Функции для управления TaskTimeManager
    
    static func startTaskTimer() {
        let creationDate = Date()
        taskTimeManager.taskTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            taskTimeManager.taskTime = Int(Date().timeIntervalSince(creationDate))
            taskTimeManager.taskTime += task.duration
            taskTimeDataLabel.text = timeIntToString(time: taskTimeManager.taskTime)
        }
        taskTimeManager.taskTimer.tolerance = 0.2
        RunLoop.current.add(taskTimeManager.taskTimer, forMode: .common)
    }
    
    func pauseTaskTimer() {
        taskTimeManager.taskTimer.invalidate()
        task.duration = taskTimeManager.taskTime
    }
    
    func stopTaskTimer() {
        
//        Останавливает таймер задачи и сохраняет данные
        taskTimeManager.taskTimer.invalidate()
        task.duration = taskTimeManager.taskTime
        
//        Проверка на пустое значение времени начала задачи, если пусто - не добавлять в таблицу
        if task.duration != 0 {
            day.tasks.append(task)
            tasksTableView.reloadData()

            task = Task()
            taskTimeManager = TaskTimeManager()
            
            ViewController.taskTimeTextLabel.text = "Название"
            ViewController.taskTimeDataLabel.text = "-"
            
            ViewController.addTaskButton.isHidden = false
            ViewController.taskTimerView.isHidden = true
        }
    }
}

