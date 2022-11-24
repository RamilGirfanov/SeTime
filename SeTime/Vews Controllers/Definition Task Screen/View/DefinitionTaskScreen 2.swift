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
    
    private var nameLabel: UILabel = {
        var startTimeTextLabel = UILabel()
        startTimeTextLabel.text = "Название:"
        startTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .bold)
        startTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return startTimeTextLabel
    }()
    
    var name: UILabel = {
        var name = UILabel()
        name.lineBreakMode = .byCharWrapping
        name.numberOfLines = 0
        name.font = .systemFont(ofSize: textSize2, weight: .regular)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private var startTimeLabel: UILabel = {
        var startTimeTextLabel = UILabel()
        startTimeTextLabel.text = "Начало:"
        startTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .bold)
        startTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return startTimeTextLabel
    }()
    
    var startTime: UILabel = {
        var startTime = UILabel()
        startTime.font = .systemFont(ofSize: textSize3, weight: .regular)
        startTime.translatesAutoresizingMaskIntoConstraints = false
        return startTime
    }()
    
    private var durationLabel: UILabel = {
        var durationTextLabel = UILabel()
        durationTextLabel.text = "Продолжительность:"
        durationTextLabel.font = .systemFont(ofSize: textSize2, weight: .bold)
        durationTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return durationTextLabel
    }()
    
    var duration: UILabel = {
        var duration = UILabel()
        duration.font = .systemFont(ofSize: textSize3, weight: .regular)
        duration.translatesAutoresizingMaskIntoConstraints = false
        return duration
    }()
    
    private var definitionLabel: UILabel = {
        var startTimeTextLabel = UILabel()
        startTimeTextLabel.text = "Описание:"
        startTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .bold)
        startTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return startTimeTextLabel
    }()

    var definition: UILabel = {
        var definition = UILabel()
        definition.lineBreakMode = .byCharWrapping
        definition.numberOfLines = 0
        definition.font = .systemFont(ofSize: textSize3, weight: .regular)
        definition.translatesAutoresizingMaskIntoConstraints = false
        return definition
    }()
    
    private var button: UIButton = {
        var button = UIButton()
        button.setTitle("Редактировать", for: .normal)
        button.activeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: EditTaskProtocol?
    
    
//    MARK: - Layout
    
    private func layout() {
        [screenLabel, nameLabel, name, startTimeLabel, startTime, durationLabel, duration, definitionLabel, definition, button].forEach { addSubview($0) }
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8

        NSLayoutConstraint.activate([
            screenLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            screenLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
             
            nameLabel.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: safeIndent1),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            
            name.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: safeIndent2),
            name.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            name.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),

            startTimeLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: safeIndent1),
            startTimeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),

            startTime.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: safeIndent2),
            startTime.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),

            durationLabel.topAnchor.constraint(equalTo: startTime.bottomAnchor, constant: safeIndent1),
            durationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),

            duration.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: safeIndent2),
            duration.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),

            definitionLabel.topAnchor.constraint(equalTo: duration.bottomAnchor, constant: safeIndent1),
            definitionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            
            definition.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: safeIndent2),
            definition.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            definition.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            button.topAnchor.constraint(equalTo: definition.bottomAnchor, constant: safeIndent1),
            button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            button.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects)
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
