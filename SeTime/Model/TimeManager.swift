//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 27.10.2022.
//

import Foundation
import RealmSwift

class Model {
    
    var day = Day()
    var task = Task()
    
    var workTimer = Timer()
    var breakTimer = Timer()
    var taskTimer = Timer()
    
    var workTime = 0
    var breakTime = 0
    var totalTime = 0
    var taskTime = 0
        
//    MARK: - Функция сохранения данных
    
    private func saveData() {
        
        
        let daysInRealm = RealmManager.shared.localRealm.objects(Day.self).where {
            $0.date == getDate()
        }
        
        if daysInRealm.count != 0 {
            RealmManager.shared.updateDay(day: day)
        } else {
            RealmManager.shared.saveDay(day: day)
        }
    }
    
    
//    MARK: - Функции для управления WorkTimeManager
    
    func startWorkTimer() {
        let creationDate = Date()
        workTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.workTime = Int(Date().timeIntervalSince(creationDate))
            self.workTime += self.day.workTime

//            Обновление UIView через NSNotificationCenter
            NotificationCenter.default.post(name: MainScreenViewController.notificationWorkTime, object: nil)
                        
            self.totalTime = Int(Date().timeIntervalSince(creationDate))
            self.totalTime += self.day.totalTime
            
//            Обновление UIView через NSNotificationCenter
            NotificationCenter.default.post(name: MainScreenViewController.notificationTotalTime, object: nil)
        }
        workTimer.tolerance = 0.2
        RunLoop.current.add(workTimer, forMode: .common)
    }
    
    func startBreakTimer() {
        let creationDate = Date()
        breakTimer = Timer(timeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.breakTime = Int(Date().timeIntervalSince(creationDate))
            self.breakTime += self.day.breakTime
            
//            Обновление UIView через NSNotificationCenter
            NotificationCenter.default.post(name: MainScreenViewController.notificationBreakTime, object: nil)
            
            self.totalTime = Int(Date().timeIntervalSince(creationDate))
            self.totalTime += self.day.totalTime
            
//            Обновление UIView через NSNotificationCenter
            NotificationCenter.default.post(name: MainScreenViewController.notificationTotalTime, object: nil)
        }
        breakTimer.tolerance = 0.2
        RunLoop.current.add(breakTimer, forMode: .common)
    }

    func pauseWorkTimer() {
        workTimer.invalidate()
        day.workTime = workTime
        pauseTaskTimer()
    }
    
    func pauseBreakTimer() {
        breakTimer.invalidate()
        day.breakTime = breakTime
    }

    func stop() {
        pauseWorkTimer()
        pauseBreakTimer()
        stopTaskTimer()
        saveData()
    }

    
//    MARK: - Функции для управления TaskTimeManager
    
    func startTaskTimer() {
        let creationDate = Date()
        taskTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.taskTime = Int(Date().timeIntervalSince(creationDate))
            self.taskTime += self.task.duration
                        
//            Обновление UIView через NSNotificationCenter
            NotificationCenter.default.post(name: MainScreenViewController.notificationTaskTime, object: nil)
        }
        taskTimer.tolerance = 0.2
        RunLoop.current.add(taskTimer, forMode: .common)
    }
    
    func pauseTaskTimer() {
        taskTimer.invalidate()
        task.duration = taskTime
    }
    
    func stopTaskTimer() {
        
//        Останавливает таймер задачи и сохраняет данные
        taskTimer.invalidate()
        task.duration = taskTime
        
//        Проверка на пустое значение времени начала задачи, если пусто - не добавлять в таблицу
        if task.duration != 0 {
            day.tasks.append(task)

            task = Task()
            
            taskTimer = Timer()
            taskTime = 0
        }
    }
}
