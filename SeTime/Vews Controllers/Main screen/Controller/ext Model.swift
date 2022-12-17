//
//  ext Model.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 17.12.2022.
//

import Foundation


//MARK: - Расширение для Model

extension MainScreenVC: UpdateTime {
    func updateTime() {
        mainScreen.viewForTimeReview.totalTimeDataLabel.text = timeIntToString(time: model.totalTime)
        mainScreen.viewForTimeReview.workTimeDataLabel.text = timeIntToString(time: model.workTime)
        mainScreen.viewForTimeReview.breakTimeDataLabel.text = timeIntToString(time: model.breakTime)
    }
    
    func updateTaskTime() {
        mainScreen.taskTimeDataLabel.text = timeIntToString(time: model.taskTime)
    }
}
