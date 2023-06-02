//
//  ViewModel.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 02.06.2023.
//

import Foundation

// MARK: - Protocol

protocol MainScreenViewModelProtocol {
    var updateWorkView: (Int) -> Void { get set }
    var updateBreakView: (Int) -> Void { get set }
    var updateTotalView: (Int) -> Void { get set }
    var updateTaskView: (Int) -> Void { get set }
    
    func startWork()
    func startBreak()
    func stopAll()
    func startTask()
    func stopTask()
    func restartTask(task: Task, taskIndex: Int)
}

// MARK: - Class

final class MainScreenViewModel: MainScreenViewModelProtocol {
    // MARK: - Model
    
    private let model = TimeManager()
    
    // MARK: - Class Properties
    
    private var workTime = 0 {
        didSet {
            updateWorkView(workTime)
        }
    }
    
    private var breakTime = 0 {
        didSet {
            updateBreakView(breakTime)
        }
    }
    
    private var totalTime = 0 {
        didSet {
            updateTotalView(totalTime)
        }
    }
    
    private var taskTime = 0 {
        didSet {
            updateTaskView(taskTime)
        }
    }
    
    // MARK: - Protocol Properties
    
    var updateWorkView: (Int) -> Void = { _ in }
    var updateBreakView: (Int) -> Void = { _ in }
    var updateTotalView: (Int) -> Void = { _ in }
    var updateTaskView: (Int) -> Void = { _ in }
    
    // MARK: - Protocol Methods
    
    func startWork() {
        model.startWorkTimer { [weak self] time in
            self?.workTime = time
            self?.totalTime += time
        }
        
        model.pauseBreakTimer()
        
        if taskTime != 0 {
            startTask()
        }
    }
    
    func startBreak() {
        model.startBreakTimer { [weak self] time in
            self?.breakTime = time
            self?.totalTime += time
        }
        
        model.pauseWorkTimer()
    }
    
    func stopAll() {
        model.stopAllTimers()
    }
    
    func startTask() {
        model.startTaskTimer { [weak self] time in
            self?.taskTime = time
        }
    }
    
    func stopTask() {
        model.stopTaskTimer()
    }
    
    func restartTask(task: Task, taskIndex: Int) {
        if UserDefaults.standard.bool(forKey: "taskTimerIsActive") {
            model.stopTaskTimer()
        }
        
        if !UserDefaults.standard.bool(forKey: "workTimerIsActive") {
            startWork()
        }
        
        model.restartTaskTimer(task: task, taskIndex: taskIndex)
    }
}
