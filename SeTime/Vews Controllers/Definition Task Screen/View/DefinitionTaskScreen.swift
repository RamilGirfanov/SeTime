//
//  DefinitionTaskScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 17.11.2022.
//

import UIKit

protocol EditTaskProtocol: AnyObject {
    func editTask()
}

class DefinitionTaskScreen: UIView {

//    MARK: - UIObjects
    
    private var screenLabel: UILabel = {
        var screenLabel = UILabel()
        screenLabel.text = "Задача"
        screenLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        screenLabel.translatesAutoresizingMaskIntoConstraints = false
        return screenLabel
    }()
    
    var name: UILabel = {
        var name = UILabel()
        name.font = .systemFont(ofSize: textSize2, weight: .regular)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private var startTimeTextLabel: UILabel = {
        var startTimeTextLabel = UILabel()
        startTimeTextLabel.text = "Начало:"
        startTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .bold)
        startTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return startTimeTextLabel
    }()
    
    var startTime: UILabel = {
        var startTime = UILabel()
        startTime.font = .systemFont(ofSize: textSize3, weight: .bold)
        startTime.translatesAutoresizingMaskIntoConstraints = false
        return startTime
    }()
    
    private var durationTextLabel: UILabel = {
        var durationTextLabel = UILabel()
        durationTextLabel.text = "Продолжительность:"
        durationTextLabel.font = .systemFont(ofSize: textSize2, weight: .bold)
        durationTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return durationTextLabel
    }()
    
    var duration: UILabel = {
        var duration = UILabel()
        duration.font = .systemFont(ofSize: textSize3, weight: .bold)
        duration.translatesAutoresizingMaskIntoConstraints = false
        return duration
    }()
    
    var definition: UITextView = {
        var definitionT = UITextView()
        definitionT.font = .systemFont(ofSize: textSize3)
        definitionT.backgroundColor = .systemGray6
        definitionT.layer.cornerRadius = totalCornerRadius
//        definitionT.layer.borderWidth = 0.5
//        definitionT.layer.borderColor = UIColor.lightGray.cgColor
        definitionT.translatesAutoresizingMaskIntoConstraints = false
        definitionT.isEditable = false
        return definitionT
    }()
    
    /*
    var name: UITextView = {
        var nameT = UITextView()
        nameT.font = .systemFont(ofSize: textSize4)
        nameT.backgroundColor = .systemGray6
        nameT.translatesAutoresizingMaskIntoConstraints = false
        nameT.isEditable = false
        return nameT
    }()
    
    var definition: UITextView = {
        var definitionT = UITextView()
        definitionT.font = .systemFont(ofSize: textSize4)
        definitionT.backgroundColor = .systemGray6
        definitionT.translatesAutoresizingMaskIntoConstraints = false
        definitionT.isEditable = false
        return definitionT
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
    */
     
    private var button: UIButton = {
        var button = UIButton()
        button.setTitle("Редактировать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        button.roundYeellowButton()
        return button
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: EditTaskProtocol?
    
    
//    MARK: - Layout
    
    private func layout() {
        [screenLabel, name, startTimeTextLabel, startTime, durationTextLabel, duration, definition, button].forEach { addSubview($0) }
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8

        NSLayoutConstraint.activate([
            screenLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            screenLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
             
            name.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: safeIndent1),
            name.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),

            startTimeTextLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: safeIndent1),
            startTimeTextLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),

            startTime.topAnchor.constraint(equalTo: startTimeTextLabel.bottomAnchor, constant: safeIndent2),
            startTime.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),

            durationTextLabel.topAnchor.constraint(equalTo: startTime.bottomAnchor, constant: safeIndent1),
            durationTextLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),

            duration.topAnchor.constraint(equalTo: durationTextLabel.bottomAnchor, constant: safeIndent2),
            duration.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),

            definition.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 3),
            definition.topAnchor.constraint(equalTo: duration.bottomAnchor, constant: safeIndent1),
            definition.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            definition.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            button.topAnchor.constraint(equalTo: definition.bottomAnchor, constant: safeIndent1),
            button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            button.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects)
            
            /*
             viewForTaskName.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 2),
             viewForTaskName.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: safeIndent2),
             viewForTaskName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
             viewForTaskName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
             
             viewForTaskDefinition.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 3),
             viewForTaskDefinition.topAnchor.constraint(equalTo: viewForTaskName.bottomAnchor, constant: safeIndent2),
             viewForTaskDefinition.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
             viewForTaskDefinition.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
             
             name.topAnchor.constraint(equalTo: viewForTaskName.topAnchor),
             name.leadingAnchor.constraint(equalTo: viewForTaskName.leadingAnchor),
             name.trailingAnchor.constraint(equalTo: viewForTaskName.trailingAnchor),
             name.bottomAnchor.constraint(equalTo: viewForTaskName.bottomAnchor),
             
             definition.topAnchor.constraint(equalTo: viewForTaskDefinition.topAnchor),
             definition.leadingAnchor.constraint(equalTo: viewForTaskDefinition.leadingAnchor),
             definition.trailingAnchor.constraint(equalTo: viewForTaskDefinition.trailingAnchor),
             definition.bottomAnchor.constraint(equalTo: viewForTaskDefinition.bottomAnchor),
             
             button.topAnchor.constraint(equalTo: viewForTaskDefinition.bottomAnchor, constant: safeIndent2),
             */
        ])
    }
    
    
//    MARK: - Настройка кнопки

    private func setupButton() {
        button.addTarget(self, action: #selector(editTask), for: .touchUpInside)
    }
    
    @objc private func editTask() {
        delegate?.editTask()
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
