//
//  TaskListScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 22.01.2023.
//

import UIKit

protocol TaskListProtocol: AnyObject {
    func addTask()
}

class TaskListScreen: UIView {
    
//    MARK: - UIObjects
    
    private let listLabel: UILabel = {
        let timeTextLabel = UILabel()
        timeTextLabel.text = NSLocalizedString("listScreenTitle", comment: "")
        timeTextLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeTextLabel
    }()
    
    lazy var tasksTableView: UITableView = {
        var tasksTableView = UITableView()
        tasksTableView.backgroundColor = .secondarySystemBackground
        tasksTableView.layer.cornerRadius = totalCornerRadius
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.register(TaskListCell.self, forCellReuseIdentifier: TaskListCell.identifier)
        tasksTableView.separatorInset = .zero
        return tasksTableView
    }()
    
    private let addTaskButton: UIButton = {
        let addTaskButton = UIButton()
        addTaskButton.setTitle(NSLocalizedString("addTask", comment: ""), for: .normal)
        addTaskButton.activeButton()
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        return addTaskButton
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: TaskListProtocol?
    
    
//    MARK: - Настройка кнопок
    
    private func setupButton() {
        addTaskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
    @objc private func addTask() {
        delegate?.addTask()
    }
    
    
//    MARK: - Layout
    
    private func layout() {
        
        [listLabel, tasksTableView, addTaskButton].forEach { addSubview($0) }
        
        let safeIndent: CGFloat = 16
        
        NSLayoutConstraint.activate([
            listLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: safeIndent),
            listLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent),
            
            tasksTableView.topAnchor.constraint(equalTo: listLabel.bottomAnchor, constant: safeIndent),
            tasksTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent),
            tasksTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent),
            
            addTaskButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            addTaskButton.topAnchor.constraint(equalTo: tasksTableView.bottomAnchor, constant: safeIndent),
            addTaskButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent),
            addTaskButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent),
            addTaskButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -safeIndent)
        ])
    }
    
    
//    MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupButton()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
