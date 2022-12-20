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
        mainScreen.viewForTimeReview.totalTimeDataLabel.text = timeIntToString(time: Model.shared.totalTime)
        mainScreen.viewForTimeReview.workTimeDataLabel.text = timeIntToString(time: Model.shared.workTime)
        mainScreen.viewForTimeReview.breakTimeDataLabel.text = timeIntToString(time: Model.shared.breakTime)
    }
    
    func updateTaskTime() {
        mainScreen.taskTimeDataLabel.text = timeIntToString(time: Model.shared.taskTime)
    }
}
