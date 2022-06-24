//
//  Extension for TableView.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 19.06.2022.
//

/// В этом файле: расширяется ViewController для UITableView

import UIKit

//    MARK: - Расширение UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
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
        
        cell.numberOfCell = indexPath.row
        cell.pullCell(taskData: day.tasks[indexPath.row])
        
        arrayOfCells.append(cell)
        
//        Делегат ячейки
        cellDelegate = cell
        
        return cell
    }
}


//    MARK: - Расширение UITableViewDelegate

extension ViewController: UITableViewDelegate {
    //    Возвращает динамическую высоту ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
