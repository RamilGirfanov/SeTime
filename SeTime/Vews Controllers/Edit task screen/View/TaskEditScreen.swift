//
//  TaskEditScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 18.11.2022.
//

import UIKit

protocol SaveTaskProtocol: AnyObject {
    func saveTask(name: String, definition: String)
}

class TaskEditScreen: UIView {
    
    //    MARK: - UIObjects
    
    var screenLabel: UILabel = {
        var screenLabel = UILabel()
        screenLabel.text = "Редактирование задачи"
        screenLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        screenLabel.translatesAutoresizingMaskIntoConstraints = false
        return screenLabel
    }()
    
    var taskName: UITextField = {
        var taskName = UITextField()
        taskName.font = .systemFont(ofSize: textSize4)
        taskName.backgroundColor = .systemGray6
        taskName.borderStyle = .roundedRect
        taskName.translatesAutoresizingMaskIntoConstraints = false
        return taskName
    }()
    
    var taskDefinition: UITextField = {
        var taskDefinition = UITextField ()
        taskDefinition.font = .systemFont(ofSize: textSize4)
        taskDefinition.backgroundColor = .systemGray6
        taskDefinition.borderStyle = .roundedRect
        taskDefinition.translatesAutoresizingMaskIntoConstraints = false
        return taskDefinition
    }()
    
    var viewForTaskName: UIView = {
        var viewForTaskName = UIView()
        viewForTaskName.clipsToBounds = true
        viewForTaskName.layer.cornerRadius = totalCornerRadius
        viewForTaskName.layer.borderWidth = 0.5
        viewForTaskName.layer.borderColor = UIColor.lightGray.cgColor
        viewForTaskName.translatesAutoresizingMaskIntoConstraints = false
        return viewForTaskName
    }()
    
    var viewForTaskDefinition: UIView = {
        var viewForTaskDefinition = UIView()
        viewForTaskDefinition.clipsToBounds = true
        viewForTaskDefinition.layer.cornerRadius = totalCornerRadius
        viewForTaskDefinition.layer.borderWidth = 0.5
        viewForTaskDefinition.layer.borderColor = UIColor.lightGray.cgColor
        viewForTaskDefinition.translatesAutoresizingMaskIntoConstraints = false
        return viewForTaskDefinition
    }()
    
    var button: UIButton = {
        var button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        button.roundYeellowButton()
        return button
    }()
    
    
    //    MARK: - Delegate
    
    weak var delegate: SaveTaskProtocol?
    
    
    //    MARK: - Layout
    
    private func layout() {
        [screenLabel, viewForTaskName, viewForTaskDefinition, button].forEach { addSubview($0) }
        viewForTaskName.addSubview(taskName)
        viewForTaskDefinition.addSubview(taskDefinition)
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8
        
        NSLayoutConstraint.activate([
            screenLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            screenLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            
            viewForTaskName.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 2),
            viewForTaskName.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: safeIndent2),
            viewForTaskName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            viewForTaskName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            viewForTaskDefinition.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 3),
            viewForTaskDefinition.topAnchor.constraint(equalTo: viewForTaskName.bottomAnchor, constant: safeIndent2),
            viewForTaskDefinition.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            viewForTaskDefinition.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            taskName.topAnchor.constraint(equalTo: viewForTaskName.topAnchor),
            taskName.leadingAnchor.constraint(equalTo: viewForTaskName.leadingAnchor),
            taskName.trailingAnchor.constraint(equalTo: viewForTaskName.trailingAnchor),
            taskName.bottomAnchor.constraint(equalTo: viewForTaskName.bottomAnchor),
            
            taskDefinition.topAnchor.constraint(equalTo: viewForTaskDefinition.topAnchor),
            taskDefinition.leadingAnchor.constraint(equalTo: viewForTaskDefinition.leadingAnchor),
            taskDefinition.trailingAnchor.constraint(equalTo: viewForTaskDefinition.trailingAnchor),
            taskDefinition.bottomAnchor.constraint(equalTo: viewForTaskDefinition.bottomAnchor),
            
            button.topAnchor.constraint(equalTo: viewForTaskDefinition.bottomAnchor, constant: safeIndent2),
            button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            button.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects)
        ])
    }
    
    
    //    MARK: - Настройка кнопки
    
    private func setupButton() {
        button.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
    }
    
    @objc private func saveTask() {
        guard let newTaskName = taskName.text, !newTaskName.isEmpty else { return }
        delegate?.saveTask(name: newTaskName, definition: taskDefinition.text ?? "")
    }
    
    
    //    MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setupButton()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
