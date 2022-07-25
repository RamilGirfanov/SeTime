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
        taskName.tintColor = mainColorTheme
        taskName.borderStyle = .roundedRect
        taskName.translatesAutoresizingMaskIntoConstraints = false
        return taskName
    }()
    
    lazy var definition: UITextField = {
        lazy var definition = UITextField ()
        definition.placeholder = "Описание"
        definition.font = .systemFont(ofSize: textSize4)
        definition.backgroundColor = .systemGray6
        definition.tintColor = mainColorTheme
        definition.borderStyle = .roundedRect
        definition.translatesAutoresizingMaskIntoConstraints = false
        return definition
    }()
    
    lazy var startButton: UIButton = {
        lazy var startButton = UIButton()
        startButton.setTitle("Старт", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.tintColor = .black
        startButton.backgroundColor = mainColorTheme
        startButton.layer.cornerRadius = totalCornerRadius
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        return startButton
    }()
    
    //    MARK: - Layout
    
    private func layout() {
        [taskLabel, taskName, definition, startButton].forEach { view.addSubview($0) }
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8

        NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            taskLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
                     
            taskName.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 2),
            taskName.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: safeIndent2),
            taskName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            taskName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            definition.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 3),
            definition.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: safeIndent2),
            definition.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            definition.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            startButton.topAnchor.constraint(equalTo: definition.bottomAnchor, constant: safeIndent2),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            startButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects)
        ])

    }
    
}
