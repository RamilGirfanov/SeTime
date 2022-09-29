//
//  TaskViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 22.07.2022.
//

import UIKit

class TaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        setupButton()
    }

    //    MARK: - UIObjects

    lazy var taskLabel: UILabel = {
        lazy var taskLabel = UILabel()
        taskLabel.text = "Название и описание"
        taskLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskLabel
    }()
    
    lazy var taskName: UITextField = {
        lazy var taskName = UITextField()
        taskName.placeholder = "Название"
        taskName.font = .systemFont(ofSize: textSize4)
        taskName.backgroundColor = .systemGray6
        //        taskName.tintColor = mainColorTheme
        taskName.borderStyle = .roundedRect
        taskName.translatesAutoresizingMaskIntoConstraints = false
        return taskName
    }()
    
    lazy var viewForTextFieldTaskName: UIView = {
        lazy var viewForTextFieldTaskName = UIView()
        viewForTextFieldTaskName.clipsToBounds = true
        viewForTextFieldTaskName.layer.cornerRadius = totalCornerRadius
        viewForTextFieldTaskName.layer.borderWidth = 0.5
        viewForTextFieldTaskName.layer.borderColor = UIColor.lightGray.cgColor
        viewForTextFieldTaskName.translatesAutoresizingMaskIntoConstraints = false
        return viewForTextFieldTaskName
    }()
    
    lazy var viewForTextFieldTaskDefinition: UIView = {
        lazy var viewForTextFieldTaskDefinition = UIView()
        viewForTextFieldTaskDefinition.clipsToBounds = true
        viewForTextFieldTaskDefinition.layer.cornerRadius = totalCornerRadius
        viewForTextFieldTaskDefinition.layer.borderWidth = 0.5
        viewForTextFieldTaskDefinition.layer.borderColor = UIColor.lightGray.cgColor
        viewForTextFieldTaskDefinition.translatesAutoresizingMaskIntoConstraints = false
        return viewForTextFieldTaskDefinition
    }()
    
    lazy var definition: UITextField = {
        lazy var definition = UITextField ()
        definition.placeholder = "Описание"
        definition.font = .systemFont(ofSize: textSize4)
        definition.backgroundColor = .systemGray6
//        definition.tintColor = mainColorTheme
        definition.borderStyle = .roundedRect
        definition.translatesAutoresizingMaskIntoConstraints = false
        return definition
    }()
    
    lazy var startButton: UIButton = {
        lazy var startButton = UIButton()
        startButton.setTitle("Добавить", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        startButton.roundYeellowButton()
        return startButton
    }()
    
    //    MARK: - Layout
    
    private func layout() {
        [taskLabel, viewForTextFieldTaskName, viewForTextFieldTaskDefinition, startButton].forEach { view.addSubview($0) }
        viewForTextFieldTaskName.addSubview(taskName)
        viewForTextFieldTaskDefinition.addSubview(definition)
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8

        NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            taskLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
             
            viewForTextFieldTaskName.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 2),
            viewForTextFieldTaskName.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: safeIndent2),
            viewForTextFieldTaskName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            viewForTextFieldTaskName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            viewForTextFieldTaskDefinition.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 3),
            viewForTextFieldTaskDefinition.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: safeIndent2),
            viewForTextFieldTaskDefinition.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            viewForTextFieldTaskDefinition.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            taskName.topAnchor.constraint(equalTo: viewForTextFieldTaskName.topAnchor),
            taskName.leadingAnchor.constraint(equalTo: viewForTextFieldTaskName.leadingAnchor),
            taskName.trailingAnchor.constraint(equalTo: viewForTextFieldTaskName.trailingAnchor),
            taskName.bottomAnchor.constraint(equalTo: viewForTextFieldTaskName.bottomAnchor),
            
            definition.topAnchor.constraint(equalTo: viewForTextFieldTaskDefinition.topAnchor),
            definition.leadingAnchor.constraint(equalTo: viewForTextFieldTaskDefinition.leadingAnchor),
            definition.trailingAnchor.constraint(equalTo: viewForTextFieldTaskDefinition.trailingAnchor),
            definition.bottomAnchor.constraint(equalTo: viewForTextFieldTaskDefinition.bottomAnchor),
            
            startButton.topAnchor.constraint(equalTo: viewForTextFieldTaskDefinition.bottomAnchor, constant: safeIndent2),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            startButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects)
        ])

    }
    
}
