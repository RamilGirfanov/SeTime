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
    
    lazy var taskStartAndStop: UILabel = {
        lazy var taskStartAndStop = UILabel()
        taskStartAndStop.textAlignment = .center
        taskStartAndStop.translatesAutoresizingMaskIntoConstraints = false
        return taskStartAndStop
    }()
    
    lazy var stackForTaskTime: UIStackView = {
        lazy var stackForTaskLabel = UIStackView()
        stackForTaskLabel.axis = .vertical
        stackForTaskLabel.distribution = .fillEqually
        stackForTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTaskLabel
    }()
    
    
    //    MARK: - Расстановка объектов в ячейке

    private func layout() {
        [taskName, taskDuration, taskStartAndStop, stackForTaskTime].forEach { contentView.addSubview($0) }
        [taskDuration, taskStartAndStop].forEach { stackForTaskTime.addArrangedSubview($0) }

        
        let safeIndent: CGFloat = 8
        
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: contentView.topAnchor),
            taskName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent),
            taskName.trailingAnchor.constraint(equalTo: stackForTaskTime.leadingAnchor, constant: -safeIndent),
            taskName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackForTaskTime.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackForTaskTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent),
            stackForTaskTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
        
    
    //    MARK: - Заполнение ячеек данными
    
    func pullCell(taskData: Task) {
        taskName.text = taskData.taskName
        
        if taskData.duration < 60 {
            taskDuration.text = "\(taskData.duration)с"
        } else if taskData.duration < 3600 {
            taskDuration.text = "\(taskData.duration / 60)м \(taskData.duration % 60)с"
        } else {
            taskDuration.text = "\(taskData.duration / 3600)ч \((taskData.duration % 3600) / 60)м"
        }
        
        taskStartAndStop.text = "\(taskData.startTime) - \(taskData.stopTime)"

    }
    
//    func pullCellHistoryData(date: String, numberOfTask: Int) {
//        taskName.text = archiveOfDays[date]?.tasks[numberOfTask].taskName
//        
//        guard let time = archiveOfDays[date]?.tasks[numberOfTask].duration else { return }
//        
//        if time < 60 {
//            taskDuration.text = "\(time)с"
//        } else if time < 3600 {
//            taskDuration.text = "\(time / 60)м \(time % 60)с"
//        } else {
//            taskDuration.text = "\(time / 3600)ч \((time % 3600) / 60)м"
//        }
//        
//        taskStartAndStop.text = "\(archiveOfDays[date]?.tasks[numberOfTask].startTime) - \(archiveOfDays[date]?.tasks[numberOfTask].stopTime)"
//
//    }
    
}
