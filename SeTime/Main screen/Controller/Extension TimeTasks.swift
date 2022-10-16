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
//        Если таймеры остановлены
        guard !workTimeManager.workTimer.isValid && !workTimeManager.breakTimer.isValid else { return }
        
        let currentDate = getDate()

        if currentDate == lastDate {
            oldDay(date: currentDate)
        } else {
            newDay(date: currentDate)
        }
    }
   
    /*
    
//    Будет проверяться во viewWillAppear
    func checkNewDay() {
        
        // Календарь для вычисления даты и времени
        let calendar = Calendar.current
        // Текущая дата
        let todayDate = Date()

        let date = calendar.dateComponents([.day, .month, .year], from: todayDate)

        let currentDate = "\(date.day!).\(date.month!).\(date.year!)"
        
        guard currentDate != lastDate else { return }
        guard !workTimeManager.workTimer.isValid && !workTimeManager.breakTimer.isValid else { return }
        
//        Проверка на пустое значение времени начала задачи, если пусто - не добавлять в таблицу
        if task.startTime.isEmpty == false {
            stopTaskTimer()
        }
        
//        Запись дня в архив
        addDayToArchive(day: day)
        
//        Инициирование нового дня
        workTimeManager = WorkTimeManager()
        taskTimeManager = TaskTimeManager()
        task = Task()
        day = Day()
        lastDate = currentDate
        
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
     */
    
//    Запускает таймер работы
    func startWorkTimer() {
        workTimeManager.workTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            day.workTime += 1
            self.workTimeDataLabel.text = timeIntToString(time: day.workTime)
            self.totalTimeDataLabel.text = timeIntToString(time: day.totalTime)
        }
        RunLoop.current.add(workTimeManager.workTimer, forMode: .common)
    }
    
//    Запускает таймер перерывов
    func startBreakTimer() {
        workTimeManager.breakTimer = Timer(timeInterval: 1, repeats: true) { _ in
            day.breakTime += 1
            self.breakTimeDataLabel.text = timeIntToString(time: day.breakTime)
            self.totalTimeDataLabel.text = timeIntToString(time: day.totalTime)
        }
        RunLoop.current.add(workTimeManager.breakTimer, forMode: .common)
    }
    
//    Запускает таймер задачи
    static func startTaskTimer() {
        taskTimeManager.taskTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            task.duration += 1
            taskTimeDataLabel.text = timeIntToString(time: task.duration)
        }
    }

//    Пауза для таймера работы
    func pauseWorkTimer() {
        workTimeManager.workTimer.invalidate()
        pauseTaskTimer()
    }
    
//    Пауза для таймера перерывов
    func pauseBreakTimer() {
        workTimeManager.breakTimer.invalidate()
    }
    
    
    func pauseTaskTimer() {
        taskTimeManager.taskTimer.invalidate()
    }
    

//    Пауза для обоих таймеров
    func stop() {
        pauseWorkTimer()
        pauseBreakTimer()
        
//        Проверка на пустое значение времени начала задачи, если пусто - не добавлять в таблицу
        if task.duration != 0 {
            stopTaskTimer()
        }
        
        if archiveOfDays[day.date] != nil {
            addDayToArchive(day: day)
        }
        

    }
    
//    Остановка таймера задачи
    func stopTaskTimer() {
        
//        Останавливает таймер задачи и устанавливает время конца задачи
        taskTimeManager.taskTimer.invalidate()
        task.stopTime = getDate()
        
//        Добавление задачи в массив задач дня
        day.tasks.append(task)
        
//        Обнуление объекта задачи
        task = Task()
        
//        Обнуление объекта таймера для задач
        taskTimeManager = TaskTimeManager()
                
//        Добавление новой строки таблицы
        tasksTableView.reloadData()
//        tasksTableView.beginUpdates()
//        tasksTableView.insertRows(at: [(NSIndexPath(row: day.tasks.count-1, section: 0) as IndexPath)], with: .automatic)
//        tasksTableView.endUpdates()
        
//        Обнуление значений лейблов данных задачи
        ViewController.taskTimeTextLabel.text = "Название"
        ViewController.taskTimeDataLabel.text = "0с"
        
//        Меняет видимости кнопки и вью задачи на главном экране
        ViewController.addTaskButton.isHidden = false
        ViewController.taskTimerView.isHidden = true
    }
    
}

