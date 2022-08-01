//
//  Extention.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 15.06.2022.
//

/// В этом файле: расширяется ViewController для управления таймерами в объекте модели и для создания новой задачи

import UIKit

//MARK: - Протокол для управления

protocol TimeTasksManagement {
    
    func newDay()
        
    func startWorkTimer()
    func startBreakTimer()
        
    func pauseWorkTimer()
    func pauseBreakTimer()
    
    func stop()
        
    func stopTaskTimer()
        
//    func endOfDay()

}

//MARK: - Расширение для управления

extension ViewController: TimeTasksManagement {
    
    func newDay() {
        
        ///Остановка всех таймеров
        ///Запись в архив
        ///Инициировние нового дня
        
        day = Day()
    }
    
//    Запускает таймер работы
    func startWorkTimer() {
        workTimeManager.workTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in
            day.workTime += 1
            
            lazy var workSeconds = day.workTime % 60
            lazy var workMinutes = day.workTime / 60 % 60
            lazy var workHours = day.workTime / 3600

            lazy var fullWorkTime: [String] = []
            
            switch workHours {
            case 1...9:
                fullWorkTime.append("0\(workHours)ч")
            case 10...24:
                fullWorkTime.append("\(workHours)ч")
            default:
                fullWorkTime.append("")
            }
            
            switch workMinutes {
            case 1...9:
                fullWorkTime.append("0\(workMinutes)м")
            case 10...59:
                fullWorkTime.append("\(workMinutes)м")
            default:
                fullWorkTime.append("")
            }
            
            switch workSeconds {
            case 1...9:
                fullWorkTime.append("0\(workSeconds)с")
            case 10...59:
                fullWorkTime.append("\(workSeconds)с")
            default:
                fullWorkTime.append("")
            }
            
            workTimeDataLabel.text = fullWorkTime.joined(separator: " ")
            
            
            lazy var totalSeconds = day.totalTime % 60
            lazy var totalMinutes = day.totalTime / 60 % 60
            lazy var totalHours = day.totalTime / 3600

            lazy var fullTotalTime: [String] = []
            
            switch totalHours {
            case 1...9:
                fullTotalTime.append("0\(totalHours)ч")
            case 10...24:
                fullTotalTime.append("\(totalHours)ч")
            default:
                fullTotalTime.append("")
            }
            
            switch totalMinutes {
            case 1...9:
                fullTotalTime.append("0\(totalMinutes)м")
            case 10...59:
                fullTotalTime.append("\(totalMinutes)м")
            default:
                fullTotalTime.append("")
            }
            
            switch totalSeconds {
            case 1...9:
                fullTotalTime.append("0\(totalSeconds)с")
            case 10...59:
                fullTotalTime.append("\(totalSeconds)с")
            default:
                fullTotalTime.append("")
            }
            
            totalTimeDataLabel.text = fullTotalTime.joined(separator: " ")
        })
    }
    
//    Запускает таймер перерывов
    func startBreakTimer() {
        workTimeManager.breakTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in
            day.breakTime += 1
          
            lazy var breakSeconds = day.breakTime % 60
            lazy var breakMinutes = day.breakTime / 60 % 60
            lazy var breakHours = day.breakTime / 3600

            lazy var fullBreakTime: [String] = []
            
            switch breakHours {
            case 1...9:
                fullBreakTime.append("0\(breakHours)ч")
            case 10...24:
                fullBreakTime.append("\(breakHours)ч")
            default:
                fullBreakTime.append("")
            }
            
            switch breakMinutes {
            case 1...9:
                fullBreakTime.append("0\(breakMinutes)м")
            case 10...59:
                fullBreakTime.append("\(breakMinutes)м")
            default:
                fullBreakTime.append("")
            }
            
            switch breakSeconds {
            case 1...9:
                fullBreakTime.append("0\(breakSeconds)с")
            case 10...59:
                fullBreakTime.append("\(breakSeconds)с")
            default:
                fullBreakTime.append("")
            }
            
            workTimeDataLabel.text = fullBreakTime.joined(separator: " ")
            
            
            lazy var totalSeconds = day.totalTime % 60
            lazy var totalMinutes = day.totalTime / 60 % 60
            lazy var totalHours = day.totalTime / 3600

            lazy var fullTotalTime: [String] = []
            
            switch totalHours {
            case 1...9:
                fullTotalTime.append("0\(totalHours)ч")
            case 10...24:
                fullTotalTime.append("\(totalHours)ч")
            default:
                fullTotalTime.append("")
            }
            
            switch totalMinutes {
            case 1...9:
                fullTotalTime.append("0\(totalMinutes)м")
            case 10...59:
                fullTotalTime.append("\(totalMinutes)м")
            default:
                fullTotalTime.append("")
            }
            
            switch totalSeconds {
            case 1...9:
                fullTotalTime.append("0\(totalSeconds)с")
            case 10...59:
                fullTotalTime.append("\(totalSeconds)с")
            default:
                fullTotalTime.append("")
            }
            
            totalTimeDataLabel.text = fullTotalTime.joined(separator: " ")
        })
        RunLoop.current.add(workTimeManager.breakTimer, forMode: .common)
        workTimeManager.breakTimer.tolerance = 0.1
    }
    
//    Пауза для таймера работы
    func pauseWorkTimer() {
        workTimeManager.workTimer.invalidate()
    }
    
//    Пауза для таймера перерывов
    func pauseBreakTimer() {
        workTimeManager.breakTimer.invalidate()
    }

//    Пауза для обоих таймеров
    func stop() {
        workTimeManager.workTimer.invalidate()
        workTimeManager.breakTimer.invalidate()
    }
    
//    Остановка таймера задачи
    func stopTaskTimer() {
        
//        Останавливает таймер задачи и устанавливает время конца задачи
        taskTimeManager.taskTimer.invalidate()
        task.addStopTime()
        
//        Добавление задачи в массив задач дня
        day.tasks.append(task)
        
//        Обнуление объекта задачи
        task = Task()
        
//        Обнуление объекта таймера для задач
        taskTimeManager = TaskTimeManager()
                
//        Добавление новой строки таблицы
        tasksTableView.beginUpdates()
        tasksTableView.insertRows(at: [(NSIndexPath(row: day.tasks.count-1, section: 0) as IndexPath)], with: .automatic)
        tasksTableView.endUpdates()
        
//        Обнуление значений лейблов данных задачи
        ViewController.taskTimeTextLabel.text = "Название"
        ViewController.taskTimeDataLabel.text = "0с"
        
//        Меняет видимости кнопки и вью задачи на главном экране
        ViewController.addTaskButton.isHidden = false
        ViewController.taskTimerView.isHidden = true
    }

    
    
//    func endOfDay() {
//
//    }
    
}

