//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 02.06.2023.
//

import Foundation

// MARK: - Protocols

protocol TimeTracker {
    func startWorkTimer(completionHandler: @escaping (Int) -> Void)
    func pauseWorkTimer()

    func startBreakTimer(completionHandler: @escaping (Int) -> Void)
    func pauseBreakTimer()

    func stopAllTimers()
}

protocol TaskTracker {
    func startTaskTimer(completionHandler: @escaping (Int) -> Void)
    func pauseTaskTimer()
    func stopTaskTimer()
    func restartTaskTimer(task: Task, taskIndex: Int)
}

protocol TrakerManager {
    func addTask() -> Task
    func contuneTask() -> Task
    func checkNewDay() -> Bool
    func reloadDay()
}

// MARK: - Class

final class TimeManager: TimeTracker, TaskTracker {
    // MARK: - Properties
    
    private var day = Day()
    private var task = Task()
    private var date = getShortDate(date: Date())
    
    private var workTimer = Timer()
    private var breakTimer = Timer()
    private var taskTimer = Timer()

    private var workTime = 0
    private var breakTime = 0
    private var totalTime: Int {
        workTime + breakTime
    }
    private var taskTime = 0
    
    private var restartStatus = false
    private var taskIndex = 0
    
    // MARK: - TimeTracker Methods
    
    func startWorkTimer(completionHandler: @escaping (Int) -> Void) {
        UserDefaults.standard.set(true, forKey: "workTimerIsActive")
        let savedTime = day.workTime
        let creationDate = Date()
        workTimer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) { [weak self] _ in
                guard let self = self else { return }
                workTime = Int(Date().timeIntervalSince(creationDate)) + savedTime
                completionHandler(workTime)
        }
        workTimer.tolerance = 0.2
    }
    
    func pauseWorkTimer() {
        workTimer.invalidate()
        UserDefaults.standard.set(false, forKey: "workTimerIsActive")
        RealmManager.shared.updateTime(
            date: date,
            workTime: workTime,
            breakTime: breakTime,
            totalTime: totalTime
        )
        pauseTaskTimer()
    }
    
    func startBreakTimer(completionHandler: @escaping (Int) -> Void) {
        UserDefaults.standard.set(true, forKey: "breakTimerIsActive")
        let savedTime = day.breakTime
        let creationDate = Date()
        breakTimer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) { [weak self] _ in
                guard let self = self else { return }
                breakTime = Int(Date().timeIntervalSince(creationDate)) + savedTime
                completionHandler(breakTime)
        }
        breakTimer.tolerance = 0.2
    }
    
    func pauseBreakTimer() {
        breakTimer.invalidate()
        UserDefaults.standard.set(false, forKey: "breakTimerIsActive")
        RealmManager.shared.updateTime(
            date: date,
            workTime: workTime,
            breakTime: breakTime,
            totalTime: totalTime
        )
    }
    
    func stopAllTimers() {
        pauseWorkTimer()
        pauseBreakTimer()
        stopTaskTimer()
    }
    
    // MARK: - TaskTraker Methods
    
    func startTaskTimer(completionHandler: @escaping (Int) -> Void) {
        UserDefaults.standard.set(true, forKey: "taskTimerIsActive")
        let savedTime = task.duration
        let creationDate = Date()
        taskTimer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) { [weak self] _ in
                guard let self = self else { return }
                taskTime = Int(Date().timeIntervalSince(creationDate)) + savedTime
                completionHandler(taskTime)
        }
        taskTimer.tolerance = 0.2
    }
    
    func pauseTaskTimer() {
        taskTimer.invalidate()
        UserDefaults.standard.set(false, forKey: "taskTimerIsActive")
        task.duration = taskTime
    }
    
    func stopTaskTimer() {
        pauseTaskTimer()
        restartStatus ? updateTask() : saveTask()
    }
    
    func restartTaskTimer(task: Task, taskIndex: Int) {
        self.task = task
        restartStatus = true
        self.taskIndex = taskIndex
        startTaskTimer(completionHandler: <#T##(Int) -> Void#>)
    }
    
    // MARK: - Private Methods
    
    private func saveTask() {
        task.date = date
        
        RealmManager.shared.addTask(date: date, task: task)
        
        task = Task()
        taskTimer = Timer()
        taskTime = 0
    }
    
    private func updateTask() {
        RealmManager.shared.updateTaskDuration(
            date: task.date,
            index: taskIndex,
            duration: task.duration
        )
        
        task = Task()
        taskTimer = Timer()
        taskTime = 0
        restartStatus = false
    }
}
