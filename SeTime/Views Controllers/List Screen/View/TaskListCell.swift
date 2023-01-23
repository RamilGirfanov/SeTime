//
//  TaskListCell.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 22.01.2023.
//

import UIKit

class TaskListCell: UITableViewCell {
    
//    MARK: - UIObjects

    private var taskName: UILabel = {
        var taskName = UILabel()
        taskName.font = .systemFont(ofSize: textSize2, weight: .regular)
        taskName.translatesAutoresizingMaskIntoConstraints = false
        return taskName
    }()
    
//    MARK: - Layout

    private func layout() {
        contentView.addSubview(taskName)
        
        let safeIndent: CGFloat = 8
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            
            taskName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent),
            taskName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            taskName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent)
        ])
    }
    
//    MARK: - Заполнение ячеек данными
    
    func pullCell(taskData: TaskList) {
        taskName.text = taskData.name
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
