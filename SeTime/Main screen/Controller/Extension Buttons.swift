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
        taskButton.addTarget(self, action: #selector(tapForTask), for: .touchUpInside)
    }
    
    @objc func tapForWork() {
        startWorkTimer()
        pauseBreakTimer()
        
        workButton.isHidden = true
        breakButton.isHidden = false
    }
    
    @objc func tapForBreak() {
        pauseWorkTimer()
        startBreakTimer()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        for i in arrayOfCells {
            i.stopTaskTimer()
        }
    }
    
    @objc func tapForStop() {
        stop()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        for i in arrayOfCells {
            i.stopTaskTimer()
        }
    }
    
    @objc func tapForTask() {
        newTask()
        textFieldForTasks.text = ""
    }
    
}
