//
//  TaskDefinitionScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 17.11.2022.
//

import UIKit

protocol EditTaskProtocol: AnyObject {
    func editTask()
}

class TaskDefinitionScreen: UIView {

//    MARK: - UIObjects
    
    var screenLabel: UILabel = {
        var screenLabel = UILabel()
        screenLabel.text = "Описание"
        screenLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        screenLabel.translatesAutoresizingMaskIntoConstraints = false
        return screenLabel
    }()
    
    var name: UITextView = {
        var nameT = UITextView()
        nameT.font = .systemFont(ofSize: textSize4)
        nameT.backgroundColor = .systemGray6
        nameT.translatesAutoresizingMaskIntoConstraints = false
        return nameT
    }()
    
    var definition: UITextView = {
        var definitionT = UITextView()
        definitionT.font = .systemFont(ofSize: textSize4)
        definitionT.backgroundColor = .systemGray6
        definitionT.translatesAutoresizingMaskIntoConstraints = false
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
    
    var button: UIButton = {
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
        [screenLabel, viewForTaskName, viewForTaskDefinition, button].forEach { addSubview($0) }
        viewForTaskName.addSubview(name)
        viewForTaskDefinition.addSubview(definition)
        
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
            
            name.topAnchor.constraint(equalTo: viewForTaskName.topAnchor),
            name.leadingAnchor.constraint(equalTo: viewForTaskName.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: viewForTaskName.trailingAnchor),
            name.bottomAnchor.constraint(equalTo: viewForTaskName.bottomAnchor),
            
            definition.topAnchor.constraint(equalTo: viewForTaskDefinition.topAnchor),
            definition.leadingAnchor.constraint(equalTo: viewForTaskDefinition.leadingAnchor),
            definition.trailingAnchor.constraint(equalTo: viewForTaskDefinition.trailingAnchor),
            definition.bottomAnchor.constraint(equalTo: viewForTaskDefinition.bottomAnchor),
            
            button.topAnchor.constraint(equalTo: viewForTaskDefinition.bottomAnchor, constant: safeIndent2),
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
