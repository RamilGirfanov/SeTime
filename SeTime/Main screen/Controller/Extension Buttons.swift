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
        stopTaskButton.addTarget(self, action: #selector(stopTask), for: .touchUpInside)
    }
    
//    Запускает таймер работы
    @objc func tapForWork() {
        startWorkTimer()
        pauseBreakTimer()
        
        workButton.isHidden = true
        breakButton.isHidden = false
        
        if task.duration != 0 {
            taskTimeManager.startTaskTimer()
        }
    }
    
//    Запускает таймер перерывов, в том числе для всех задач
    @objc func tapForBreak() {
        pauseWorkTimer()
        startBreakTimer()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        taskTimeManager.taskTimer.invalidate()
    }
    
    //    Останавливает все таймеры, в том числе для задачи
    @objc func tapForStop() {
        stop()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        stopTaskTimer()

    }
    
//    Создает новую строку задачи
    @objc func stopTask() {
        stopTaskTimer()
    }
    
}
