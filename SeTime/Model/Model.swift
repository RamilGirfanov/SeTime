//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 27.10.2022.
//

import Foundation
import RealmSwift

class Model {
    
    let date = getDate()
    
//    var day = Day()
    var task = Task()
    
    var workTimer = Timer()
    var breakTimer = Timer()
    var taskTimer = Timer()
    
    var workTime = 0
    var breakTime = 0
    var totalTime = 0
    var taskTime = 0
        
//    MARK: - Функция сохранения данных
    
//    private func saveDayData() {
//
//        if (RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first) != nil {
////            Если день в БД есть
//            RealmManager.shared.updateTime(date: date, workTime: workTime, breakTime: breakTime, totalTime: totalTime)
//            print("Данные времени обновились")
//        } else {
////            Если дня в БД нет
//            let day = Day()
//            day.date = date
//            day.workTime = workTime
//            day.breakTime = breakTime
//            day.totalTime = totalTime
//            day.tasks.append(task)
//            RealmManager.shared.saveDay(day: day)
//            print("Данные создались")
//        }
//    }
    
    private func saveTaskData() {
        RealmManager.shared.updateTasks(date: date, task: task)
    }
    
    
//    MARK: - Функции для управления WorkTimeManager
    
    func startWorkTimer() {
        let creationDate = Date()
        workTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.workTime = Int(Date().timeIntervalSince(creationDate))
            self.workTime += RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", self.date).first?.workTime ?? 0

//            Обновление UIView через NSNotificationCenter
            NotificationCenter.default.post(name: MainScreenViewController.notificationWorkTime, object: nil)
                        
            self.totalTime = Int(Date().timeIntervalSince(creationDate))
            self.totalTime += RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", self.date).first?.totalTime ?? 0
            
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
            self.breakTime += RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", self.date).first?.breakTime ?? 0
            
//            Обновление UIView через NSNotificationCenter
            NotificationCenter.default.post(name: MainScreenViewController.notificationBreakTime, object: nil)
            
            self.totalTime = Int(Date().timeIntervalSince(creationDate))
            self.totalTime += RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", self.date).first?.totalTime ?? 0
            
//            Обновление UIView через NSNotificationCenter
            NotificationCenter.default.post(name: MainScreenViewController.notificationTotalTime, object: nil)
        }
        breakTimer.tolerance = 0.2
        RunLoop.current.add(breakTimer, forMode: .common)
    }

    func pauseWorkTimer() {
        workTimer.invalidate()
        RealmManager.shared.updateTime(date: date, workTime: workTime, breakTime: breakTime, totalTime: totalTime)
        pauseTaskTimer()
    }
    
    func pauseBreakTimer() {
        breakTimer.invalidate()
        RealmManager.shared.updateTime(date: date, workTime: workTime, breakTime: breakTime, totalTime: totalTime)
    }

    func stop() {
        pauseWorkTimer()
        pauseBreakTimer()
//        saveDayData()
        stopTaskTimer()
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
        pauseTaskTimer()
        
//        Проверка на пустое значение времени начала задачи, если пусто - не сохранять данные и не добавлять в таблицу
        if task.duration != 0 {
            RealmManager.shared.updateTasks(date: date, task: task)

            task = Task()
            taskTimer = Timer()
            taskTime = 0
        }
    }
}
