//
//  TaskScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 27.10.2022.
//

import UIKit

protocol AddTaskProtocol: AnyObject {
    func addTask()
}

class AddTaskScreen: UIView {

//    MARK: - UIObjects

    var screenLabel: UILabel = {
        var screenLabel = UILabel()
        screenLabel.text = "Новая задача"
        screenLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        screenLabel.translatesAutoresizingMaskIntoConstraints = false
        return screenLabel
    }()
    
    var taskName: UITextField = {
        var taskName = UITextField()
        taskName.placeholder = "Название"
        taskName.font = .systemFont(ofSize: textSize4)
        taskName.backgroundColor = .secondarySystemBackground
        taskName.translatesAutoresizingMaskIntoConstraints = false
        return taskName
    }()
    
    var taskDefinition: UITextField = {
        var taskDefinition = UITextField ()
        taskDefinition.placeholder = "Описание"
        taskDefinition.font = .systemFont(ofSize: textSize4)
        taskDefinition.backgroundColor = .secondarySystemBackground
        taskDefinition.translatesAutoresizingMaskIntoConstraints = false
        return taskDefinition
    }()
      
    private var viewForTaskName: UIView = {
        var viewForTaskName = UIView()
        viewForTaskName.backgroundColor = .secondarySystemBackground
        viewForTaskName.clipsToBounds = true
        viewForTaskName.layer.cornerRadius = totalCornerRadius
        viewForTaskName.translatesAutoresizingMaskIntoConstraints = false
        return viewForTaskName
    }()
    
    private var viewForTaskDefinition: UIView = {
        var viewForTaskDefinition = UIView()
        viewForTaskDefinition.backgroundColor = .secondarySystemBackground
        viewForTaskDefinition.clipsToBounds = true
        viewForTaskDefinition.layer.cornerRadius = totalCornerRadius
        viewForTaskDefinition.translatesAutoresizingMaskIntoConstraints = false
        return viewForTaskDefinition
    }()

    var button: UIButton = {
        var button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        button.activeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: AddTaskProtocol?
    
    
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
             
            viewForTaskName.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 1.5),
            viewForTaskName.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: safeIndent2),
            viewForTaskName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            viewForTaskName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            viewForTaskDefinition.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 2),
            viewForTaskDefinition.topAnchor.constraint(equalTo: viewForTaskName.bottomAnchor, constant: safeIndent2),
            viewForTaskDefinition.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            viewForTaskDefinition.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            taskName.topAnchor.constraint(equalTo: viewForTaskName.topAnchor),
            taskName.leadingAnchor.constraint(equalTo: viewForTaskName.leadingAnchor, constant: safeIndent2),
            taskName.trailingAnchor.constraint(equalTo: viewForTaskName.trailingAnchor, constant: -safeIndent2),
            taskName.bottomAnchor.constraint(equalTo: viewForTaskName.bottomAnchor),
            
            taskDefinition.topAnchor.constraint(equalTo: viewForTaskDefinition.topAnchor),
            taskDefinition.leadingAnchor.constraint(equalTo: viewForTaskDefinition.leadingAnchor, constant: safeIndent2),
            taskDefinition.trailingAnchor.constraint(equalTo: viewForTaskDefinition.trailingAnchor, constant: -safeIndent2),
            taskDefinition.bottomAnchor.constraint(equalTo: viewForTaskDefinition.bottomAnchor),
            
            button.topAnchor.constraint(equalTo: viewForTaskDefinition.bottomAnchor, constant: safeIndent2),
            button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            button.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects)
        ])
    }
    
    
//    MARK: - Настройка кнопки

    private func setupButton() {
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @objc func tap() {
        delegate?.addTask()
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
