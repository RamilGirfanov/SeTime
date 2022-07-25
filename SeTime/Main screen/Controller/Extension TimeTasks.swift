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
    
//    func newDay()
        
    func startWorkTimer()
    func startBreakTimer()
        
    func pauseWorkTimer()
    func pauseBreakTimer()
    
    func stop()
        
    func stopTaskTimer()
        
//    func endOfDay()

}

//MARK: - Расширение для управления

extension ViewController: TimeTasksManagement {
    
    func newDay() {
        
        ///Остановка всех таймеров
        ///Запись в архив
        ///Инициировние нового дня
        
        day = Day()
    }
    
//    Запускает таймер работы
    func startWorkTimer() {
        workTimeManager.workTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in
            day.workTime += 1
            
            if day.workTime < 60 {
                workTimeDataLabel.text = "\(day.workTime)с"
            } else if day.workTime < 3600 {
                workTimeDataLabel.text = "\(day.workTime / 60)м \(day.workTime % 60)с"
            } else {
                workTimeDataLabel.text = "\(day.workTime / 3600)ч \((day.workTime % 3600) / 60)м"
            }
            
            if day.totalTime < 60 {
                totalTimeDataLabel.text = "\(day.totalTime)с"
            } else if day.totalTime < 3600 {
                totalTimeDataLabel.text = "\(day.totalTime / 60)м \(day.totalTime % 60)с"
            } else {
                totalTimeDataLabel.text = "\(day.totalTime / 3600)ч \((day.totalTime % 3600) / 60)м"
            }
            
        })
    }
    
//    Запускает таймер перерывов
    func startBreakTimer() {
        workTimeManager.breakTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in
            day.breakTime += 1
            
            if day.breakTime < 60 {
                breakTimeDataLabel.text = "\(day.breakTime)с"
            } else if day.breakTime < 3600 {
                breakTimeDataLabel.text = "\(day.breakTime / 60)м \(day.breakTime % 60)с"
            } else {
                breakTimeDataLabel.text = "\(day.breakTime / 3600)ч \((day.breakTime % 3600) / 60)м"
            }
            
            if day.totalTime < 60 {
                totalTimeDataLabel.text = "\(day.totalTime)с"
            } else if day.totalTime < 3600 {
                totalTimeDataLabel.text = "\(day.totalTime / 60)м \(day.totalTime % 60)с"
            } else {
                totalTimeDataLabel.text = "\(day.totalTime / 3600)ч \((day.totalTime % 3600) / 60)м"
            }
        })
    }
    
//    Пауза для таймера работы
    func pauseWorkTimer() {
        workTimeManager.workTimer.invalidate()
    }
    
//    Пауза для таймера перерывов
    func pauseBreakTimer() {
        workTimeManager.breakTimer.invalidate()
    }

//    Пауза для обоих таймеров
    func stop() {
        workTimeManager.workTimer.invalidate()
        workTimeManager.breakTimer.invalidate()
    }
    
//    Для создания новой задачи
    func stopTaskTimer() {

        taskTimeManager.taskTimer.invalidate()
        
        task.addStopTime()
        
        
//        Добавление задачи в массив задач дня
        day.tasks.append(task)
        
//        Обнуление объекта задачи
        task = Task()
        
//        Обнуление объекта таймера для задач
        taskTimeManager = TaskTimeManager()
                
//        Добавление новой строки таблицы
        tasksTableView.beginUpdates()
        tasksTableView.insertRows(at: [(NSIndexPath(row: day.tasks.count-1, section: 0) as IndexPath)], with: .automatic)
        tasksTableView.endUpdates()
        
//        Обнуление значений лейблов данных задачи
        ViewController.taskTimeTextLabel.text = "Название"
        ViewController.taskTimeDataLabel.text = "0с"
        
        ViewController.addTaskButton.isHidden = false
        
        ViewController.taskTimerView.isHidden = true
        
    }

    
    
//    func endOfDay() {
//
//    }
    
}

