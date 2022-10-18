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
    
    @objc func tapForWork() {
        startWorkTimer()
        pauseBreakTimer()
        
        if task.duration != 0 {
            ViewController.startTaskTimer()
        }
                
        ViewController.addTaskButton.setTitleColor(.black, for: .normal)
        ViewController.addTaskButton.tintColor = .black
        ViewController.addTaskButton.backgroundColor = mainColorTheme
        ViewController.addTaskButton.layer.borderWidth = 0
        
        ViewController.addTaskButton.isEnabled = true
        
        workButton.isHidden = true
        breakButton.isHidden = false

        stopTaskButton.isEnabled = true
    }
    
//    Запускает таймер перерывов, в том числе для задачи
    @objc func tapForBreak() {
        pauseWorkTimer()
        startBreakTimer()

        workButton.isHidden = false
        breakButton.isHidden = true
        
        ViewController.addTaskButton.setTitleColor(UIColor.systemGray, for: .normal)
        ViewController.addTaskButton.tintColor = .black
        ViewController.addTaskButton.backgroundColor = .systemGray6
        ViewController.addTaskButton.layer.borderWidth = 0.5

        ViewController.addTaskButton.isEnabled = false
    }
    
//    Останавливает все таймеры, в том числе для задачи
    @objc func tapForStop() {
        stop()
        
        ViewController.addTaskButton.setTitleColor(UIColor.systemGray, for: .normal)
        ViewController.addTaskButton.tintColor = .black
        ViewController.addTaskButton.backgroundColor = .systemGray6
        ViewController.addTaskButton.layer.borderWidth = 0.5
        
        ViewController.addTaskButton.isEnabled = false
        
        workButton.isHidden = false
        breakButton.isHidden = true
    }
    
//    Запускает таймер задачи
    @objc func startTask() {
        ViewController.startTaskTimer()
    }
    
//    Останавливает таймер задачи и переносит задачу в таблицу
    @objc func stopTask() {
        stopTaskTimer()
    }
}
