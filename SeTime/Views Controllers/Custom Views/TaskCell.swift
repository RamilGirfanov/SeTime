//
//  TaskCell.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 19.06.2022.
//

import UIKit

final class TaskCell: UITableViewCell {
    
//    MARK: - UIObjects
    
    var taskStartTime: UILabel = {
        var taskStartAndStop = UILabel()
        taskStartAndStop.font = .systemFont(ofSize: textSize2, weight: .regular)
        taskStartAndStop.textAlignment = .center
        taskStartAndStop.translatesAutoresizingMaskIntoConstraints = false
        return taskStartAndStop
    }()
    
    var taskName: UILabel = {
        var taskName = UILabel()
        taskName.font = .systemFont(ofSize: textSize2, weight: .regular)
        taskName.translatesAutoresizingMaskIntoConstraints = false
        return taskName
    }()
    
    var taskDuration: UILabel = {
        var taskDuration = UILabel()
        taskDuration.font = .systemFont(ofSize: textSize2, weight: .regular)
        taskDuration.textAlignment = .center
        taskDuration.translatesAutoresizingMaskIntoConstraints = false
        return taskDuration
    }()
        
    
//    MARK: - Layout

    private func layout() {
        [taskName, taskDuration, taskStartTime].forEach { contentView.addSubview($0) }
        
        let safeIndent: CGFloat = 8
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            
            taskStartTime.widthAnchor.constraint(equalToConstant: 50),
            taskStartTime.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            taskStartTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent),
            
            taskName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            taskName.leadingAnchor.constraint(equalTo: taskStartTime.trailingAnchor, constant: safeIndent),
            taskName.trailingAnchor.constraint(equalTo: taskDuration.leadingAnchor, constant: -safeIndent),
            
            taskDuration.widthAnchor.constraint(equalToConstant: 90),
            taskDuration.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            taskDuration.leadingAnchor.constraint(equalTo: taskName.trailingAnchor, constant: safeIndent),
            taskDuration.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent)
        ])
    }
        
    
//    MARK: - Заполнение ячеек данными
    
    func pullCell(taskData: Task) {
        taskName.text = taskData.name
        taskDuration.text = timeIntToString(time: taskData.duration)
        taskStartTime.text = "\(taskData.startTime)"
    }
    
    
//    MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
