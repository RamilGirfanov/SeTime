//
//  Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 02.06.2023.
//

import Foundation

// MARK: - Protocols

protocol TimeTracker {
    func startWorkTimer()
    func pauseWorkTimer()
    
    func startBreakTimer()
    func pauseBreakTimer()
    
    func stopAllTimers()
}

protocol TaskTracker {
    func addTask(name: String, definition: String)
    func startTaskTimer()
    func pauseTaskTimer()
    func stopTaskTimer()
    func restartTaskTimer(duration: Int, taskIndex: Int)
}

// MARK: - Class

final class TimeManager: TimeTracker, TaskTracker {
    
    // MARK: - Private Propertiees
    
    private var workTimer = Timer()
    private var breakTimer = Timer()
    private var taskTimer = Timer()
    
    private var workTime = 0
    private var breakTime = 0
    private var totalTime = 0
    private var taskTime = 0

    private var restartStatus = false
    private var taskIndex = 0
    
    // MARK: - Public Properties
    
    var day: Day {
        didSet {
            workTime = day.workTime
            breakTime = day.breakTime
            totalTime = day.totalTime
        }
    }
    
    var task = Task() {
        didSet {
            taskTime = task.duration
        }
    }
    
    var date = getShortDate(date: Date())
    
    // Для обновления данных во ViewModel
    var updateTimeInViewModel: (Int, Int, Int) -> Void = { _, _, _ in }
    var updateTaskTimeInViewModel: (Int) -> Void = { _ in }
    
    // MARK: - Init
    
    init(
        day: Day
    ) {
        self.day = day
    }
        
    // MARK: - TimeTracker Methods
    
    func startWorkTimer() {
        updateTimeInManager()
        UserDefaults.standard.set(true, forKey: "workTimerIsActive")
        let savedTime = day.workTime
        let creationDate = Date()
        workTimer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) { [weak self] _ in
                guard let self = self else { return }
                workTime = Int(Date().timeIntervalSince(creationDate)) + savedTime
                totalTime = workTime + breakTime
                updateTimeInViewModel(workTime, breakTime, totalTime)
        }
        workTimer.tolerance = 0.2
        
        if taskTime != 0 {
            startTaskTimer()
        }
    }
    
    func startBreakTimer() {
        updateTimeInManager()
        UserDefaults.standard.set(true, forKey: "breakTimerIsActive")
        let savedTime = day.breakTime
        let creationDate = Date()
        breakTimer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) { [weak self] _ in
                guard let self = self else { return }
                breakTime = Int(Date().timeIntervalSince(creationDate)) + savedTime
                totalTime = workTime + breakTime
                updateTimeInViewModel(workTime, breakTime, totalTime)
        }
        breakTimer.tolerance = 0.2
    }
    
    func pauseWorkTimer() {
        workTimer.invalidate()
        pauseTaskTimer()
        UserDefaults.standard.set(false, forKey: "workTimerIsActive")
        RealmManager.shared.updateTime(
            date: date,
            workTime: workTime,
            breakTime: breakTime,
            totalTime: totalTime
        )
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
    
    func addTask(name: String, definition: String) {
        task.name = name
        task.definition = definition
        task.startTime = getTime()
    }
    
    func startTaskTimer() {
        UserDefaults.standard.set(true, forKey: "taskTimerIsActive")
        let savedTime = task.duration
        let creationDate = Date()
        taskTimer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) { [weak self] _ in
                guard let self = self else { return }
                taskTime = Int(Date().timeIntervalSince(creationDate)) + savedTime
                updateTaskTimeInViewModel(taskTime)
        }
        taskTimer.tolerance = 0.2
    }
    
    func pauseTaskTimer() {
        taskTimer.invalidate()
        UserDefaults.standard.set(false, forKey: "taskTimerIsActive")
        task.duration = taskTime
    }
    
    func stopTaskTimer() {
        guard taskTime != 0 else { return }
        pauseTaskTimer()
        if restartStatus {
            updateTask()
        } else {
            saveTask()
        }
        task = Task()
        taskTimer = Timer()
        taskTime = 0
    }
    
    func restartTaskTimer(duration: Int, taskIndex: Int) {
        stopTaskTimer()
        restartStatus = true
        self.taskIndex = taskIndex
        self.task.duration = duration
        startTaskTimer()
    }
    
    // MARK: - Private Methods
    
    private func updateTimeInManager() {
        if let day = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", date).first {
            self.day = day
        }
    }
    
    private func saveTask() {
        task.date = date
        RealmManager.shared.addTask(date: date, task: task)
    }
    
    private func updateTask() {
        RealmManager.shared.updateTaskDuration(
            date: date,
            index: taskIndex,
            duration: task.duration
        )
        restartStatus = false
    }
}
