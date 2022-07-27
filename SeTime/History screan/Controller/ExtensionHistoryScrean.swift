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
        
        if time < 60 {
            totalTimeDataLabel.text = "\(time)с"
        } else if time < 3600 {
            totalTimeDataLabel.text = "\(time / 60)м \(time % 60)с"
        } else {
            totalTimeDataLabel.text = "\(time / 3600)ч \((time % 3600) / 60)м"
        }
        
        guard let time = archiveOfDays[chosenDate]?.workTime else {return}
        
        if time < 60 {
            workTimeDataLabel.text = "\(time)с"
        } else if time < 3600 {
            workTimeDataLabel.text = "\(time / 60)м \(time % 60)с"
        } else {
            workTimeDataLabel.text = "\(time / 3600)ч \((time % 3600) / 60)м"
        }
        
        guard let time = archiveOfDays[chosenDate]?.breakTime else {return}
        
        if time < 60 {
            breakTimeDataLabel.text = "\(time)с"
        } else if time < 3600 {
            breakTimeDataLabel.text = "\(time / 60)м \(time % 60)с"
        } else {
            breakTimeDataLabel.text = "\(time / 3600)ч \((time % 3600) / 60)м"
        }
        
        guard let time = archiveOfDays[chosenDate]?.totalTime else {return}
        
        if time < 60 {
            totalTimeDataLabel.text = "\(time)с"
        } else if time < 3600 {
            totalTimeDataLabel.text = "\(time / 60)м \(time % 60)с"
        } else {
            totalTimeDataLabel.text = "\(time / 3600)ч \((time % 3600) / 60)м"
        }
        
    }
    
}
