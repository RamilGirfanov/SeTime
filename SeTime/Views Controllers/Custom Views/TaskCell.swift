//
//  TaskCell.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 19.06.2022.
//

import UIKit

final class TaskCell: UITableViewCell {
// MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
// MARK: - UIObjects
    
    private let subView: UIView = {
        let subView = UIView()
        subView.backgroundColor = .clear
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    
    var taskStartTime: UILabel = {
        var taskStartTime = UILabel()
        taskStartTime.font = .systemFont(ofSize: textSize3, weight: .regular)
        taskStartTime.textColor = .secondaryLabel
        taskStartTime.translatesAutoresizingMaskIntoConstraints = false
        return taskStartTime
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
    
    
// MARK: - Layout

    private func layout() {
        contentView.addSubview(subView)
        [taskName, taskStartTime, taskDuration].forEach { subView.addSubview($0) }

        let safeIndent: CGFloat = 8
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            
            subView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            subView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent),
            subView.trailingAnchor.constraint(equalTo: taskDuration.leadingAnchor, constant: -safeIndent),

            taskName.topAnchor.constraint(equalTo: subView.topAnchor),
            taskName.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            taskName.trailingAnchor.constraint(equalTo: subView.trailingAnchor),
            
            taskStartTime.topAnchor.constraint(equalTo: taskName.bottomAnchor),
            taskStartTime.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            taskStartTime.trailingAnchor.constraint(equalTo: subView.trailingAnchor),
            taskStartTime.bottomAnchor.constraint(equalTo: subView.bottomAnchor),
            
            taskDuration.widthAnchor.constraint(equalToConstant: 90),
            taskDuration.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            taskDuration.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent)
        ])
    }
    
    
// MARK: - Заполнение ячеек данными
    
    func pullCell(taskData: Task) {
        taskName.text = taskData.name
        taskDuration.text = timeIntToString(time: taskData.duration)
        taskStartTime.text = "\(taskData.startTime)"
    }
}
