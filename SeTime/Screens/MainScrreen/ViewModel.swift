//
//  ViewModel.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 02.06.2023.
//

import Foundation

// MARK: - Protocol

protocol MainScreenViewModelProtocol {
    func startWork()
    func startBreak()
    func stopAll()
    func addTask(name: String, definition: String)
    func startTask()
    func stopTask()
    func restartTask(duration: Int, taskIndex: Int)
    func setDay(day: Day)
}

// MARK: - Class

final class MainScreenViewModel: MainScreenViewModelProtocol {
    
    // MARK: - Model
    
    private let model: TimeManager
    
    // MARK: - Public Properties
        
    var date = getShortDate(date: Date())
    
    var workTime = "" {
        didSet {
            NotifiCenter.shared.post(name: NotifiCenter.notificationUpdateTime, object: nil)
        }
    }
    
    var breakTime = "" {
        didSet {
            NotifiCenter.shared.post(name: NotifiCenter.notificationUpdateTime, object: nil)
        }
    }
    
    var totalTime = "" {
        didSet {
            NotifiCenter.shared.post(name: NotifiCenter.notificationUpdateTime, object: nil)
        }
    }
    
    var taskTime = "" {
        didSet {
            NotifiCenter.shared.post(name: NotifiCenter.notificationTaskTime, object: nil)
        }
    }
    
    // MARK: - Init
    
    init(model: TimeManager) {
        self.model = model
        
        self.model.updateTimeInViewModel = { [weak self] workTime, breakTime, totalTime in
            self?.workTime = timeIntToString(time: workTime)
            self?.breakTime = timeIntToString(time: breakTime)
            self?.totalTime = timeIntToString(time: totalTime)
        }
        
        self.model.updateTaskTimeInViewModel = { [weak self] taskTime in
            self?.taskTime = timeIntToString(time: taskTime)
        }
    }
    
    // MARK: - Protocol Methods
    
    func startWork() {
        model.pauseBreakTimer()
        model.startWorkTimer()
    }
    
    func startBreak() {
        model.pauseWorkTimer()
        model.startBreakTimer()
    }
    
    func stopAll() {
        model.stopAllTimers()
    }
    
    func addTask(name: String, definition: String) {
        if !UserDefaults.standard.bool(forKey: "workTimerIsActive") {
            startWork()
        }
        
        if UserDefaults.standard.bool(forKey: "taskTimerIsActive") {
            model.stopTaskTimer()
        }

        model.addTask(name: name, definition: definition)
        startTask()
    }
    
    func startTask() {
        model.startTaskTimer()
    }
    
    func stopTask() {
        model.stopTaskTimer()
    }
    
    func restartTask(duration: Int, taskIndex: Int) {
        if !UserDefaults.standard.bool(forKey: "workTimerIsActive") {
            startWork()
        }
        model.restartTaskTimer(duration: duration, taskIndex: taskIndex)
    }
    
    func setDay(day: Day) {
        model.day = day
    }
}
