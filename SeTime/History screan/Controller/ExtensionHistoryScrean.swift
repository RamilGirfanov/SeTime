//
//  ExtensionHistoryScrean.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 27.07.2022.
//

import Foundation

extension HistoryScreanViewController {
    
    func setupData() {
        
        guard let time = archiveOfDays[chosenDate]?.totalTime else {return}
        
        lazy var totalSeconds = time % 60
        lazy var totalMinutes = time / 60 % 60
        lazy var totalHours = time / 3600

        lazy var fullTotalTime: [String] = []
        
        switch totalHours {
        case 1...9:
            fullTotalTime.append("0\(totalHours)")
        case 10...24:
            fullTotalTime.append("\(totalHours)")
        default:
            fullTotalTime.append("00")
        }
        
        switch totalMinutes {
        case 1...9:
            fullTotalTime.append("0\(totalMinutes)")
        case 10...59:
            fullTotalTime.append("\(totalMinutes)")
        default:
            fullTotalTime.append("00")
        }
        
        switch totalSeconds {
        case 1...9:
            fullTotalTime.append("0\(totalSeconds)")
        case 10...59:
            fullTotalTime.append("\(totalSeconds)")
        default:
            fullTotalTime.append("00")
        }
        
        totalTimeDataLabel.text = fullTotalTime.joined(separator: ":")
        
        guard let time = archiveOfDays[chosenDate]?.workTime else {return}
        
        lazy var workSeconds = time % 60
        lazy var workMinutes = time / 60 % 60
        lazy var workHours = time / 3600

        lazy var fullWorkTime: [String] = []
        
        switch workHours {
        case 1...9:
            fullWorkTime.append("0\(workHours)")
        case 10...24:
            fullWorkTime.append("\(workHours)")
        default:
            fullWorkTime.append("00")
        }
        
        switch workMinutes {
        case 1...9:
            fullWorkTime.append("0\(workMinutes)")
        case 10...59:
            fullWorkTime.append("\(workMinutes)")
        default:
            fullWorkTime.append("00")
        }
        
        switch workSeconds {
        case 1...9:
            fullWorkTime.append("0\(workSeconds)")
        case 10...59:
            fullWorkTime.append("\(workSeconds)")
        default:
            fullWorkTime.append("00")
        }
        
        workTimeDataLabel.text = fullWorkTime.joined(separator: ":")
        
        guard let time = archiveOfDays[chosenDate]?.breakTime else {return}
        
        lazy var breakSeconds = time % 60
        lazy var breakMinutes = time / 60 % 60
        lazy var breakHours = time / 3600

        lazy var fullBreakTime: [String] = []
        
        switch breakHours {
        case 1...9:
            fullBreakTime.append("0\(breakHours)")
        case 10...24:
            fullBreakTime.append("\(breakHours)")
        default:
            fullBreakTime.append("00")
        }
        
        switch breakMinutes {
        case 1...9:
            fullBreakTime.append("0\(breakMinutes)")
        case 10...59:
            fullBreakTime.append("\(breakMinutes)")
        default:
            fullBreakTime.append("00")
        }
        
        switch breakSeconds {
        case 1...9:
            fullBreakTime.append("0\(breakSeconds)")
        case 10...59:
            fullBreakTime.append("\(breakSeconds)")
        default:
            fullBreakTime.append("00")
        }
        
        breakTimeDataLabel.text = fullBreakTime.joined(separator: ":")
        
    }
    
}
