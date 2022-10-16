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
    
//    Запускает таймер работы, останавливает таймер перерывов
    @objc func tapForWork() {
        startWorkTimer()
        pauseBreakTimer()
        
        workButton.isHidden = true
        breakButton.isHidden = false
        
        ViewController.addTaskButton.isEnabled = true

        startTaskButton.isHidden = false
        startTaskButton.isEnabled = true
//        stopTaskButton.isHidden = false
    }
    
//    Запускает таймер перерывов, в том числе для задачи
    @objc func tapForBreak() {
        pauseWorkTimer()
        startBreakTimer()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        ViewController.addTaskButton.isEnabled = false

        taskTimeManager.taskTimer.invalidate()
        startTaskButton.isHidden = false
        startTaskButton.isEnabled = false
        stopTaskButton.isHidden = true
    }
    
//    Останавливает все таймеры, в том числе для задачи
    @objc func tapForStop() {
        stop()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        ViewController.addTaskButton.isEnabled = false
    }
    
//    Запускает таймер задачи
    @objc func startTask() {
        ViewController.startTaskTimer()
        startTaskButton.isHidden = true
        stopTaskButton.isHidden = false
    }
    
//    Останавливает таймер задачи и переносит задачу в таблицу
    @objc func stopTask() {
        stopTaskTimer()
    }
    
}
