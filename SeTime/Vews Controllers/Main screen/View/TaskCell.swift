//
//  TaskCell.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 19.06.2022.
//

import UIKit

class TaskCell: UITableViewCell {
    
//    MARK: - UIObjects
    
    var taskName: UILabel = {
        var taskName = UILabel()
        taskName.translatesAutoresizingMaskIntoConstraints = false
        return taskName
    }()
    
    var taskDuration: UILabel = {
        var taskDuration = UILabel()
        taskDuration.textAlignment = .center
        taskDuration.translatesAutoresizingMaskIntoConstraints = false
        return taskDuration
    }()
    
    var taskStartTime: UILabel = {
        var taskStartAndStop = UILabel()
        taskStartAndStop.textAlignment = .center
        taskStartAndStop.translatesAutoresizingMaskIntoConstraints = false
        return taskStartAndStop
    }()
        
    
//    MARK: - Layout

    private func layout() {
        [taskName, taskDuration, taskStartTime].forEach { contentView.addSubview($0) }
        
        let safeIndent: CGFloat = 8
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            
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
        taskName.text = taskData.name
        taskDuration.text = timeIntToString(time: taskData.duration)
        taskStartTime.text = "\(taskData.startTime)"
    }
    
    
//    MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
