//
//  TaskScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 27.10.2022.
//

import UIKit

protocol TaskScreenProtocol: AnyObject {
    func dismiss()
}

class TaskScreen: UIView {

//    MARK: - UIObjects

    var screenLabel: UILabel = {
        var screenLabel = UILabel()
        screenLabel.text = "Название и описание"
        screenLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        screenLabel.translatesAutoresizingMaskIntoConstraints = false
        return screenLabel
    }()
    
    var taskName: UITextField = {
        var taskName = UITextField()
        taskName.placeholder = "Название"
        taskName.font = .systemFont(ofSize: textSize4)
        taskName.backgroundColor = .systemGray6
        taskName.borderStyle = .roundedRect
        taskName.translatesAutoresizingMaskIntoConstraints = false
        return taskName
    }()
    
    var viewForTextFieldTaskName: UIView = {
        var viewForTextFieldTaskName = UIView()
        viewForTextFieldTaskName.clipsToBounds = true
        viewForTextFieldTaskName.layer.cornerRadius = totalCornerRadius
        viewForTextFieldTaskName.layer.borderWidth = 0.5
        viewForTextFieldTaskName.layer.borderColor = UIColor.lightGray.cgColor
        viewForTextFieldTaskName.translatesAutoresizingMaskIntoConstraints = false
        return viewForTextFieldTaskName
    }()
    
    var viewForTextFieldTaskDefinition: UIView = {
        var viewForTextFieldTaskDefinition = UIView()
        viewForTextFieldTaskDefinition.clipsToBounds = true
        viewForTextFieldTaskDefinition.layer.cornerRadius = totalCornerRadius
        viewForTextFieldTaskDefinition.layer.borderWidth = 0.5
        viewForTextFieldTaskDefinition.layer.borderColor = UIColor.lightGray.cgColor
        viewForTextFieldTaskDefinition.translatesAutoresizingMaskIntoConstraints = false
        return viewForTextFieldTaskDefinition
    }()
    
    var definition: UITextField = {
        var definition = UITextField ()
        definition.placeholder = "Описание"
        definition.font = .systemFont(ofSize: textSize4)
        definition.backgroundColor = .systemGray6
        definition.borderStyle = .roundedRect
        definition.translatesAutoresizingMaskIntoConstraints = false
        return definition
    }()
    
    var startButton: UIButton = {
        var startButton = UIButton()
        startButton.setTitle("Добавить", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        startButton.roundYeellowButton()
        return startButton
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: TaskScreenProtocol?
    
//    MARK: - Layout
    
    private func layout() {
        [screenLabel, viewForTextFieldTaskName, viewForTextFieldTaskDefinition, startButton].forEach { addSubview($0) }
        viewForTextFieldTaskName.addSubview(taskName)
        viewForTextFieldTaskDefinition.addSubview(definition)
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8

        NSLayoutConstraint.activate([
            screenLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            screenLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
             
            viewForTextFieldTaskName.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 2),
            viewForTextFieldTaskName.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: safeIndent2),
            viewForTextFieldTaskName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            viewForTextFieldTaskName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            viewForTextFieldTaskDefinition.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 3),
            viewForTextFieldTaskDefinition.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: safeIndent2),
            viewForTextFieldTaskDefinition.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            viewForTextFieldTaskDefinition.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            taskName.topAnchor.constraint(equalTo: viewForTextFieldTaskName.topAnchor),
            taskName.leadingAnchor.constraint(equalTo: viewForTextFieldTaskName.leadingAnchor),
            taskName.trailingAnchor.constraint(equalTo: viewForTextFieldTaskName.trailingAnchor),
            taskName.bottomAnchor.constraint(equalTo: viewForTextFieldTaskName.bottomAnchor),
            
            definition.topAnchor.constraint(equalTo: viewForTextFieldTaskDefinition.topAnchor),
            definition.leadingAnchor.constraint(equalTo: viewForTextFieldTaskDefinition.leadingAnchor),
            definition.trailingAnchor.constraint(equalTo: viewForTextFieldTaskDefinition.trailingAnchor),
            definition.bottomAnchor.constraint(equalTo: viewForTextFieldTaskDefinition.bottomAnchor),
            
            startButton.topAnchor.constraint(equalTo: viewForTextFieldTaskDefinition.bottomAnchor, constant: safeIndent2),
            startButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            startButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            startButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects)
        ])

    }
    
    
//    MARK: - Настройка кнопки

    func setupButton() {
        startButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
    @objc private func addTask() {
//        Скрывает текущий экран
        delegate?.dismiss()
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
