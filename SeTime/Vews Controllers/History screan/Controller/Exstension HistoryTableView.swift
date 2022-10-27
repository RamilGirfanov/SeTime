//
//  Exstension HistoryTableView.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 27.07.2022.
//

import UIKit

//    MARK: - Расширение UITableViewDataSource

extension HistoryScreanViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
//    Необхобимое количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        day.tasks.count
    }
    
//    Тип ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        lazy var cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.backgroundColor = .clear
        
        guard let taskData = archiveOfDays[chosenDate]?.tasks[indexPath.row] else { return cell }
        cell.pullCell(taskData: taskData)
                
        return cell
    }
}


//    MARK: - Расширение UITableViewDelegate

extension HistoryScreanViewController: UITableViewDelegate {
    //    Возвращает динамическую высоту ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
