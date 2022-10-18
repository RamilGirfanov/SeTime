//
//  TaskCell.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 19.06.2022.
//

/// В этом файле:
/// - создается ячейка для UITableView
/// - нстраивается внешний вид ячейки
/// - кнопкам добавляются методы из расшитения для ячейки
/// - создаются объекты для управления таймером и архивом задач


import UIKit

class TaskCell: UITableViewCell {

    //    MARK: - Инициализатор

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //    MARK: - Создание и настройка объектов для кастомизации ячейки
    
    lazy var taskName: UILabel = {
        lazy var taskName = UILabel()
        taskName.translatesAutoresizingMaskIntoConstraints = false
        return taskName
    }()
    
    lazy var taskDuration: UILabel = {
        lazy var taskDuration = UILabel()
        taskDuration.textAlignment = .center
        taskDuration.translatesAutoresizingMaskIntoConstraints = false
        return taskDuration
    }()
    
    lazy var taskStartTime: UILabel = {
        lazy var taskStartAndStop = UILabel()
        taskStartAndStop.textAlignment = .center
        taskStartAndStop.translatesAutoresizingMaskIntoConstraints = false
        return taskStartAndStop
    }()
        
    
    //    MARK: - Расстановка объектов в ячейке

    private func layout() {
        [taskName, taskDuration, taskStartTime].forEach { contentView.addSubview($0) }
        
        let safeIndent: CGFloat = 8
        
        NSLayoutConstraint.activate([
            taskStartTime.widthAnchor.constraint(equalToConstant: 50),
            taskStartTime.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeIndent),
            taskStartTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent),
            taskStartTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -safeIndent),
            
            taskName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeIndent),
            taskName.leadingAnchor.constraint(equalTo: taskStartTime.trailingAnchor, constant: safeIndent),
            taskName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -safeIndent),
            
            taskDuration.widthAnchor.constraint(equalToConstant: 90),
            taskDuration.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeIndent),
            taskDuration.leadingAnchor.constraint(equalTo: taskName.trailingAnchor, constant: safeIndent),
            taskDuration.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent),
            taskDuration.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -safeIndent)
        ])
    }
        
    
    //    MARK: - Заполнение ячеек данными
    
    func pullCell(taskData: Task) {
        taskName.text = taskData.taskName
        taskDuration.text = timeIntToString(time: taskData.duration)
        taskStartTime.text = "\(taskData.startTime)"
    }
}
