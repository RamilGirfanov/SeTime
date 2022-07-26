//
//  Extension Buttons.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 02.07.2022.
//

import UIKit

//    MARK: - Настройка таргетов кнопок

extension ViewController {
    
    func setupButtons() {
        workButton.addTarget(self, action: #selector(tapForWork), for: .touchUpInside)
        breakButton.addTarget(self, action: #selector(tapForBreak), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(tapForStop), for: .touchUpInside)
        startTaskButton.addTarget(self, action: #selector(startTask), for: .touchUpInside)
        stopTaskButton.addTarget(self, action: #selector(stopTask), for: .touchUpInside)
    }
    
//    Запускает таймер работы и опционально таймер задачи
    @objc func tapForWork() {
        startWorkTimer()
        pauseBreakTimer()
        
        workButton.isHidden = true
        breakButton.isHidden = false
                
        startTaskButton.isEnabled = true

        ViewController.addTaskButton.isEnabled = true
    }
    
//    Запускает таймер перерывов, в том числе для всех задач
    @objc func tapForBreak() {
        pauseWorkTimer()
        startBreakTimer()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        taskTimeManager.taskTimer.invalidate()
        startTaskButton.isHidden = false
        startTaskButton.isEnabled = false
        stopTaskButton.isHidden = true
        
        ViewController.addTaskButton.isEnabled = false
    }
    
//    Останавливает все таймеры, в том числе для задачи
    @objc func tapForStop() {
        stop()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        if task.startTime.isEmpty == false {
            stopTaskTimer()
        }
        
        ViewController.addTaskButton.isEnabled = false
    }
    
    @objc func startTask() {
        taskTimeManager.startTaskTimer()
        startTaskButton.isHidden = true
        stopTaskButton.isHidden = false
    }
    
//    Переносит задачу в таблицу
    @objc func stopTask() {
        stopTaskTimer()
    }
    
}
