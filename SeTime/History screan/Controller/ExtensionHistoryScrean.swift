//
//  ExtensionHistoryScrean.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 27.07.2022.
//

import Foundation

extension HistoryScreanViewController {
    
    func setupData() {
        guard let time = archiveOfDays[chosenDate]?.totalTime else { return }
        totalTimeDataLabel.text = timeIntToString(time: time)
        
        guard let time = archiveOfDays[chosenDate]?.workTime else { return }
        workTimeDataLabel.text = timeIntToString(time: time)
        
        guard let time = archiveOfDays[chosenDate]?.breakTime else {return}
        breakTimeDataLabel.text = timeIntToString(time: time)
    }
}
