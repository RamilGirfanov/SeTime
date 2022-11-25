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
        screenLabel.text = NSLocalizedString("addTaskScreenTitle", comment: "")
        screenLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        screenLabel.translatesAutoresizingMaskIntoConstraints = false
        return screenLabel
    }()
    
    private var taskLabel: UILabel = {
        var taskLabel = UILabel()
        taskLabel.text = NSLocalizedString("name", comment: "")
        taskLabel.font = .systemFont(ofSize: textSize2, weight: .bold)
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskLabel
    }()
    
    var taskName: UITextView = {
        var taskName = UITextView()
        taskName.font = .systemFont(ofSize: textSize3)
        taskName.backgroundColor = .secondarySystemBackground
        taskName.layer.cornerRadius = totalCornerRadius
        taskName.translatesAutoresizingMaskIntoConstraints = false
        return taskName
    }()
    
    private var definitionLabel: UILabel = {
        var taskLabel = UILabel()
        taskLabel.text = NSLocalizedString("definition", comment: "")
        taskLabel.font = .systemFont(ofSize: textSize2, weight: .bold)
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskLabel
    }()
    
    var taskDefinition: UITextView = {
        var taskDefinition = UITextView ()
        taskDefinition.font = .systemFont(ofSize: textSize3)
        taskDefinition.backgroundColor = .secondarySystemBackground
        taskDefinition.layer.cornerRadius = totalCornerRadius
        taskDefinition.translatesAutoresizingMaskIntoConstraints = false
        return taskDefinition
    }()
    
    var button: UIButton = {
        var button = UIButton()
        button.setTitle(NSLocalizedString("add", comment: ""), for: .normal)
        button.activeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: AddTaskProtocol?
    
    
//    MARK: - Layout
    
    private func layout() {
        [screenLabel, taskLabel, taskName, definitionLabel, taskDefinition, button].forEach { addSubview($0) }
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8

        NSLayoutConstraint.activate([
            screenLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            screenLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            
            taskLabel.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: safeIndent1),
            taskLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            
            taskName.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 1.5),
            taskName.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: safeIndent2),
            taskName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            taskName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            definitionLabel.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: safeIndent1),
            definitionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            
            taskDefinition.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 2),
            taskDefinition.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: safeIndent2),
            taskDefinition.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            taskDefinition.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            button.topAnchor.constraint(equalTo: taskDefinition.bottomAnchor, constant: safeIndent2),
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
        backgroundColor = .systemBackground
        layout()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
